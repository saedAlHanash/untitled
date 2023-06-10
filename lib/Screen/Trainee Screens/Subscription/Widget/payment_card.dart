import 'package:fitness_storm/Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentCardWidget extends StatelessWidget {
  final String id;
  final String type;
  final double price;
  final Function onTapFunction;

  const PaymentCardWidget({
    super.key,
    required this.id,
    required this.type,
    required this.price,
    required this.onTapFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Column(children: [
        SizedBox(height: Get.height / 25),
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
