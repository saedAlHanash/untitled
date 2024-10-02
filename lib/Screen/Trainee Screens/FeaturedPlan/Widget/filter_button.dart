// import 'package:fitness_storm/Screen/Trainee%20Screens/FeaturedPlan/featured_plan_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
//
// class FilterButton extends GetWidget<FeaturedPlanController> {
//   const FilterButton({
//     super.key,
//     required this.icon,
//     required this.text,
//     required this.index,
//     required this.onTap,
//   });
//
//   final String icon;
//   final int index;
//   final Function onTap;
//   final String text;
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Container(
//         height: Get.height / 21,
//         width: Get.width / 3.4,
//         margin: EdgeInsets.symmetric(vertical: Get.height / 40),
//         decoration: BoxDecoration(
//           border: Border.all(color: Get.theme.primaryColor),
//           color: controller.selectedIndex == index
//               ? Get.theme.primaryColor
//               : Colors.white,
//         ),
//         child: InkWell(
//           onTap: () => onTap(), //() => controller.selectedIndex = index,
//           child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             SizedBox(
//               width: Get.width / 27.7,
//               height: Get.width / 27.7,
//               child: SvgPicture.asset(
//                 icon,
//                 color: controller.selectedIndex == index
//                     ? Colors.white
//                     : Get.theme.primaryColor,
//               ),
//             ),
//             SizedBox(width: Get.width / 50),
//             Text(
//               text,
//               style: TextStyle(
//                 color: controller.selectedIndex == index
//                     ? Colors.white
//                     : Get.theme.primaryColor,
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//               ),
//             )
//           ]),
//         ),
//       ),
//     );
//   }
// }
