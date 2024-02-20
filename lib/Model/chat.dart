// import 'package:fitness_storm/core/extensions/extensions.dart';
//
// class Chat {
//   Trainer? trainer;
//   String? channelId;
//   LastMessage? lastMessage;
//
//   Chat({this.trainer, this.channelId, this.lastMessage});
//
//   Chat.fromJson(Map<String, dynamic> json) {
//     trainer = (json['trainer'] != null || json['user'] != null)
//         ? Trainer.fromJson(json['trainer'] ?? json['user'])
//         : null;
//     channelId = json['channel_id'];
//     lastMessage = json['last_message'] != null
//         ? LastMessage.fromJson(json['last_message'])
//         : LastMessage(message: '');
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (trainer != null) {
//       data['trainer'] = trainer!.toJson();
//     }
//     data['channel_id'] = channelId;
//     if (lastMessage != null) {
//       data['last_message'] = lastMessage!.toJson();
//     }
//     return data;
//   }
// }
//
//
// class LastMessage {
//   int? id;
//   String? message;
//   String? senderType;
//   String? createdAt;
//
//   LastMessage({this.id, this.message, this.senderType, this.createdAt});
//
//   LastMessage.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     message = json['message'];
//     senderType = json['sender_type'];
//     createdAt = json['created_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['message'] = message;
//     data['sender_type'] = senderType;
//     data['created_at'] = createdAt;
//     return data;
//   }
// }
