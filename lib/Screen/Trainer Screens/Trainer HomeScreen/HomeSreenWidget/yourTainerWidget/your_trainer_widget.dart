// // ignore_for_file: invalid_use_of_protected_member
//
// import 'package:fitness_storm/Model/trainer.dart';
// import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/HomeSreenWidget/yourTainerWidget/your_trainer_item.dart';
// import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20HomeScreen/trainer_home_screen_controller.dart';
// import 'package:fitness_storm/Utils/Routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../Trainee Screens/HomeScreen/HomeSreenWidget/yourTainerWidget/your_trainer_widget.dart';
// import '../list_header.dart';
//
// class YourTrainersWidget extends GetWidget<TrainerHomeScreenController> {
//   const YourTrainersWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ListHeader(
//             headerTitle: 'Private_Training'.tr,
//             seeAllFunction: () => Get.toNamed(AppRoutes.yourTrainerScreen,
//                 arguments: controller.yourTrainer)),
//         _buildYourTrainersList(
//           trainers: controller.yourTrainer.value
//               .getRange(0,
//                   controller.yourTrainer.length > 3 ? 3 : controller.yourTrainer.length)
//               .toList(),
//         )
//       ],
//     );
//   }
//
//   Function pushYourTrainersScreen(List<TrainerModel> trainers) {
//     return () {
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(
//       //     builder: (context) => BlocProvider<TrainerBloc>(
//       //       create: (context) => TrainerBloc(),
//       //       child: YourTrainersScreen(trainers: trainers),
//       //     ),
//       //   ),
//       // );
//     };
//   }
//
//   Widget _buildYourTrainersList({required List<TrainerModel> trainers}) {
//     return SizedBox(
//       width: MediaQuery.of(Get.context!).size.width,
//       height: MediaQuery.of(Get.context!).size.height / 3,
//       child: ListView.builder(
//         shrinkWrap: true,
//         scrollDirection: Axis.horizontal,
//         itemCount: trainers.length,
//         itemBuilder: (context, i) {
//           return GestureDetector(
//             onTap: () => startTrainerPage(context, trainers[i].id),
//             child: YourTrainersItem(
//               trainerImageUrl: trainers[i].image,
//               trainerName: trainers[i].name,
//               numberOfPlans: trainers[i].numberOfPlans.toString(),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
