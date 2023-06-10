import 'dart:developer';

import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Repositories/chat_repository.dart';
import 'package:fitness_storm/Model/chat.dart';
import 'package:fitness_storm/Model/conversation.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Chat/chat_controller.dart';
import 'package:fitness_storm/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ConversationController extends GetxController {
  late String trainerName;
  late String channelId;
  late String message;
  TextEditingController messageController = TextEditingController();
  final RxList<Conversation> _conversations = <Conversation>[].obs;
  final RxBool _isLoaing = false.obs;
  int _pageNumber = 1;

  List<Conversation> get conversation => _conversations;

  bool get isLoading => _isLoaing.value;

  set conversation(value) => _conversations.value = value;

  set isLoading(value) => _isLoaing.value = value;

  final ChatRepository _chatRepository = ChatRepository();

  @override
  Future<void> onInit() async {
    super.onInit();
    trainerName = Get.arguments[0];
    channelId = Get.arguments[1];
    if (Get.arguments.length > 2)
      message = Get.arguments[2];
    else
      message = '';

    if (channelId == "-10") {
      List<Chat> chats = [];
      if (Get.isRegistered<ChatController>()) {
        try {
          chats = await Get.find<ChatController>().getChats();
        } catch (e) {
          print("object");
        }
      } else {
        try {
          chats = await Get.put(ChatController()).getChats() ?? [];
        } catch (e) {
          print("object");
        }
      }

      channelId = chats
          .firstWhere((element) => element.trainer!.name == trainerName)
          .toString();
    }
    await getAllConversation();

    isLoading = true;
    // conversation = conversation.reversed.toList();
    isLoading = false;
    if (message != '') {
      messageController = TextEditingController(text: message);
      onSendMessage();
    }
  }

  getAllConversation() async {
    conversation = await _chatRepository.getConversation(
        pageNumber: _pageNumber, channelId: channelId);
    _pageNumber++;
  }

  onSendMessage({String? channelId}) async {
    if (channelId != null) {
      messageController.text = "test subscription";
      if (messageController.text.isEmpty) return;
      log('isNotEmpty');

      String message = messageController.text;
      messageController.text = '';
      final res = await _chatRepository.sendMessage(
          channelId: channelId, message: message);
      if (res.type == ApiResultType.success) {
        conversation.insert(
            0, Conversation(message: message, senderType: 'user'));
        messageController.text = '';
        _conversations.refresh();
      } else {
        throw res.message!;
      }
    } else {
      if (messageController.text.isEmpty) return;
      log('isNotEmpty');

      String message = messageController.text;
      messageController.text = '';
      final res = await _chatRepository.sendMessage(
          channelId: this.channelId, message: message);
      if (res.type == ApiResultType.success) {
        conversation.insert(
            0, Conversation(message: message, senderType: 'user'));
        messageController.text = '';
        _conversations.refresh();
      } else {
        log(res.type.toString());
        log(res.message.toString());
        Utils.openSnackBar(title: res.message!);
      }
    }
  }
}

class Authentication {
  int max = 1000;
  List<String> userids = [];
  List<String> passwords = [];

  bool verfiy(String uid, String pwd) {
    bool result = false;
    int i = 0;
    while (result == false && i < max) {
      if (userids[i] == uid && passwords[i] == pwd) {
        result = true;
      }
      i++;
    }
    return result;
  }
}
