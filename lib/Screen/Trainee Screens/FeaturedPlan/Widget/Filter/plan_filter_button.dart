// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class PlanFilterButton extends StatelessWidget {
//   const PlanFilterButton(
//       {super.key,
//       required this.text,
//       required this.controller,
//       required this.isTrainingType,
//       required this.onTap});
//
//   final bool controller;
//   final bool isTrainingType;
//   final Function onTap;
//   final String text;
//
//   @override
//   Widget build(BuildContext context) {
//     return isTrainingType
//         ? GestureDetector(
//             onTap: () => onTap(),
//             child: Container(
//               height: Get.height / 21,
//               decoration: BoxDecoration(
//                   border: Border.all(
//                     color: controller
//                         ? Get.theme.colorScheme.secondary
//                         : const Color(0xFFD1D1D1),
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                   color: controller
//                       ? Get.theme.colorScheme.secondary
//                       : Colors.white),
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                   child: Text(
//                     text,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color:
//                           controller ? Colors.white : const Color(0xFF565C63),
//                       fontWeight: FontWeight.bold,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           )
//         : Expanded(
//             flex: 5,
//             child: GestureDetector(
//               onTap: () => onTap(),
//               child: Container(
//                 height: Get.height / 21,
//                 decoration: BoxDecoration(
//                     border: Border.all(
//                       color: controller
//                           ? Get.theme.colorScheme.secondary
//                           : const Color(0xFFD1D1D1),
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                     color: controller
//                         ? Get.theme.colorScheme.secondary
//                         : Colors.white),
//                 child: Center(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                     child: Text(
//                       text,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color:
//                             controller ? Colors.white : const Color(0xFF565C63),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ));
//   }
// }
