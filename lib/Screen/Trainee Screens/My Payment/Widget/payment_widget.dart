import 'package:fitness_storm/Model/trainee_next_payment.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/My%20Payment/my_payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PaymentWidget extends GetWidget<MyPaymentController> {
  final dynamic payments;

  PaymentWidget({super.key, required this.payments});

  final DateFormat format = DateFormat("dd, MMM, yyyy HH:mm");

  @override
  Widget build(BuildContext context) {
    return payments is TraineeNextPayment
        ? Container(
            margin: EdgeInsets.only(top: Get.height / 80),
            padding: EdgeInsets.symmetric(
                horizontal: Get.width / 20, vertical: Get.height / 50),
            decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                border: Border(
                    top: BorderSide(color: Get.theme.primaryColor, width: 5))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Divider(color: Theme.of(context).primaryColor,height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${'payment'.tr} : ${payments.price} ${'sar'.tr}',
                      style: const TextStyle(
                          fontSize: 16, color: Color(0xFFA0A0A0)),
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
                        "${payments.duration} ${payments.type}",
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xFFA0A0A0)),
                      ),
                    ),
                    Text(
                      format.format(DateTime.parse(payments.endsAt!)),
                      style: const TextStyle(
                          fontSize: 16, color: Color(0xFFA0A0A0)),
                    ),
                  ],
                ),
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.only(top: Get.height / 80),
            padding: EdgeInsets.symmetric(
                horizontal: Get.width / 20, vertical: Get.height / 50),
            decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
                border: Border(
                    top: BorderSide(color: Color(0xFF54BECA), width: 5))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${'payment'.tr} : ${payments.price} ${'sar'.tr}',
                      style: const TextStyle(
                          fontSize: 16, color: Color(0xFFA0A0A0)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: Text(
                    //     "${payments.duration} ${payments.type}",
                    //     style: const TextStyle(
                    //         fontSize: 14, color: Color(0xFFA0A0A0)),
                    //   ),
                    // ),
                    Text(
                      format.format(DateTime.parse(payments.startTime!)),
                      style: const TextStyle(
                          fontSize: 16, color: Color(0xFFA0A0A0)),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
