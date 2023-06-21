import 'package:fitness_storm/Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Model/subscription_model.dart';

class PaymentCardWidget extends StatelessWidget {
  const PaymentCardWidget({
    super.key,
    required this.plan,
    required this.onTapFunction,
  });

  final SubscriptionsPlans plan;
  final Function onTapFunction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Column(children: [
        SizedBox(height: Get.height / 20),
        Text(
          '${plan.duration} / $getType',
          style: const TextStyle(
            color: Color(0xFF565C63),
            fontSize: 16,
          ),
        ),
        Text(
          '${plan.priceAfterDiscount}\$',
          style: const TextStyle(
              color: Color(0xFF565C63), fontSize: 20, fontWeight: FontWeight.bold),
        ),
        if (plan.price != plan.priceAfterDiscount)
          Text(
            '${'renewal_price'.tr}:${plan.price}\$',
            style: const TextStyle(color: Color(0xFF565C63), fontSize: 13),
          ),
        const Spacer(),
        CustomButton(
          onTapFunction: () {
            onTapFunction();
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
    if (plan.type == 'day') {
      return 'DAY${plan.duration > 1 ? 's' : ''}';
    } else if (plan.type == 'month') {
      return 'MONTH${plan.duration > 1 ? 's' : ''}';
    } else {
      return 'YEAR${plan.duration > 1 ? 's' : ''}';
    }
  }
}
