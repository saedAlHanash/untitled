import 'package:fitness_storm/Data/Api/methods.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/home_screen.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Subscription/Widget/payment_card.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Subscription/Widget/success_subscribed.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Subscription/Widget/without_subscribed.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Subscription/subscription_controller.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/coupon/ui/coupon_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../custome_web_page_view.dart';
import '../../../helperClass.dart';
import '../PlanOverView/plan_overview_controller.dart';
import '../coupon/data/request/pay_request.dart';
import 'Widget/current_payment_card.dart';

class SubscriptionScreen extends GetView<SubscruptionController> {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: Text('subscription_plans'.tr),
          titleTextStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Get.theme.primaryColor,
                Get.theme.colorScheme.secondary,
              ],
            ),
          ),
          child: controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width / 18.75, vertical: Get.height / 20.3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        controller.isBuy
                            ? SuccessSubscribed(
                                nameUser: controller.nameUser,
                              )
                            : WithoutSubscribed(
                                isSubscirbe: controller.isSubscribe,
                              ),
                        SizedBox(height: Get.height / 16.24),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.subscriptions.subscriptions.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: Get.width / 19.7,
                            childAspectRatio: 2 / 2.2,
                            mainAxisSpacing: Get.height / 40.6,
                          ),
                          itemBuilder: (_, index) {
                            if (controller
                                .subscriptions.subscriptions[index].currentSubscription) {
                              return CurrentPaymentCardWidget(
                                plan: controller.subscriptions.subscriptions[index],
                              );
                            }
                            return PaymentCardWidget(
                              plan: controller.subscriptions.subscriptions[index],
                              onTapFunction: () => onTapSubscrip(context, index),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  void onTapSubscrip(BuildContext context, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CouponWidget(
            subscriptionId: controller.subscriptions.subscriptions[index].id,
            total: controller.subscriptions.subscriptions[index].price.toString(),
          );
        },
      ),
    );
    return;
    if (!controller.isSubscribe) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return CouponWidget(
              subscriptionId: controller.subscriptions.subscriptions[index].id,
              total: controller.subscriptions.subscriptions[index].price.toString(),
            );
          },
        ),
      );
      if (result == null) return;
      var request = result as PayRequest;

      request.subscriptionId = controller.subscriptions.subscriptions[index].id;

      final uri = await controller.makePayment(request: request);
      controller.isLoading = true;
      if (uri != "" && context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyCustomeWebPage(
              urlWebPage: uri,
              subscruptionController: controller,
            ),
          ),
        ).then((value) async {
          if (value != null) {
            await controller.getSubscribtionPaymentPlan();
            HelperClass.successfullySubscription = true;
            controller.isLoading = false;
            controller.isBuy = true;
            if (Get.isRegistered<PlanOverviewController>()) {
              Get.find<PlanOverviewController>().isActivated = true;
            } else {
              Get.lazyPut(() => PlanOverviewController());
              Get.find<PlanOverviewController>().isActivated = true;
            }
            controller.subscriptions.subscriptions[index].currentSubscription = true;
          } else {
            Navigator.pop(context);
          }
        });
        // kholoud.elsayed@hotmail.com
      } else {
        controller.isLoading = false;
        Get.back();
      }
      controller.isLoading = false;
    } else {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                backgroundColor: Colors.white,
                content: Text('it_is_advisable'.tr),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('back'.tr),
                  )
                ],
              ));
    }
  }
}
