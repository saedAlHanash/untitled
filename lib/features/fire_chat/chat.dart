import 'dart:io';

import 'package:drawable_text/drawable_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/features/fire_chat/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/helper/launcher_helper.dart';
import '../../core/injection/injection_container.dart';
import '../../core/strings/app_color_manager.dart';
import '../../core/util/firebase_analytics_service.dart';
import '../../core/widgets/app_bar/app_bar_widget.dart';
import '../../services/chat_service/core/firebase_chat_core.dart';
import 'messages_bloc/messages_cubit.dart';
import 'my_room_object.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.room,
  });

  final types.Room room;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // late final
  List<types.Message>? initialMessage;

  late final MyRoomObject myRoomObject;

  @override
  void initState() {
    myRoomObject = MyRoomObject(
      roomId: widget.room.id,
      fcmToken: (widget.room.otherUser.metadata ?? {})['fcm'] ?? '',
      fcmTokenWeb: (widget.room.otherUser.metadata ?? {})['fcm_web'] ?? '',
    );

    sl<AnalyticService>()
        .contactTrainerOrUser(name: widget.room.otherUser.name, method: 'chat');
    context.read<MessagesCubit>().getChatRoomMessage(widget.room);
    super.initState();
  }

  bool _isAttachmentUploading = false;

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      _setAttachmentUploading(true);
      final name = result.files.single.name;
      final filePath = result.files.single.path!;
      final file = File(filePath);

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialFile(
          mimeType: lookupMimeType(filePath),
          name: name,
          size: result.files.single.size,
          uri: uri,
        );

        FirebaseChatCore.instance.sendMessage(message, widget.room.id);
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      _setAttachmentUploading(true);
      final file = File(result.path);
      final size = file.lengthSync();
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final name = result.name;

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialImage(
          height: image.height.toDouble(),
          name: name,
          size: size,
          uri: uri,
          width: image.width.toDouble(),
        );

        FirebaseChatCore.instance.sendMessage(
          message,
          widget.room.id,
        );
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final updatedMessage = message.copyWith(isLoading: true);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final updatedMessage = message.copyWith(isLoading: false);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance.updateMessage(updatedMessage, widget.room.id);
  }

  void _handleSendPressed(types.PartialText message) {
    if (myRoomObject.needToSendNotification) {
      sendNotificationMessage(
        myRoomObject,
        ChatNotification(
          body: message.text,
          title: 'رسالة جديدة',
          fcm: myRoomObject.fcmToken,
          fcmWeb: myRoomObject.fcmTokenWeb,
        ),
      ).then(
        (value) {
          if (value) {
            ///for send notification to first message
            myRoomObject.needToSendNotification = false;
          }
        },
      );
    }

    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        actions: [
          Row(
            children: [
              DrawableText(
                text: widget.room.otherUser.name,
                color: Colors.white,
              ),
              10.0.horizontalSpace,
              CircleImageWidget(
                url: widget.room.otherUser.imageUrl,
                size: 40.0.r,
              ),
              10.0.horizontalSpace,
            ],
          ),
        ],
      ),
      body: BlocBuilder<MessagesCubit, MessagesInitial>(
        builder: (context, state) {
          return Chat(
            textMessageOptions: TextMessageOptions(
              onLinkPressed: (p0) {
                LauncherHelper.openPage(p0);
              },
            ),
            isAttachmentUploading: _isAttachmentUploading,
            messages: state.result,
            onAttachmentPressed: _handleAtachmentPressed,
            onMessageTap: _handleMessageTap,
            onPreviewDataFetched: _handlePreviewDataFetched,
            onSendPressed: _handleSendPressed,
            theme: const DarkChatTheme(
                backgroundColor: Colors.white,
                primaryColor: AppColorManager.mainColor,
                secondaryColor: AppColorManager.mainColorDark,
                inputBackgroundColor: AppColorManager.mainColor),
            user: types.User(id: AppProvider.myId),
          );
        },
      ),
    );
  }
}
