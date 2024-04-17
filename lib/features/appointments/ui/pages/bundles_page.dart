// import 'package:drawable_text/drawable_text.dart';
// import 'package:fitness_storm/core/extensions/extensions.dart';
// import 'package:fitness_storm/core/strings/app_color_manager.dart';
// import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
// import 'package:fitness_storm/core/widgets/not_found_widget.dart';
// import 'package:fitness_storm/router/app_router.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_multi_type/circle_image_widget.dart';
//
// import '../../../../core/models/booked_appointments.dart';
// import '../../../../core/util/my_style.dart';
// import '../../../../generated/l10n.dart';
// import '../../bloc/booked_appointments_cubit/booked_appointments_cubit.dart';
// import '../../data/response/bundles_response.dart';
//
// class BundlesPage extends StatelessWidget {
//   const BundlesPage({super.key, required this.list});
//
//   final List<Bundle> list;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarWidget(titleText: S.of(context).bundles),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0).r,
//         child: ListView.builder(
//           shrinkWrap: true,
//           itemCount: list.length,
//           itemBuilder: (_, i) {
//             return _ItemBundle(item: list[i]);
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class _ItemBundle extends StatelessWidget {
//   const _ItemBundle({required this.item});
//
//   final Bundle item;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ListTile(
//           onTap: () => startCreateBundle(item),
//           leading: CircleImageWidget(url: item.trainer.image, size: 50.0.r),
//           title: DrawableText(text: '${S.of(context).sessionsCount}: ${item.sessions}'),
//           subtitle:
//               DrawableText(text: '${S.of(context).price}: ${item.price.formatPrice}'),
//         ),
//         Divider(color: AppColorManager.cardColor, indent: 10.0.w, endIndent: 10.0.w),
//       ],
//     );
//   }
// }
