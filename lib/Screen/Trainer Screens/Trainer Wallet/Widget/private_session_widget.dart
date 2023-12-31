 

import 'package:fitness_storm/Model/private_session.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Wallet/trainer_wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivateSessionWidget extends GetWidget<TrainerWalletController> {
  final Wallet privateSession;

  PrivateSessionWidget({required this.privateSession});

  @override
  Widget build(BuildContext context) {
   //log(controller.sessions[0].time.toString());
    return Container(
      width: Get.width,
      height: Get.height / 8,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
            color: privateSession.type == 'income'
                ? Get.theme.colorScheme.secondary
                : Get.theme.primaryColor,
            width: 2,
          )),
          color: const Color(0xFFF5F5F5)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            privateSession.type == 'income'
                ? Text('income'.tr + ' : ${privateSession.price} ' + 'sar'.tr,
                    style: const TextStyle(color: Color(0xFFA0A0A0), fontSize: 16))
                : Text('Payment: ${privateSession.price} ' + 'sar'.tr,
                    style: const TextStyle(color: Color(0xFFA0A0A0), fontSize: 16)),
            Text('balance'.tr + ' : ${privateSession.balance} ' + 'sar'.tr,
                style: const TextStyle(color: Color(0xFFA0A0A0), fontSize: 16)),
          ],
        ),
        const SizedBox.shrink(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            privateSession.type == 'income'
                ? const SizedBox()
                : TextButton(
                    onPressed: () =>
                        controller.downlaodImage(privateSession.file!),
                    style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                    child: Text('download_invoice'.tr,
                        style: TextStyle(
                            color: Get.theme.primaryColor, fontSize: 14)),
                  ),
            Text('${privateSession.time}',
                style: const TextStyle(color: Color(0xFFA0A0A0), fontSize: 14))
          ],
        )
      ]),
    );
  }
}
