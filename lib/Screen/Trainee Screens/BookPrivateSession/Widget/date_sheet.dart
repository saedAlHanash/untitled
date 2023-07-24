import 'package:fitness_storm/Screen/Trainee%20Screens/BookPrivateSession/book_private_session_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateSheet extends GetWidget<BookPrivateSessionController> {
  const DateSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final currentContext = context;
    // bool isEnglish = Get.locale?.languageCode == 'en';
    return Obx(
      () => Container(
        width: Get.width,
        height: Get.height / 2,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.3),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(12)),
                height: 5,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'CHOOSE_TIME'.tr,
              style: const TextStyle(color: Color(0xFF565C63), fontSize: 14),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () => controller.getPreviousWeek(),
                    icon: Get.locale?.languageCode == 'en'
                        ? Icon(Icons.arrow_back_ios_new, color: Get.theme.primaryColor)
                        : Icon(Icons.arrow_back_ios, color: Get.theme.primaryColor)),
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
                        ? Icon(Icons.arrow_forward_ios, color: Get.theme.primaryColor)
                        : Icon(Icons.arrow_forward_ios_outlined,
                            color: Get.theme.primaryColor)),
              ],
            ),
            controller.isLoading
                ? const Expanded(
                    child: Center(child: CircularProgressIndicator.adaptive()))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: controller.generateDaysWidget(currentContext),
                  ),
            // Expanded(
            //   child: Container(
            //     width: Get.width,
            //     padding: EdgeInsets.symmetric(horizontal: Get.width / 12),
            //     child: Text(
            //       'You are Booking aa Private Session with Coach ${controller.trainerName ?? ""} on ${controller.formattedDatedd(controller.bookedDate.value.time ?? "1990-02-02 00:00:00")} at ${controller.formattedDateHM(controller.bookedDate.value.time!??"1990-02-02 00:00:00")} for 12SAR/HOUR',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(fontSize: 14, color: Color(0xFFA0A0A0)),
            //     ),
            //   ),
            // ),
            // Expanded(
            //     child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Expanded(
            //       child: CustomButton(
            //         onTapFunction: () async => await controller.checkout(),
            //         text: 'Checkout',
            //         fontSize: 13,
            //         textColor: Colors.white,
            //         radius: 20,
            //       ),
            //     ),
            //     Expanded(
            //       child: CustomButton(
            //         onTapFunction: () => Get.back(),
            //         text: 'Cancel',
            //         fontSize: 13,
            //         textColor: Colors.white,
            //         buttonColor: const Color(0xFFA0A0A0),
            //         radius: 20,
            //       ),
            //     ),
            //   ],
            // ))
          ],
        ),
      ),
    );
  }
}
// import 'package:fitness_storm/Model/available_time.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// import '../book_private_session_controller.dart';
//
// class DateSheet extends GetView<BookPrivateSessionController> {
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => controller.isLoading
//           ? Center(child: CircularProgressIndicator.adaptive())
//           : Container(
//               child:
//               // Column(
//               //   children: [
//               //     const SizedBox(height: 10),
//               //     Padding(
//               //       padding: EdgeInsets.symmetric(
//               //           horizontal: MediaQuery.of(context).size.width * 0.3),
//               //       child: Container(
//               //         decoration: BoxDecoration(
//               //             color: Colors.grey,
//               //             borderRadius: BorderRadius.circular(12)),
//               //         height: 5,
//               //         width: double.infinity,
//               //       ),
//               //     ),
//                   SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         TableCalendar(
//                           locale: 'en_US',
//                           focusedDay: controller.focusedDay,
//                           firstDay: DateTime(2000, 1, 1),
//                           lastDay: DateTime(2100, 31, 12),
//                           selectedDayPredicate: (day) {
//                             return isSameDay(controller.selectedDay, day);
//                           },
//                           onDaySelected: (selectedDay, focusedDay) {
//                             if (!isSameDay(
//                                 controller.selectedDay, selectedDay)) {
//                               controller.selectedDay = selectedDay;
//                               controller.focusedDay = focusedDay;
//                             }
//                           },
//                           onFormatChanged: (format) {
//                             if (_calendarFormat != format) {
//                               _calendarFormat = format;
//                             }
//                           },
//                           eventLoader: controller.listOfDayEvents,
//                         ),
//                         Divider(),
//                         ...controller
//                             .listOfDayEvents(controller.selectedDay)
//                             .map(
//                           (e) {
//                             if (e is AvailableTime) {
//                               DateFormat format = DateFormat('hh:mm');
//                               return ListTile(
//                                 onTap: () => controller.bookingDate(
//                                     e.id!, e.startTime!,
//                                     currentContext: context),
//                                 leading: Icon(
//                                   Icons.bookmark_add_outlined,
//                                   color: Get.theme.primaryColor,
//                                 ),
//                                 title: Text(e.id!),
//                                 subtitle: Text(
//                                     "${format.format(DateTime.parse(e.startTime!))} - ${format.format(DateTime.parse(e.endTime!))}"),
//                               );
//                             } else {
//                               return SizedBox.shrink();
//                             }
//                           },
//                         ),
//                         SizedBox(height: 20),
//                       ],
//                     ),
//                   )
//                 // ],
//               // ),
//             ),
//     );
//   }
// }
