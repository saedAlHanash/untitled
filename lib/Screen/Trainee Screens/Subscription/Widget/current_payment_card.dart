import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../subscription_controller.dart';

class CurrentPaymentCardWidegt extends StatelessWidget {
  final String id;
  final String type;
  final double price;
  Function voidCallBack;

  CurrentPaymentCardWidegt(
      {super.key,
      required this.id,
      required this.type,
      required this.price,
      required this.voidCallBack});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Column(children: [
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
        SizedBox(height: Get.height / 40),
        Text(
          '${getType()} ' + 'plan'.tr,
          style: const TextStyle(
            color: Color(0xFF565C63),
            fontSize: 14,
          ),
        ),
        Text(
          '$price\$',
          style: const TextStyle(
              color: Color(0xFF565C63),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
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
      ]),
    );
  }

  String getType() {
    if (type == 'day') {
      return 'DAILY';
    } else if (type == 'month') {
      return 'MONTHLY';
    } else {
      return 'YEARLY';
    }
  }
}
