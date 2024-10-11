import 'package:fitness_storm/Widgets/custom_button.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:fitness_storm/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:fitness_storm/features/payments/ui/widget/payment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../Utils/Routes/app_pages.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/payments_cubit/payments_cubit.dart';

class MyPaymentScreen extends StatelessWidget {
  const MyPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).myPayments),
      body: BlocBuilder<PaymentsCubit, PaymentsInitial>(
        builder: (context, state) {
          if (state.result.isEmpty && state.done) return _DoNotStart();

          return RefreshWidget(
            onRefresh: () => context.read<PaymentsCubit>().getPayments(newData: true),
            isLoading: state.loading,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.0).r,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: state.result.map((e) {
                    return PaymentWidget(payment: e);
                  }).toList()),
            ),
          );
        },
      ),
    );
  }
}

class _DoNotStart extends StatelessWidget {
  const _DoNotStart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          1.0.sw.horizontalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width / 12.5),
            child: Text(
              'did_not_start_your_fitness'.tr,
              style: const TextStyle(color: Color(0xFF565C63), fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          CustomButton(
              onTapFunction: () {
                Get.toNamed(AppRoutes.subscriptionScreen);
              },
              text: 'choose_a_plan'.tr,
              textColor: Colors.white,
              fontSize: 16,
              radius: 100),
        ],
      ),
    );
  }
}
