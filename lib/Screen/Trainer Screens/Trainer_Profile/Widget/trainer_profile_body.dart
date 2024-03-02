// import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee_Profile/Widget/profile_card.dart';
// import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer_Profile/Widget/trainer_profile_card.dart';
// import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer_Profile/trainer_profile_controller.dart';
// import 'package:fitness_storm/Widgets/language_board_widget.dart';
// import 'package:fitness_storm/core/util/bottom_sheets.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../generated/assets.dart';
//
// class TrainerProfileBody extends GetWidget<TrainerProfileController> {
//   const TrainerProfileBody({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       // height: Get.height / 4.7,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           SizedBox(
//             width: Get.width,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TrainerProfileCard(
//                     imageUrl: 'asset/Images/profile_info.svg',
//                     title: 'Trainer_Profile'.tr,
//                     onTap: controller.onTrainerProfileButtonPressed),
//                 ProfileCard(
//                     imageUrl: Assets.imagesLanguage,
//                     iconColor: Color(0xFF565C63),
//                     title: 'lang'.tr,
//                     onTap: () {
//                       BottomSheets.languageBottomSheet(
//                         LanguageBoardWidget(),
//                       );
//                     })
//               ],
//             ),
//           ),
//           // SizedBox(height: Get.height / 40.6)
//         ],
//       ),
//     );
//   }
// }
