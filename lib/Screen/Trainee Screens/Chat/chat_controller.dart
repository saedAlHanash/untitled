// import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Repositories/chat_repository.dart';
import 'package:fitness_storm/Model/chat.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final RxBool _isLoading = false.obs;
  final List<Chat> chats = [];
  final ChatRepository _chatRepository = ChatRepository();

  bool get isLoading => _isLoading.value;

  set isLoading(value) => _isLoading.value = value;

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading = true;
    await getChats();
    isLoading = false;
  }

  getChats() async {
    if (chats.isEmpty) {
      chats.addAll(await _chatRepository.getAllPreviousChats());
    }
    return chats;
  }

  getAllChats() async {
    isLoading = true;
    await getChats();
    isLoading = false;
  }

  Future<int> getChannelIdCustomerServices() async {
    return 0;
  }

  sendMessage(String channelId, String message) async {
    // ApiResult apiResult = await _chatRepository.sendMessage(
    //     channelId: channelId, message: message);
    // // if(apiResult.message =)
  }
}
