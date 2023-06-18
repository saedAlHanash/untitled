import 'dart:convert';

import 'package:fitness_storm/Screen/Trainee%20Screens/User%20Training/Widget/current_exercise_widget.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/User%20Training/Widget/exercises_listview.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/User%20Training/Widget/rest_widget.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/User%20Training/user_training_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../../Utils/storage_controller.dart';
import 'Widget/slide_widget.dart';

class UserTrainingScreen extends GetView<UserTrainingController> {
  UserTrainingScreen({super.key});

  double progress = 0;
  InAppWebViewController? webView;

  @override
  Widget build(BuildContext context) {
    return Obx(() => WillPopScope(
          onWillPop: controller.complete
              ? null
              : () async {
                  bool shouldNavigateBack = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Text(
                            //   'warning'.tr,
                            //   style:
                            //       const TextStyle(color: Colors.black, fontSize: 16),
                            // ),
                            IconButton(
                                onPressed: () => Navigator.pop(context, false),
                                icon: Icon(
                                  Icons.close,
                                  color: Get.theme.primaryColor,
                                )),
                          ],
                        ),
                        content: Text(
                          'Did_you_finish_your_training'.tr,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                              try {
                                await controller.completeDay();
                                Navigator.pop(context);
                                // Navigator.pop(context);
                                // Navigator.pop(context);
                              } catch (e) {}

                              // Get.back();
                            },
                            child: Text(
                              'Done'.tr,
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text("i\'ll_come_back_later".tr),
                          ),
                        ],
                      );
                    },
                  );

                  return shouldNavigateBack;
                },
          child: Scaffold(
            appBar: AppBar(
              // leading: IconButton(
              //   icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              //   onPressed: () => Get.back(),
              // ),
              title: Text(controller.nameWorkout),
            ),
            body: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment:
                        (controller.type == "Zumba" || controller.type == 'zumba')
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                        (controller.type == "Zumba" || controller.type == 'zumba')
                            ? Align(
                                alignment: Alignment.center,
                                child: controller.accessToken == ''
                                    ? Container(
                                        height: 50,
                                        width: 50,
                                        child: const CircularProgressIndicator())
                                    : Column(
                                        children: [
                                          controller.progress < 1.0
                                              ? Container(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: controller.progress < 1.0
                                                      ? LinearProgressIndicator(
                                                          value: controller.progress)
                                                      : const SizedBox.shrink())
                                              : const SizedBox.shrink(),
                                          SizedBox(
                                            height: MediaQuery.of(context).size.height *
                                                0.283,
                                            child: InAppWebView(
                                              initialUrlRequest: URLRequest(
                                                  url: Uri.parse(
                                                      'https://player.vimeo.com/video/${controller.currentExercise.video!}'),
                                                  headers: {
                                                    'Authorization':
                                                        'Basic ${base64Encode(utf8.encode('9353127f0c5d3848970ed83590f3989b7d4aeabf:lsL75LeVC88hMQALy4KlRbaR0srz72eq9RqDJQuAbopBD1rxhQK5XxLM0KDCniZZ3QDC2iuatIk+kNstylUffDxbVm/sUNxhPg7E02OY8nT82I6uOjRObMiMdD9jsGBw'))}',
                                                    'Content-Type': 'application/json',
                                                    'Accept':
                                                        "application/vnd.vimeo.*+json;version=3.4",
                                                  }),
                                              onWebViewCreated: (controller1) {
                                                webView = controller1;
                                              },
                                              onLoadStop: (controller1, url) {},
                                              onProgressChanged:
                                                  (InAppWebViewController controller21,
                                                      int progress) {
                                                controller.progress = progress / 100;
                                              },
                                              onReceivedServerTrustAuthRequest:
                                                  (controller, challenge) async {
                                                return ServerTrustAuthResponse(
                                                    action: ServerTrustAuthResponseAction
                                                        .PROCEED);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                              )
                            : Container(
                                height: MediaQuery.of(context).size.height * 0.283,
                                child: Center(
                                  child: controller.accessToken == ''
                                      ? const CircularProgressIndicator()
                                      : InAppWebView(
                                          initialUrlRequest: URLRequest(
                                              url: Uri.parse(
                                                  'https://player.vimeo.com/video/${controller.currentExercise.video!}?autoplay=1&loop=1&muted=0&allow=autoplay;fullscreen'),
                                              headers: {
                                                'Authorization':
                                                    'Basic ${base64Encode(utf8.encode('9353127f0c5d3848970ed83590f3989b7d4aeabf:lsL75LeVC88hMQALy4KlRbaR0srz72eq9RqDJQuAbopBD1rxhQK5XxLM0KDCniZZ3QDC2iuatIk+kNstylUffDxbVm/sUNxhPg7E02OY8nT82I6uOjRObMiMdD9jsGBw'))}',
                                                'Content-Type': 'application/json',
                                                'Accept':
                                                    "application/vnd.vimeo.*+json;version=3.4",
                                              }),
                                          onWebViewCreated: (controller1) {
                                            webView = controller1;
                                          },
                                          onLoadStop: (controller1, url) {},
                                          onReceivedServerTrustAuthRequest:
                                              (controller, challenge) async {
                                            return ServerTrustAuthResponse(
                                                action: ServerTrustAuthResponseAction
                                                    .PROCEED);
                                          },
                                          initialOptions: InAppWebViewGroupOptions(
                                            android: AndroidInAppWebViewOptions(
                                              useHybridComposition: true,
                                            ),
                                            ios: IOSInAppWebViewOptions(
                                              allowsInlineMediaPlayback: true,
                                              allowsAirPlayForMediaPlayback: false,
                                              scrollsToTop: false,
                                            ),
                                          ),
                                          onEnterFullscreen: (controller) async {
                                            await SystemChrome.setPreferredOrientations([
                                              DeviceOrientation.landscapeRight,
                                              DeviceOrientation.landscapeLeft,
                                            ]);
                                          },
                                        ),
                                ),
                              ),
                        (controller.type == "Zumba" || controller.type == 'zumba')
                            ? const SizedBox.shrink()
                            : CurrentExerciseWidget(
                                color: Colors.white,
                                title: controller.currentExercise.name!,
                                isSecondsBased: controller.currentExercise.secondsBased!,
                                reps: controller.currentExercise.repetitions!,
                                set: controller.currentExercise.setCount!,
                                notes: controller.currentExercise.notes!,
                              ),
                        (controller.type == "Zumba" || controller.type == 'zumba')
                            ? const SizedBox.shrink()
                            : ExerciseListView(),
                        (StorageController().userType == 'trainer')
                            ? const SizedBox.shrink()
                            : SizedBox(
                                height: Get.height / 8,
                              ),
                      ]),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: controller.type == "Zumba" ||
                    controller.type == 'zumba' ||
                    (StorageController().userType == 'trainer')
                ? const SizedBox.shrink()
                : Obx(
                    () => controller.isLoading
                        ? Container()
                        : controller.isRest && controller.startTime > 0
                            ? RestWidget(
                                seconds: controller.type == "Loop Exercise"
                                    ? controller.startTime
                                    : 0,
                                isBreak: controller.isBreak,
                              )
                            : Obx(
                                () => SlidWidget(
                                  repetationNumber: controller.currentExercise
                                      .repetitions![controller.currentSet - 1].count!,
                                  setNumber: controller.currentSet,
                                ),
                              ),
                  ),
          ),
        ));
  }
}
