import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Calender/trainer_calender_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../video/video.dart';

class TrainerCalenderSceen extends GetView<TrainerCalenderController> {
  const TrainerCalenderSceen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isEnglish = Get.locale?.languageCode == 'en';
    return Obx(() => controller.isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     IconButton(
                //         onPressed: () => controller.getPreviousWeek(),
                //         icon: Icon(Icons.arrow_back_ios_new,
                //             color: Get.theme.primaryColor)),
                //     Padding(
                //       padding: EdgeInsets.symmetric(
                //           horizontal: Get.width / 18.75,
                //           vertical: Get.height / 40.6),
                //       child: Row(
                //         children: [
                //           Text(
                //             '${controller.currentWeekStartDay}-${controller.currentWeekEndDay} ${controller.currentMonth} - ${controller.currentYear}',
                //             style: TextStyle(
                //                 color: Get.theme.primaryColor,
                //                 fontSize: 14,
                //                 fontWeight: FontWeight.bold),
                //           ),
                //         ],
                //       ),
                //     ),
                //     IconButton(
                //         onPressed: () => controller.getNextWeek(),
                //         icon: Icon(Icons.arrow_forward_ios,
                //             color: Get.theme.primaryColor)),
                //   ],
                // ),
                Obx(
                  () => controller.haveDataCalender
                      ? controller.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : controller.calenders.isNotEmpty
                              ? Column(
                                  children:
                                      controller.calenders.keys.toList().map((element) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 15.0,
                                            left: isEnglish ? 20.0 : 0,
                                            right: isEnglish ? 0.0 : 10,
                                            bottom: 10,
                                          ),
                                          child: Row(
                                            children: [
                                              const CircleAvatar(
                                                  radius: 3,
                                                  backgroundColor: Colors.grey),
                                              const SizedBox(width: 4),
                                              Text(
                                                element,
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: isEnglish ? 20.0 : 0,
                                              right: isEnglish ? 0.0 : 10,
                                              top: 15.0,
                                              bottom: 15.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children:
                                                controller.calenders[element]!.map((e) {
                                              int d;
                                              return DateOfSession(
                                                  nameOfCustomer: e.user!.name!,
                                                  date: e.startAt!,
                                                  token: e.videoCallToken ?? "",
                                                  isCheck: true);
                                            }).toList(),
                                          ),
                                        )
                                      ],
                                    );
                                  }).toList(),
                                )
                              : Center(
                                  child: Text('there_are_no_appointments_this_week'.tr),
                                )
                      : Center(
                          child: Text('there_are_no_appointments_this_week'.tr),
                        ),
                ),
              ],
            ),
          ));
  }
}

class DateOfSession extends GetView<TrainerCalenderController> {
  DateOfSession({
    Key? key,
    required this.nameOfCustomer,
    required this.date,
    required this.token,
    required this.isCheck,
  }) : super(key: key);
  final String nameOfCustomer;
  String date = '';
  String token = '';
  final bool isCheck;

  @override
  Widget build(BuildContext context) {
    bool isEnglish = Get.locale?.languageCode == 'en';
    return GestureDetector(
      onTap: () async {
        int hourNow = DateTime.now().hour;
        int hourSchedule = DateTime.parse(date).hour;
        if (hourNow >= hourSchedule && hourNow <= (hourSchedule + 1)) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Video1(tempToken: token)),
          );
        } else {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    backgroundColor: Colors.white,
                    title: Text(
                      'warning',
                      style: TextStyle(color: Get.theme.primaryColor),
                    ),
                    content: Text("It\'s_not_time_for_the_call_yet".tr),
                    actions: [
                      MaterialButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('okay'.tr),
                      )
                    ],
                  ));
        }
      },
      child: Padding(
        padding: isEnglish
            ? const EdgeInsets.only(left: 0.0)
            : const EdgeInsets.only(right: 10.0),
        child: Row(
          children: [
            Text(DateFormat('h:mm a').format(DateTime.parse(date)),
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
            const SizedBox(width: 7),
            // if (("${DateTime.now().hour}:${DateTime.now().minute}") == date)
            //   Container(
            //     height: 30,
            //     width: 100,
            //     color: Theme.of(context).colorScheme.background,
            //     child: Text('start_session'.tr),
            //   ),
            Text('Session_with'.tr, style: const TextStyle(fontSize: 11)),
            const SizedBox(width: 5),
            Text(nameOfCustomer,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
            const SizedBox(width: 7),
            Icon(
              Icons.video_call,
              color: Get.theme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
