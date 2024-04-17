// import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee_Profile/Widget/profile_card.dart';
// import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee_Profile/trainee_profile_controller.dart';
// import 'package:fitness_storm/Widgets/language_board_widget.dart';
// import 'package:fitness_storm/common/bottom_sheets.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../generated/assets.dart';
//
// class TraineeProfileBody extends  StatelessWidget {
//   const TraineeProfileBody({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: Get.height / 3.2,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           SizedBox(
//             width: Get.width,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ProfileCard(
//                     imageUrl: 'asset/Images/profile_info.svg',
//                     title: 'profile_info'.tr,
//                     onTap: controller.onProfileInfoClick),
//                 ProfileCard(
//                     imageUrl: 'asset/Images/bookmark.svg',
//                     title: 'Bookmarked'.tr,
//                     onTap: controller.onBookmarkedClick)
//               ],
//             ),
//           ),
//           SizedBox(
//             width: Get.width,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ProfileCard(
//                     imageUrl: 'asset/Images/payment.svg',
//                     title: 'my_payments'.tr,
//                     onTap: controller.onMyPaymentsClick),
//
//                 // ProfileCard(
//                 //     imageUrl: 'asset/Images/profile_info.svg',
//                 //     title: 'Contact_Us'.tr,
//                 //     onTap: controller.onContactUsClick)
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
//           )
//         ],
//       ),
//     );
//   }
// }
