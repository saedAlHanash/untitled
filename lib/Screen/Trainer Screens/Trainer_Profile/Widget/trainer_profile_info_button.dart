// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../Utils/Routes/app_pages.dart';
// import '../../../Trainee Screens/Trainee_Profile/Widget/info_button.dart';
//
// class TrainerProfileInfoButton extends StatelessWidget {
//   const TrainerProfileInfoButton({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Expanded(
//               child: InfoButton(
//                 title: 'about_us'.tr,
//                 onTap: () {
//                   Get.toNamed(AppRoutes.aboutAs);
//                 },
//               ),
//             ),
//             SizedBox(width: Get.width / 30),
//             Expanded(
//               child: InfoButton(
//                 title: 'privacy_policy'.tr,
//                 onTap: () {
//                   Get.toNamed(AppRoutes.privacyPolicy);
//                 },
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Expanded(
//               child: InfoButton(
//                 title: 'FAQs'.tr,
//                 onTap: () {
//                   Get.toNamed(AppRoutes.FAQs);
//                 },
//               ),
//             ),
//             SizedBox(width: Get.width / 40),
//             Expanded(
//               child: InfoButton(
//                 title: 'Terms_and_Condition'.tr,
//                 onTap: () {
//                   Get.toNamed(AppRoutes.termsAndCondition);
//                 },
//               ),
//             ),
//             SizedBox(width: Get.width / 40),
//           ],
//         ),
//       ],
//     );
//     // return Row(
//     //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//     //   children: [
//     //     const TrainerInfoButton(title: 'About us'),
//     //     SizedBox(width: Get.width / 50),
//     //     const TrainerInfoButton(title: 'FAQs'),
//     //     SizedBox(width: Get.width / 50),
//     //     const TrainerInfoButton(title: 'Privacy Policy'),
//     //   ],
//     // );
//   }
// }
