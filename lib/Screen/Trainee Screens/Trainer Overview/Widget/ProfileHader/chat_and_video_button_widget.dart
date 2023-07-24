// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ChatAndVideoButtonWidget extends StatelessWidget {
//   const ChatAndVideoButtonWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         GestureDetector(
//           child: Container(
//             height: Get.height / 27,
//             width: Get.width / 12.5,
//             // padding: EdgeInsets.all(2),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               color: Get.theme.colorScheme.secondary,
//             ),
//             child: Image.asset(
//               'asset/Images/chat3.png',
//             ),
//           ),
//         ),
//         const SizedBox(),
//         Container(
//           height: Get.height / 27,
//           width: Get.width / 2.5,
//           // padding: EdgeInsets.all(2),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             color: Get.theme.colorScheme.secondary,
//           ),
//           child: Row(
//             // mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               const SizedBox(width: 4),
//               Image.asset(
//                 'asset/Images/video.png',
//               ),
//               const SizedBox(width: 4),
//               FittedBox(
//                 child: Text(
//                   'start_private_session'.tr,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 8.5,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
