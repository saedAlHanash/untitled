// import 'package:drawable_text/drawable_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_multi_type/round_image_widget.dart';
//
// import '../../../../../core/strings/app_color_manager.dart';
// import '../../../../../core/strings/enum_manager.dart';
// import '../../../../../core/widgets/my_button.dart';
// import '../../../../../features/trainer/data/response/trainer.dart';
//
// class TrainerProfileHeader extends StatelessWidget {
//   const TrainerProfileHeader({
//     super.key,
//     required this.trainer,
//   });
//
//   final TrainerModel trainer;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20.0).r,
//       child: Row(
//         children: [
//           SizedBox(
//             height: 160.0.h,
//             width: 120.0.w,
//             child: RoundImageWidget(
//               url:  trainer.image,
//               radios: 12.0.r,
//               height: 160.0.h,
//               width: 120.0.w,
//             ),
//           ),
//           15.0.horizontalSpace,
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 DrawableText(
//                   text: (trainer.name ?? '').toUpperCase(),
//                   size: 16.0.sp,
//                   fontFamily: FontFamily.robotoBold.name,
//                 ),
//                 15.0.verticalSpace,
//                 Row(
//                   children: [
//                     Expanded(
//                       child: MyButtonRound(
//                         color: AppColorManager.mainColor,
//                         child: DrawableText(text: ''),
//                         onTap: () {},
//                       ),
//                     ),
//                     15.0.horizontalSpace,
//                     Expanded(
//                       child: MyButtonRound(
//                         color: AppColorManager.mainColorLight,
//                         child: DrawableText(text: ''),
//                         onTap: () {},
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
