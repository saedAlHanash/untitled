// import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Overview/trainer_overview_controller.dart';
// import 'package:fitness_storm/Utils/Routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'bio_check_widget.dart';
//
// class TrainerBioWidget extends GetWidget<TrainerTrainerOverviewController> {
//   final String trainerBio;
//   final String numberOfPlans;
//   final String numberOfSubscribers;
//   final String numberOfPrivateHours;
//   final String privateSessionPrice;
//
//   const TrainerBioWidget({
//     super.key,
//     required this.trainerBio,
//     required this.numberOfPlans,
//     required this.numberOfSubscribers,
//     required this.numberOfPrivateHours,
//     required this.privateSessionPrice,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: Get.height / 20.3,
//           color: Get.theme.primaryColor,
//           padding: EdgeInsets.symmetric(horizontal: Get.width / 18.75),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'book_private_session'.tr,
//                 style: TextStyle(color: Colors.white, fontSize: 14),
//               ),
//               const SizedBox.shrink(),
//               InkWell(
//                 onTap: () => Get.toNamed(AppRoutes.bookPrivateSession,
//                     arguments: [
//                       controller.trainer.name,
//                       controller.trainer.image,
//                       controller.trainer.id.toString()
//                     ]),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       '${privateSessionPrice}  ' + 'sar/hour'.tr,
//                       style: const TextStyle(color: Colors.white, fontSize: 14),
//                     ),
//                     IconButton(
//                       padding: EdgeInsets.zero,
//                       onPressed: () => Get.toNamed(AppRoutes.bookPrivateSession,
//                           arguments: [
//                             controller.trainer.name,
//                             controller.trainer.image,
//                             controller.trainer.id.toString()
//                           ]),
//                       icon: const Icon(
//                         Icons.arrow_forward_ios,
//                         color: Colors.white,
//                         size: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//         Container(
//           color: const Color(0xFF9F86C1),
//           width: Get.width,
//           padding: EdgeInsets.symmetric(vertical: Get.height / 27),
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: Get.width / 18.75),
//                 width: Get.width,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     BioCheckWidget(
//                         title: 'WORKOUT_PLANS'.tr, value: numberOfPlans),
//                     BioCheckWidget(
//                         title: 'SUBSCRIBERS_cap'.tr,
//                         value: numberOfSubscribers),
//                     BioCheckWidget(
//                         title: 'private_hours'.tr,
//                         value: '+$numberOfPrivateHours'),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                   top: Get.height / 27,
//                   left: Get.width / 16,
//                   right: Get.width / 16,
//                 ),
//                 child: Center(
//                   child: Text(
//                     trainerBio,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(fontSize: 14, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
