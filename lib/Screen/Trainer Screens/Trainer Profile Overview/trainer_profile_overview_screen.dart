// import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Profile%20Overview/Widget/trainer_profile_overview_bio.dart';
// import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Profile%20Overview/Widget/trainer_profile_overview_header.dart';
// import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Profile%20Overview/trainer_profile_overview_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class TrainerProfileOverviewScreen
//     extends GetView<TrainerProfileOverviewController> {
//   const TrainerProfileOverviewScreen({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('my_profile'.tr,
//             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () => Get.back(),
//         ),
//       ),
//       body: controller.isLoading
//           ? const Center(child: CircularProgressIndicator.adaptive())
//           : SingleChildScrollView(
//               child: Column(
//                 children: [
//                   TrainerProfileOverviewHeader(
//                       imageUrl: controller.trainer.image,
//                       trainerName: controller.trainer.name),
//                   TrainerProfileOverviewBio(
//                     trainerBio: controller.trainer.bio +
//                         controller.trainer.bio +
//                         controller.trainer.bio +
//                         controller.trainer.bio +
//                         controller.trainer.bio,
//                     // privateSessionPrice: controller.trainer.privateSessionPrice!.toString(),
//                     numberOfPlans: controller.trainer.numberOfPlans.toString(),
//                     numberOfPrivateHours:
//                         controller.trainer.numberOfPrivateHours.toString(),
//                     numberOfSubscribers:
//                         controller.trainer.numberOfSubscribers.toString(),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
