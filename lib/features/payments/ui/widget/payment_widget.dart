import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/features/payments/data/response/payments.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({super.key, required this.payment});

  final Payment payment;

  @override
  Widget build(BuildContext context) {
    return  Container(
            margin: EdgeInsets.only(top: Get.height / 80),
            padding: EdgeInsets.symmetric(
                horizontal: Get.width / 20, vertical: Get.height / 50),
            decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                border: Border(top: BorderSide(color: Get.theme.primaryColor, width: 5))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Divider(color: Theme.of(context).primaryColor,height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${'payment'.tr} : ${payment.price} ${'sar'.tr}',
                      style: const TextStyle(fontSize: 16, color: Color(0xFFA0A0A0)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "${payment.duration} ${payment.type}",
                        style: const TextStyle(fontSize: 14, color: Color(0xFFA0A0A0)),
                      ),
                    ),
                    Text(
                      payment.endsAt?.formatDateTime ?? '-',
                      style: const TextStyle(fontSize: 16, color: Color(0xFFA0A0A0)),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
