import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Model/subscription_model.dart';
import '../subscription_controller.dart';

class CurrentPaymentCardWidget extends StatelessWidget {
  const CurrentPaymentCardWidget({super.key, required this.plan});

  final SubscriptionsPlans plan;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Column(
        children: [
          Container(
            height: 30,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Get.theme.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                'current_plan'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
          const SizedBox(height: 3.0),
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
          Container(
            margin: const EdgeInsets.all(6),
            child: ElevatedButton(
              onPressed: () {
                Get.find<SubscruptionController>().cancelSubscribtion();
                Get.find<SubscruptionController>().changeIsSubscrip();
                Get.find<SubscruptionController>().getSubscribtionPaymentPlan();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xFFA0A0A0),
                ),
                elevation: MaterialStateProperty.all(10),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              child: FittedBox(
                child: Text('cancel_subscription'.tr,
                    style: TextStyle(fontSize: 17, color: Colors.white)),
              ),
            ),
          )
        ],
      ),
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
