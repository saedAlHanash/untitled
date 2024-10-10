// import 'package:drawable_text/drawable_text.dart';import 'package:fitness_storm/core/strings/enum_manager.dart';
// import 'package:fitness_storm/Utils/Routes/app_pages.dart';
// import 'package:fitness_storm/core/app/app_provider.dart';
// import 'package:fitness_storm/core/extensions/extensions.dart';
// import 'package:fitness_storm/core/strings/app_color_manager.dart';
// import 'package:fitness_storm/core/util/my_style.dart';
// import 'package:fitness_storm/features/appointments/data/response/bundles_response.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:image_multi_type/image_multi_type.dart';
//
// import '../../../../../features/appointments/bloc/bundles_cubit/bundles_cubit.dart';
// import '../../../../../features/trainer/data/response/trainer.dart';
// import '../../../../../generated/l10n.dart';
// import '../../../../../router/app_router.dart';
//
// class TrainerBio extends StatelessWidget {
//   const TrainerBio({required this.trainer, super.key});
//
//   final TrainerModel trainer;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         InkWell(
//           onTap: () {
//             if (AppControl.isAppleAccount) return;
//             startBookPrivetSession(trainer);
//           },
//           child: Container(
//             height: 45.0.h,
//             color: Get.theme.primaryColor,
//             padding: EdgeInsets.symmetric(horizontal: Get.width / 18.75),
//             child: Row(
//               children: [
//                 DrawableText(
//                   text: S.of(context).availableSession,
//                   size: 14.0.sp,
//                   color: Colors.white,
//                 ),
//                 const Spacer(),
//                 DrawableText(
//                   text: '${trainer.privateSessionPrice} ${'sar/hour'.tr}',
//                   color: Colors.white,
//                 ),
//                 15.0.horizontalSpace,
//                 ImageMultiType(
//                   url: Icons.arrow_forward_ios,
//                   color: Colors.white,
//                   width: 15.0.r,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Container(
//           color: const Color(0xFF9F86C1),
//           width: Get.width,
//           padding: EdgeInsets.symmetric(vertical: Get.height / 27),
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: Get.width / 18.75),
//                 width: Get.width,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     BioCheckWidget(
//                         title: 'WORKOUT_PLANS'.tr,
//                         value: trainer.numberOfPlans.toString()),
//                     BioCheckWidget(
//                         title: 'SUBSCRIBERS_cap'.tr,
//                         value: trainer.numberOfSubscribers.toString()),
//                     BioCheckWidget(
//                         title: 'private_hours'.tr,
//                         value: '+${trainer.numberOfPrivateHours}'),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                   top: Get.height / 27,
//                   left: Get.width / 16,
//                   right: Get.width / 16,
//                 ),
//                 child: Center(
//                   child: Text(
//                     trainer.bio,
//                     textAlign: isEnglish ? TextAlign.left : TextAlign.left,
//                     style: const TextStyle(fontSize: 14, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         BlocBuilder<BundlesCubit, BundlesInitial>(
//           builder: (context, state) {
//             if (state.statuses.loading) {
//               return MyStyle.loadingWidget();
//             }
//             if (state.result.isEmpty) {
//               return 0.0.verticalSpace;
//             }
//             return InkWell(
//               onTap: () => startBundlesPage(state.result),
//               child: Container(
//                 height: 45.0.h,
//                 color: AppColorManager.mainColorLight,
//                 padding: EdgeInsets.symmetric(horizontal: Get.width / 18.75),
//                 child: Row(
//                   children: [
//                     DrawableText(
//                       text: S.of(context).bundles,
//                       size: 14.0.sp,
//                       color: Colors.white,
//                     ),
//                     const Spacer(),
//                     DrawableText(
//                       text: '${state.result.length} ${S.of(context).bundles}',
//                       color: Colors.white,
//                     ),
//                     15.0.horizontalSpace,
//                     ImageMultiType(
//                       url: Icons.arrow_forward_ios,
//                       color: Colors.white,
//                       width: 15.0.r,
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
//
