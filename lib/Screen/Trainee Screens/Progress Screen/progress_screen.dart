import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/Model/progress_model.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Progress%20Screen/progress_screen_controller.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProgressScreen extends GetView<ProgressScreenController> {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.isLoading) {
          return SizedBox(
            height: Get.height,
            child: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              12.0.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () => controller.getPreviousWeek(),
                      icon: Get.locale?.languageCode == 'en'
                          ? Icon(Icons.arrow_back_ios_new,
                              color: Get.theme.primaryColor)
                          : Icon(Icons.arrow_back_ios,
                              color: Get.theme.primaryColor)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: Row(
                      children: [
                        Get.locale?.languageCode == 'en'
                            ? Text(
                                '${controller.currentWeekStartDay} - ${controller.currentWeekEndDay} ${controller.currentMonth}',
                                style: TextStyle(
                                    color: Get.theme.primaryColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                                textDirection: TextDirection.ltr,
                              )
                            : Text(
                                '${controller.currentWeekStartDay} - ${controller.currentWeekEndDay} ${controller.currentMonth}',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Get.theme.primaryColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () => controller.getNextWeek(),
                      icon: Get.locale?.languageCode == 'en'
                          ? Icon(Icons.arrow_forward_ios,
                              color: Get.theme.primaryColor)
                          : Icon(Icons.arrow_forward_ios_outlined,
                              color: Get.theme.primaryColor)),
                ],
              ),
              10.0.verticalSpace,
              /*
                  controller.progressModel.isEmpty
                      ? Center(
                          child: Text('the_from_is_not_a_valid_date'.tr),
                        )
                      :*/
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.progressModel
                    .map((e) => Log(progressModel: e))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Log extends StatefulWidget {
  const Log({
    super.key,
    required this.progressModel,
  });

  final ProgressModel progressModel;

  @override
  State<Log> createState() => _LogState();
}

class _LogState extends State<Log> {
  final color2 = const Color(0xFF54BECA);
  final color1 = Get.theme.primaryColor;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final isSession = !(widget.progressModel.type == 'plan');

    return GestureDetector(
      onTap: () async {
        if (isSession) {}
        //   var data =
        //       await Get.put(TrainerCalenderController()).traineeMakeVideoCall();
        //   if (data != null) {
        //     // ignore: use_build_context_synchronously
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (_) => const Video(
        //                   tempToken:
        //                       "007eJxTYGDytDsioHjxxmWRNq/crPXtt6Q8E/acTH/xTEKkMIj71gMFhhTjVOPEFMukNKNECxOzpNQkU1PDJAMDY0tzy0QjQxOj1hD5lIZARgbmPzasjAwQCOKzMJSkFpcwMAAA+EMd9Q==",
        //                 )));
        //   } else {
        //     Utils.openSnackBar(message: "It\'s_not_time_for_the_call_yet".tr);
        //   }
        // }
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(240, 240, 240, 1),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            15.0.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: DrawableText(
                    textAlign: TextAlign.center,
                    text: widget.progressModel.logUser?.inMinute ?? '',
                    color: isSession ? color1 : color2,
                    size: 14.0.sp,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: DrawableText(
                      textAlign: TextAlign.center,
                      text: widget.progressModel.logUser?.title ?? '-',
                      color: isSession ? color1 : color2,
                      fontWeight: FontWeight.w600),
                ),
                Expanded(
                  child: DrawableText(
                      textAlign: TextAlign.center,
                      size: 14.0.sp,
                      text: widget.progressModel.logUser?.from?.formatDate ??
                          '-'),
                ),
              ],
            ),
            20.0.verticalSpace,
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0).r,
              decoration: BoxDecoration(
                color: isSession ? color1 : color2,
                borderRadius: BorderRadius.circular(5),
              ),
              height: height * 0.02,
              width: width,
            ),
            10.0.verticalSpace,
          ],
        ),
      ),
    );
  }
}
