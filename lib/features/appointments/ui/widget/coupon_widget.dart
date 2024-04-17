// import 'package:fitness_storm/core/extensions/extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../../../core/widgets/my_text_form_widget.dart';
// import '../../../../generated/l10n.dart';
// import '../../../coupon/coupon_cubit/coupon_cubit.dart';
// import '../../../coupon/data/request/pay_request.dart';
//
// class CouponWidget extends StatefulWidget {
//   const CouponWidget({super.key, required this.id});
//
//   final String id;
//
//   @override
//   State<CouponWidget> createState() => _CouponWidgetState();
// }
//
// class _CouponWidgetState extends State<CouponWidget> {
//   final request = PayRequest();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CouponCubit, CouponInitial>(
//       builder: (context, state) {
//         return SizedBox(
//           height: 0.5.sh,
//           child: Padding(
//             padding: const EdgeInsets.all(10.0).r,
//             child: Column(
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: BlocBuilder<CouponCubit, CouponInitial>(
//                         builder: (context, state) {
//                           return MyTextFormNoLabelWidget(
//                             hint: S.of(context).couponCode,
//                             autofocus: true,
//                             onChanged: (val) => request.code = val,
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
