import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/util/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../features/payments/bloc/cancel_subscription_cubit/cancel_subscription_cubit.dart';
import '../../../../features/payments/data/response/subscription_response.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';

class CurrentPaymentCardWidget extends StatelessWidget {
  const CurrentPaymentCardWidget({super.key, required this.subscription});

  final Subscription subscription;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0.r),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 30,
            width: double.infinity,
            color: AppColorManager.mainColor,
            child: Center(
              child: DrawableText(
                text: S.of(context).currentPlan,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
          0.0.verticalSpace,
          DrawableText(
            fontFamily: FontManager.bold.name,
            text: '${subscription.duration}/${subscription.type.getName}',
          ),
          DrawableText(
            fontFamily: FontManager.bold.name,
            text: '${subscription.priceAfterDiscount} ${S.of(context).sar}',
            color: AppColorManager.mainColor,
            size: 22.0.sp,
            fontWeight: FontWeight.bold,
          ),
          if (subscription.price != subscription.priceAfterDiscount)
            DrawableText(
              fontFamily: FontManager.bold.name,
              text:
                  '${S.of(context).renewalPrice}:${subscription.price} ${S.of(context).sar}',
            ),
          BlocBuilder<CancelSubscriptionCubit, CancelSubscriptionInitial>(
            builder: (context, state) {
              return MyButton(
                loading: state.loading,
                color: AppColorManager.red,
                radios: 0,
                onTap: () {
                  NoteMessage.showCheckDialog(
                    context,
                    text: S.of(context).whyCancel,
                    textButton: S.of(context).yescancel,
                    image: Assets.imagesSad,
                    color: AppColorManager.red,
                    onConfirm: (b) {
                      if (!b) return;
                      context
                          .read<CancelSubscriptionCubit>()
                          .cancelSubscription(request: '_');
                    },
                    textCancelButton: S.of(context).back,
                  );
                },
                text: S.of(context).cancelSubscription,
              );
            },
          ),
        ],
      ),
    );
  }
}
