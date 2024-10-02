// import 'package:fitness_storm/Screen/Trainee%20Screens/FeaturedPlan/featured_plan_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'plan_filter_button.dart';
//
// // ignore: must_be_immutable
// class TrainingTypeFilterWidget extends GetWidget<FeaturedPlanController> {
//   TrainingTypeFilterWidget({super.key});
//
//   int index = -1;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           'TRAINING_TYPE'.tr,
//           style: const TextStyle(
//               color: Color(0xFFA8A5A5),
//               fontSize: 14,
//               fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: Get.height / 81.2),
//         SizedBox(
//             height: MediaQuery.of(context).size.height * 0.37,
//             child: GridView.builder(
//               shrinkWrap: true,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   childAspectRatio: 5 / 2,
//                   crossAxisSpacing: Get.size.width / 50,
//                   mainAxisSpacing: Get.size.height / 70),
//               itemCount: controller.appController.trainingTypes.length,
//               itemBuilder: (context, index) {
//                 return Obx(
//                   () => PlanFilterButton(
//                     controller: controller.trainingTypesControllers[index],
//                     text: controller.appController.trainingTypes[index].type,
//                     onTap: () => controller.toggleTrainingType(index),
//                     isTrainingType: true,
//                   ),
//                 );
//               },
//             )),
//         //-------
//       ],
//     );
//   }
// }
