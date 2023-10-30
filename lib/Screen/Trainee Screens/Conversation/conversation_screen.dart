// import 'package:fitness_storm/Screen/Trainee%20Screens/Conversation/Widget/conversation_list.dart';
// import 'package:fitness_storm/Screen/Trainee%20Screens/Conversation/Widget/conversation_text_feild.dart';
// import 'package:fitness_storm/Screen/Trainee%20Screens/Conversation/conversation_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ConversationScreen extends GetView<ConversationController> {
//   const ConversationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Scaffold(
//           appBar: AppBar(
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//               onPressed: () => Get.back(),
//             ),
//             title: Text(controller.trainerName),
//             titleTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           body: controller.isLoading
//               ? const Center(child: CircularProgressIndicator.adaptive())
//               : RefreshIndicator(
//                   color: Colors.white,
//                   onRefresh: () async {
//                     controller.getAllConversation();
//                   },
//                   child: const Column(
//                     children: [
//                       Expanded(child: ConversationList()),
//                       ConversationTextFeild()
//                     ],
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }
