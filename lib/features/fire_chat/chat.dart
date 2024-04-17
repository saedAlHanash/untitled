import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:fitness_storm/core/helper/launcher_helper.dart';
import 'package:fitness_storm/core/util/firebase_analytics_service.dart';
import 'package:fitness_storm/features/fire_chat/room_messages_bloc/room_messages_cubit.dart';
import 'package:fitness_storm/features/fire_chat/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/injection/injection_container.dart';
import '../../main.dart';
import 'get_chats_rooms_bloc/get_rooms_cubit.dart';
import 'my_room_object.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.room,
    required this.name,
  });

  final types.Room room;

  final String name;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // late final
  List<types.Message>? initialMessage;

  late final MyRoomObject myRoomObject;

  late final MessagesCubit roomMessagesCubit;

  @override
  void initState() {
    roomMessagesCubit = context.read<MessagesCubit>();
    roomMessagesCubit.getChatRoomMessage(widget.room);

    myRoomObject = MyRoomObject(
      roomId: widget.room.id,
      fcmToken: (getChatMember(widget.room.users).metadata ?? {})['fcm'] ?? '',
      fcmTokenWeb: (getChatMember(widget.room.users).metadata ?? {})['fcm_web'] ?? '',
    );
    sl<FirebaseAnalyticService>().contactTrainerOrUser(name: widget.name, method: 'chat');
    super.initState();
  }

  Future<void> onClosePage() async {
    if (roomMessagesCubit.state.allMessages.isNotEmpty) {
      final m = roomMessagesCubit.state.allMessages.first;

      await latestUpdateMessagesBox.put(roomMessagesCubit.state.roomId, m.updatedAt ?? 0);

      final roomJson = roomsBox.get(roomMessagesCubit.state.roomId);
      if (roomJson == null) return;

      var room = types.Room.fromJson(jsonDecode(roomJson));

      if (room.updatedAt == m.updatedAt) return;

      room = room.copyWith(updatedAt: m.updatedAt);

      await roomsBox.put(roomMessagesCubit.state.roomId, jsonEncode(room));

      if (mounted) {
        context.read<RoomsCubit>().updateRooms();
      }
    }
  }

  @override
  void deactivate() {
    onClosePage();
    super.deactivate();
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
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(widget.name),
      ),
      body: BlocBuilder<MessagesCubit, MessagesInitial>(
        builder: (context, state) {
          return Chat(
            isAttachmentUploading: _isAttachmentUploading,
            messages: state.allMessages,
            onAttachmentPressed: _handleAtachmentPressed,
            onMessageTap: _handleMessageTap,
            textMessageOptions: TextMessageOptions(
              onLinkPressed: (p0) {
                LauncherHelper.openPage(p0);
              },
            ),
            onPreviewDataFetched: _handlePreviewDataFetched,
            onSendPressed: _handleSendPressed,
            theme: const DarkChatTheme(backgroundColor: Colors.white),
            user: types.User(
              id: firebaseUser?.uid ?? '',
            ),
          );
        },
      ),
    );
  }
}
