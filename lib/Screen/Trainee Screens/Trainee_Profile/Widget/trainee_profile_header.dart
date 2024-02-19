// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:drawable_text/drawable_text.dart';
// import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee_Profile/trainee_profile_controller.dart';
// import 'package:fitness_storm/core/extensions/extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:image_multi_type/image_multi_type.dart';
//
// import '../../../../core/util/my_style.dart';
// import '../../../../features/auth/bloc/logout/logout_cubit.dart';
// import '../../../../generated/l10n.dart';
//
// class TraineeProfileHeader extends  StatelessWidget {
//   const TraineeProfileHeader({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         SizedBox(height: Get.height / 15.3),
//         Container(
//           width: Get.width / 4,
//           height: Get.width / 4,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(100),
//             border: Border.all(width: 2, color: Colors.white),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 0.1,
//                 blurRadius: 8,
//                 offset: const Offset(0, 10), // changes position of shadow
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(100),
//             child: CachedNetworkImage(
//               imageUrl: controller.userProfile.image == null
//                   ? ""
//                   : controller.userProfile.image.toString(),
//               fadeInDuration: const Duration(seconds: 1),
//               placeholder: (context, url) => const CircularProgressIndicator.adaptive(),
//               errorWidget: (context, url, error) =>
//                   Image.asset('asset/Images/user.png', fit: BoxFit.fill),
//             ),
//           ),
//         ),
//         SizedBox(height: Get.height / 27),
//         Text(
//           controller.userProfile.name ?? "",
//           style: TextStyle(
//               fontSize: 26, color: Get.theme.primaryColor, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: Get.height / 67.7),
//         BlocBuilder<LogoutCubit, LogoutInitial>(
//           builder: (context, state) {
//             if (state.statuses.loading) {
//               return MyStyle.loadingWidget();
//             }
//             return TextButton(
//               onPressed: () => context.read<LogoutCubit>().logout(),
//               child: DrawableText(
//                 text: S.of(context).logout,
//                 drawablePadding: 10.0.w,
//                 drawableEnd: const ImageMultiType(url: Icons.logout_outlined),
//               ),
//             );
//           },
//         ),
//         SizedBox(height: Get.height / 27),
//       ],
//     );
//   }
// }
