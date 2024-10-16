import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:fitness_storm/core/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/l10n.dart';
import '../../bloc/create_subscription_cubit/create_subscription_cubit.dart';
import '../../data/response/subscription_response.dart';

class PaymentCardWidget extends StatefulWidget {
  const PaymentCardWidget({
    super.key,
    required this.subscription,
    required this.onTapFunction,
  });

  final Subscription subscription;
  final Function() onTapFunction;

  @override
  State<PaymentCardWidget> createState() => _PaymentCardWidgetState();
}

class _PaymentCardWidgetState extends State<PaymentCardWidget> {
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
          0.0.verticalSpace,
          DrawableText(
            fontFamily: FontManager.bold.name,
            text: '${widget.subscription.duration}/${widget.subscription.type.getName}',
          ),
          DrawableText(
            fontFamily: FontManager.bold.name,
            text: '${widget.subscription.priceAfterDiscount} ${S.of(context).sar}',
            color: AppColorManager.mainColor,
            size: 22.0.sp,
            fontWeight: FontWeight.bold,
          ),
          if (widget.subscription.price != widget.subscription.priceAfterDiscount)
            DrawableText(
              fontFamily: FontManager.bold.name,
              text:
                  '${S.of(context).renewalPrice}:${widget.subscription.price} ${S.of(context).sar}',
            ),
          BlocBuilder<CreateSubscriptionCubit, CreateSubscriptionInitial>(
            buildWhen: (p, c) => c.mRequest.subscriptionId == widget.subscription.id,
            builder: (context, state) {
              return MyButton(
                loading: state.loading,
                color: AppColorManager.secondColor,
                radios: 0,
                onTap: widget.onTapFunction,
                text: S.of(context).subscribe,
              );
            },
          ),
        ],
      ),
    );
  }
}
