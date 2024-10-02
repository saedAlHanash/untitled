// import 'package:fitness_storm/Screen/Trainee%20Screens/FeaturedPlan/Widget/filter_button.dart';
// import 'package:fitness_storm/Screen/Trainee%20Screens/FeaturedPlan/featured_plan_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class FilterRow extends GetWidget<FeaturedPlanController> {
//   const FilterRow({super.key, required this.selectedIndex});
//
//   final int selectedIndex;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: Get.width / 23.4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           FilterButton(
//             icon: 'asset/Images/search_bar.svg',
//             text: 'SEARCH'.tr,
//             index: 0,
//             onTap: () => controller.searchBottomSheet(),
//           ),
//           FilterButton(
//             icon: 'asset/Images/filter.svg',
//             text: 'filter'.tr,
//             index: 1,
//             onTap: () => controller.filterBottomSheet(),
//           ),
//           FilterButton(
//             icon: 'asset/Images/sort.svg',
//             text: 'sort'.tr,
//             index: 2,
//             onTap: () => controller.sortBottomSheet(),
//           )
//         ],
//       ),
//     );
//   }
// }
