// import 'package:dio/dio.dart';
// import 'package:fitness_storm/Data/Api/api_result.dart';
// import 'package:fitness_storm/Data/Api/methods.dart';
// import 'package:fitness_storm/Data/Api/urls.dart';
// import 'package:fitness_storm/Model/chat.dart';
// import 'package:fitness_storm/Model/conversation.dart';
// import 'package:fitness_storm/Utils/utils.dart';
//
// import '../../core/app/app_provider.dart';
//
// class ChatRepository {
//   Future<List<Chat>> getAllPreviousChats() async {
//     Options option = Utils.getOptions(withToken: true, all: true);
//
//
//     List<Chat> exercise = [];
//     String url = '';
//     if ( AppProvider.isTrainer) {
//       url = TRAINERURLS.allChatsTrainer;
//     } else {
//       url = TRAINEEURLS.allChats;
//     }
//     ApiResult response = await Methods.get(url: url, options: option);
//     //log(response.data.toString());
//     if (response.type == ApiResultType.success) {
//       response.data.forEach((element) {
//         exercise.add(Chat.fromJson(element));
//       });
//     }
//
//     return exercise;
//   }
//
//   Future<List<Conversation>> getConversation(
//       {required int pageNumber, required String channelId}) async {
//
//     Options option = Utils.getOptions(withToken: true, all: true);
//     ApiResult result;
//     if (channelId == "-1") {
//       result = await Methods.get(
//           url: 'https://api.fitnessstorm.org/mobile/user/supportChat', options: option);
//     } else {
//       String url2 = '';
//       if ( AppProvider.isTrainer) {
//         url2 = TRAINERURLS.getConversation(channelId);
//       } else {
//         url2 = TRAINEEURLS.getConversation(channelId);
//       }
//       result = await Methods.get(url: '$url2?page=$pageNumber', options: option);
//     }
//     if (result.type == ApiResultType.success) {
//       List<Conversation> conversation = [];
//       for (var element in result.data) {
//         conversation.add(Conversation.fromJson(element));
//       }
//       return conversation;
//     } else {
//       throw result.message!;
//     }
//   }
//
//   Future<ApiResult> sendMessage(
//       {required String channelId, required String message}) async {
//
//     String url2 = '';
//     if ( AppProvider.isTrainer) {
//       url2 = TRAINERURLS.sendMessage(channelId);
//     } else {
//       url2 = TRAINEEURLS.sendMessage(channelId);
//     }
//     Options options = Utils.getOptions(all: true);
//     ApiResult result;
//     if (channelId == "-1") {
//       result = await Methods.post(
//           url: TRAINEEURLS.sendMessageToCustomerService(),
//           data: {"message": message},
//           options: options);
//     } else {
//       result =
//           await Methods.post(url: url2, data: {"message": message}, options: options);
//     }
//     return result;
//   }
// }
