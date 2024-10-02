// import 'package:fitness_storm/Screen/Trainee%20Screens/FeaturedPlan/featured_plan_controller.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// import 'plan_filter_button.dart';
//
// class FitnessLevelFilterWidget extends GetWidget<FeaturedPlanController> {
//   const FitnessLevelFilterWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             'FITNESS_LEVEL'.tr,
//             style: const TextStyle(
//                 color: Color(0xFFA8A5A5),
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: Get.height / 81),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               PlanFilterButton(
//                 text: 'beginner'.tr,
//                 controller: controller.beginnerController,
//                 onTap: controller.toggleBeginner,
//                 isTrainingType: false,
//               ),
//               const Expanded(child: SizedBox()),
//               PlanFilterButton(
//                 text: 'intermediate'.tr,
//                 controller: controller.intermediateController,
//                 onTap: controller.toggleIntermediate,
//                 isTrainingType: false,
//               ),
//               const Expanded(child: SizedBox()),
//               PlanFilterButton(
//                 text: 'advanced'.tr,
//                 controller: controller.advancedController,
//                 onTap: controller.toggleAdvanced,
//                 isTrainingType: false,
//               )
//             ],
//           ),
//           SizedBox(height: Get.height / 20.3),
//         ],
//       ),
//     );
//   }
// }
