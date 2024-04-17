// import 'package:fitness_storm/Screen/Trainee%20Screens/Conversation/conversation_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class ConversationList extends GetView<ConversationController> {
//   const ConversationList({super.key});
//
//   launchURL(String urlText) async {
//     Uri url = Uri.parse(urlText);
//     if (await launchUrl(url)) {
//       await launchUrl(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => ListView.builder(
//         itemCount: controller.conversation.length,
//         shrinkWrap: true,
//         reverse: true,
//         padding: const EdgeInsets.only(top: 10, bottom: 10),
//         itemBuilder: (context, index) {
//           return Container(
//             padding:
//                 const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
//             child: Align(
//               alignment: (controller.conversation[index].senderType == "user"
//                   ? Alignment.topRight
//                   : Alignment.topLeft),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                       bottomLeft: const Radius.circular(12),
//                       bottomRight: const Radius.circular(12),
//                       topLeft: Radius.circular(
//                           controller.conversation[index].senderType == "user"
//                               ? 20
//                               : 0),
//                       topRight: Radius.circular(
//                           controller.conversation[index].senderType == "user"
//                               ? 0
//                               : 20)),
//                   color: (controller.conversation[index].senderType == "user"
//                       ? const Color(0xFFD1D1D1)
//                       : const Color(0xFF85D2DB)),
//                 ),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: controller.conversation[index].message!.contains('https')
//                     ? InkWell(
//                         onTap: () async {
//                           await launchURL(
//                               controller.conversation[index].message!);
//                         },
//                         child: Text(
//                           controller.conversation[index].message!,
//                           style: const TextStyle(
//                             shadows: [
//                               Shadow(color: Colors.black, offset: Offset(0, -5))
//                             ],
//                             fontWeight: FontWeight.w600,
//                             color: Colors.transparent,
//                             decoration: TextDecoration.underline,
//                             decorationThickness: 1,
//                           ),
//                         ),
//                       )
//                     : Text(
//                         controller.conversation[index].message!,
//                         style: const TextStyle(fontSize: 15),
//                       ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
