// import 'package:fitness_storm/core/helper/launcher_helper.dart';
// import 'package:fitness_storm/core/strings/app_color_manager.dart';
// import 'package:fitness_storm/core/strings/enum_manager.dart';
// import 'package:fitness_storm/features/welcome_message/data/response/welcome_message_response.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_multi_type/image_multi_type.dart';
// import 'package:linkfy_text/linkfy_text.dart';
//
// class ItemMessage extends StatelessWidget {
//   const ItemMessage({super.key, required this.item});
//
//   final WelcomeMessage item;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       // padding: const EdgeInsets.all(20.0).r,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: AppColorManager.mainColor,
//               boxShadow: [
//                 BoxShadow(
//                   blurRadius: 5.0.r,
//                   color: AppColorManager.cardColor,
//                   offset: Offset(0, 5.0.h),
//                 ),
//               ],
//               borderRadius: BorderRadius.circular(12.0.r),
//             ),
//             clipBehavior: Clip.hardEdge,
//             margin: const EdgeInsets.all(10.0).r,
//             padding: const EdgeInsets.all(10.0).r,
//             child: Column(
//               children: [
//                 LinkifyText(
//                   item.message,
//                   onTap: (p0) {
//                     if (p0.value == null) return;
//                     LauncherHelper.openPage(p0.value!);
//                   },
//                   textDirection: TextDirection.ltr,
//                   linkStyle: TextStyle(
//                     color: AppColorManager.secondColor,
//                     fontFamily: FontManager.bold.name,
//                     fontSize: 16.0.sp,
//                   ),
//                   textStyle: TextStyle(
//                     color: Colors.white,
//
//                     fontSize: 16.0.sp,
//                   ),
//                 ),
//                 if (item.image.isNotEmpty) ImageMultiType(url: item.image),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
