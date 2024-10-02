// import 'package:fitness_storm/Screen/Trainee%20Screens/FeaturedPlan/featured_plan_controller.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// import 'plan_filter_button.dart';
//
// class LocationFilterWidget extends GetWidget<FeaturedPlanController> {
//   const LocationFilterWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             'LOCATION'.tr,
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
//                 text: 'home'.tr,
//                 controller: controller.homeController,
//                 onTap: controller.toggleHome,
//                 isTrainingType: false,
//               ),
//               const Expanded(child: SizedBox()),
//               PlanFilterButton(
//                 text: 'gym'.tr,
//                 controller: controller.gymController,
//                 onTap: controller.toggleGym,
//                 isTrainingType: false,
//               ),
//             ],
//           ),
//           SizedBox(height: Get.height / 20.3),
//         ],
//       ),
//     );
//   }
// }
