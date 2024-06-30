// import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/home_screen_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_multi_type/image_multi_type.dart';
//
// class ContinueTrainingItem extends GetView<HomeScreenController> {
//   // final String trainerName;
//
//   const ContinueTrainingItem({
//     super.key,
//     required this.planImageUrl,
//     required this.planName,
//     required this.planProgress,
//     required this.nextDayNumber,
//     // required this.trainerName,
//   });
//
//   final int nextDayNumber;
//   final String planImageUrl;
//   final String planName;
//   final double planProgress;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Stack(
//           children: [
//             ImageMultiType(
//               url: planImageUrl,
//               fit: BoxFit.fitWidth,
//             ),
//             Positioned(
//               top: 18,
//               left: Get.width / 80,
//               child: Container(
//                 height: Get.height / 26,
//                 padding: EdgeInsets.all(Get.width / 100),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(7),
//                     color: Colors.black.withOpacity(0.6)),
//                 child: Row(
//                   children: [
//                     Text(
//                       '${(planProgress * 100).round()}% ' + 'completed'.tr,
//                       style: const TextStyle(color: Colors.white),
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//         Padding(
//           padding: Get.locale?.languageCode == 'en'
//               ? EdgeInsets.only(
//                   top: 10, left: MediaQuery.of(context).size.width * 0.03)
//               : EdgeInsets.only(
//                   top: 10, right: MediaQuery.of(context).size.width * 0.03),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               FittedBox(
//                 child: Text(
//                   planName,
//                   style: TextStyle(
//                     color: Get.theme.colorScheme.secondary,
//                     fontSize: 14.0,
//                   ),
//                 ),
//               ),
//               FittedBox(
//                   child: Text('next_up'.tr + ' : Day $nextDayNumber',
//                       style: TextStyle(color: Get.theme.primaryColor)))
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
