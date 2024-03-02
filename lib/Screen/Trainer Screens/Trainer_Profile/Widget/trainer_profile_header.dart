// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer_Profile/trainer_profile_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class TrainerProfileHeader extends GetView<TrainerProfileController> {
//   const TrainerProfileHeader({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         SizedBox(height: Get.height / 10.3),
//         Container(
//           width: Get.width / 4,
//           height: Get.width / 4,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(100),
//             border: Border.all(width: 2, color: Colors.white),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 0.1,
//                 blurRadius: 8,
//                 offset: const Offset(0, 10), // changes position of shadow
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(100),
//             child: CachedNetworkImage(
//               imageUrl:
//                   (controller.trainerProfile?.image.toString() ?? ''),
//               fadeInDuration: const Duration(seconds: 1),
//               placeholder: (context, url) => const CircularProgressIndicator.adaptive(),
//               errorWidget: (context, url, error) =>
//                   Image.asset('asset/Images/user.png', fit: BoxFit.fill),
//             ),
//           ),
//         ),
//         SizedBox(height: Get.height / 27),
//         Text(
//           controller.trainerProfile?.name ?? '',
//           style: TextStyle(
//               fontSize: 26, color: Get.theme.primaryColor, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: Get.height / 67.7),
//         GestureDetector(
//           onTap: controller.logout,
//           child: FittedBox(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'sign_out'.tr,
//                   style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 16),
//                 ),
//                 SizedBox(width: Get.width / 50),
//                 const Icon(Icons.logout_outlined, color: Color(0xFFA0A0A0))
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: Get.height / 27),
//       ],
//     );
//   }
// }
