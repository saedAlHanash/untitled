import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Wallet/Widget/private_session_widget.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Wallet/trainer_wallet_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TrainerWalletScreen extends GetView<TrainerWalletController> {
  const TrainerWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading
          ? SizedBox(
              height: Get.height / 1.2,
              child: const Center(child: CircularProgressIndicator()))
          : controller.sessions.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('${'CURRENT_BALANCE'.tr} :',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                          Text(
                            '${controller.balanced}  ${'sar'.tr}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )
                        ],
                      ),
                      Expanded(
                        child: SmartRefresher(
                          controller: controller.refreshController.value,
                          enablePullUp: true,
                          enablePullDown: false,
                          onLoading: controller.onLoading,
                          footer: CustomFooter(
                            builder: (context, mode) {
                              Widget body;
                              if (mode == LoadStatus.idle) {
                                body = Text("pull_up_load".tr);
                              } else if (mode == LoadStatus.loading) {
                                body = const CupertinoActivityIndicator();
                              } else if (mode == LoadStatus.failed) {
                                body = Text("load_failed!click_retry!".tr);
                              } else if (mode == LoadStatus.canLoading) {
                                body = Text("release_to_load_more".tr);
                              } else {
                                body = Text("no_more_data".tr);
                              }
                              return SizedBox(
                                height: 55.0,
                                child: Center(child: body),
                              );
                            },
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.sessions.length,
                            itemBuilder: (context, index) =>
                                PrivateSessionWidget(
                                    privateSession: controller.sessions[index]),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Text('no_wallet'.tr),
                ),
    );
  }
}
