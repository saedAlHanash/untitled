import 'package:fitness_storm/Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Model/subscription_model.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../generated/l10n.dart';

class PaymentCardWidget extends StatefulWidget {
  const PaymentCardWidget({
    super.key,
    required this.plan,
    required this.onTapFunction,
  });

  final SubscriptionsPlans plan;
  final Function onTapFunction;

  @override
  State<PaymentCardWidget> createState() => _PaymentCardWidgetState();
}

class _PaymentCardWidgetState extends State<PaymentCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Column(children: [
        SizedBox(height: Get.height / 20),
        Text(
          '${widget.plan.duration}/ $getType',
          style: const TextStyle(
            color: Color(0xFF565C63),
            fontSize: 16,
          ),
        ),
        Text(
          '${widget.plan.priceAfterDiscount} ${AppProvider.isAr?'ر.س':'SAR'}',
          style: const TextStyle(
              color: Color(0xFF565C63), fontSize: 20, fontWeight: FontWeight.bold),
        ),
        if (widget.plan.price != widget.plan.priceAfterDiscount)
          Text(
            '${'renewal_price'.tr}:${widget.plan.price} ${AppProvider.isAr?'ر.س':'SAR'}',
            style: const TextStyle(color: Color(0xFF565C63), fontSize: 13),
          ),
        const Spacer(),
        CustomButton(
          onTapFunction: () {
            widget.onTapFunction();
          },
          padding: 0,
          fontSize: 14,
          textColor: Colors.white,
          text: 'subscribe'.tr,
        )
      ]),
    );
  }

  String get getType {
    if (widget.plan.type == 'day') {
      return S.of(context).days;
    } else if (widget.plan.type == 'month') {
      return S.of(context).months;
    } else {
      return S.of(context).years;
    }
  }
}
