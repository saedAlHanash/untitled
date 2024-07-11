import 'package:fitness_storm/Screen/Trainee%20Screens/My%20Payment/Widget/payment_widget.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/My%20Payment/my_payment_controller.dart';
import 'package:fitness_storm/Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/Routes/app_pages.dart';

class MyPaymentScreen extends GetView<MyPaymentController> {
  const MyPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: Text('my_payments'.tr),
          titleTextStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          // bottom: TabBar(
          //   indicatorWeight: 2,
          //   indicatorSize: TabBarIndicatorSize.label,
          //   tabs: [
          //     Tab(
          //         icon: Text(
          //       'my_payments'.tr,
          //       style: const TextStyle(color: Colors.white),
          //     )),
          //      Tab(icon: Text('ahmad',style: const TextStyle(color: Colors.white),)),
          //   ],
          //   onTap: (index) {
          //     controller.changeTabIndex(index);
          //   },
          // ),
        ),
        body: controller.isLoading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : controller.traineeNextPayment.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: controller.traineeNextPayment.map((e) {
                          return PaymentWidget(payments: e);
                        }).toList()),
                  )
                : SizedBox(
                    height: Get.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Get.width / 12.5),
                          child: Text(
                            'did_not_start_your_fitness'.tr,
                            style:
                                const TextStyle(color: Color(0xFF565C63), fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        CustomButton(
                            onTapFunction: () {
                              Get.toNamed(AppRoutes.subscriptionScreen);
                            },
                            text: 'choose_a_plan'.tr,
                            textColor: Colors.white,
                            fontSize: 16,
                            radius: 100),
                      ],
                    ),
                  ),
      ),
    );
  }
}
