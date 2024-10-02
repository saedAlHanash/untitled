// import 'package:fitness_storm/Screen/Trainee%20Screens/FeaturedPlan/featured_plan_controller.dart';
// import 'package:fitness_storm/Widgets/custom_button.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'filtness_level_filter_widget.dart';
// import 'location_filter_widget.dart';
// import 'training_type_filter_widget.dart';
//
// class FilterSheetWidget extends GetWidget<FeaturedPlanController> {
//   const FilterSheetWidget(
//       {super.key, required this.onTap, required this.resetFilters});
//
//   final Function onTap;
//   final Function resetFilters;
//
//   @override
//   Widget build(BuildContext context) {
//     // Get.put(FeaturedPlanController());
//     return Container(
//       padding: EdgeInsets.only(
//           top: Get.height / 20.3,
//           left: Get.width / 12.5,
//           right: Get.width / 12.5),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(40),
//           topRight: Radius.circular(40),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const LocationFilterWidget(),
//           const FitnessLevelFilterWidget(),
//           TrainingTypeFilterWidget(),
//           TextButton(
//             onPressed: () => resetFilters(),
//             child: Text(
//               'reset_filters'.tr,
//               style: TextStyle(color: Get.theme.colorScheme.secondary),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               CustomButton(
//                 onTapFunction: onTap,
//                 buttonColor: Get.theme.primaryColor,
//                 text: 'Apply',
//                 textColor: Colors.white,
//                 fontSize: 13,
//                 width: Get.width / 3,
//                 padding: 0,
//               ),
//               CustomButton(
//                 onTapFunction: () {
//                   Get.back();
//                 },
//                 buttonColor: const Color(0xFFA0A0A0),
//                 text: 'cancel'.tr,
//                 textColor: Colors.white,
//                 fontSize: 13,
//                 width: Get.width / 3,
//                 padding: 0,
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
