import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Api/methods.dart';
import 'package:fitness_storm/Data/Repositories/trainer_repository.dart';
import 'package:fitness_storm/Model/available_time.dart';
import 'package:fitness_storm/Model/book_appointment.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Subscription/subscription_controller.dart';
import 'package:fitness_storm/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quiver/time.dart';

import '../../../custome_web_page_view.dart';

class BookPrivateSessionController extends GetxController {
  late String trainerName;
  late String trainerProfileImage;
  late String trainerId;
  late int year;
  Map<String, dynamic> result = {};
  final RxString _currentMonth = ''.obs;
  final RxInt _currentWeekEndDay = 7.obs;
  final RxInt _currentWeekStartDay = 1.obs;
  final RxInt _currentMonthDays = 0.obs;
  final RxBool _hasTwoMonths = false.obs;
  final RxInt _secondMonthStartDay = 0.obs;
  final RxInt _secondMonthEndDay = 0.obs;
  final RxString _secondMonth = ''.obs;
  final RxBool _isLoading = false.obs;
  final RxList<String> currentDays = <String>[].obs;
  final Rx<BookAppointment> bookedDate = BookAppointment().obs;
  Map<String, dynamic>? paymentIntentData;

  final Rx<DateTime> _focusedDay = DateTime.now().obs;
  final Rx<DateTime> _selectedDay = DateTime.now().obs;
  final Rx<Map<String, List<AvailableTime>>> _availableDate =
      Rx<Map<String, List<AvailableTime>>>({});

  List months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  DateTime get focusedDay => _focusedDay.value;

  DateTime get selectedDay => _selectedDay.value;

  Map<String, List<AvailableTime>> get availableDate => _availableDate.value;

  String get currentMonth => _currentMonth.value;

  int get currentWeekEndDay => _currentWeekEndDay.value;

  int get currentWeekStartDay => _currentWeekStartDay.value;

  int get currentMonthDays => _currentMonthDays.value;

  bool get hasTwoMonths => _hasTwoMonths.value;

  int get secondMonthStartDay => _secondMonthStartDay.value;

  int get secondMonthEndDay => _secondMonthEndDay.value;

  String get secondMonth => _secondMonth.value;

  bool get isLoading => _isLoading.value;

  set focusedDay(value) => _focusedDay.value = value;

  set selectedDay(value) => _selectedDay.value = value;

  set availableDate(value) => _availableDate.value = value;

  set currentMonth(value) => _currentMonth.value = value;

  set currentWeekEndDay(value) => _currentWeekEndDay.value = value;

  set currentWeekStartDay(value) => _currentWeekStartDay.value = value;

  set currentMonthDays(value) => _currentMonthDays.value = value;

  set hasTwoMonths(value) => _hasTwoMonths.value = value;

  set secondMonthStartDay(value) => _secondMonthStartDay.value = value;

  set secondMonthEndDay(value) => _secondMonthEndDay.value = value;

  set secondMonth(value) => _secondMonth.value = value;

  set isLoading(value) => _isLoading.value = value;

  final TrainerRepository _trainerRepository = TrainerRepository();

  @override
  Future<void> onInit() async {
    super.onInit();

    isLoading = true;
    trainerName = Get.arguments[0];
    trainerProfileImage = Get.arguments[1];
    trainerId = Get.arguments[2];
    getStartMonth();
    await getTrainerAvailableTimes();
    isLoading = false;
  }

  List listOfDayEvents(DateTime dateTime) {
    if (availableDate[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return availableDate[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  getStartMonth() {
    final someDateTime = DateTime.now();
    final monthNumber = someDateTime.month;
    year = someDateTime.year;
    currentMonth = months[monthNumber - 1];
    currentMonthDays = daysInMonth(year, monthNumber);
    currentWeekStartDay = DateTime.now().day;
    if (currentWeekStartDay >= 1 && currentWeekStartDay <= 7) {
      currentWeekStartDay = 1;
      currentWeekEndDay = 7;
    } else if (currentWeekStartDay >= 8 && currentWeekStartDay <= 14) {
      currentWeekStartDay = 8;
      currentWeekEndDay = 14;
    } else if (currentWeekStartDay >= 15 && currentWeekStartDay <= 21) {
      currentWeekStartDay = 15;
      currentWeekEndDay = 21;
    } else if (currentWeekStartDay >= 22 && currentWeekStartDay <= 28) {
      currentWeekStartDay = 22;
      currentWeekEndDay = 28;
    } else {
      if (currentMonthDays == 29) {
        currentWeekStartDay = 29;
        currentWeekEndDay = 29;
      } else if (currentMonthDays == 30) {
        currentWeekStartDay = 29;
        currentWeekEndDay = 30;
      } else {
        currentWeekStartDay = 29;
        currentWeekEndDay = 31;
      }
    }
  }

  getNextWeek() async {
    //log('current Month days $currentMonthDays');
    if (currentWeekEndDay == currentMonthDays) {
      _getNextMonth();
      currentWeekStartDay = 1;
      currentWeekEndDay = 7;
    } else if (currentWeekEndDay + 7 > currentMonthDays) {
      currentWeekStartDay = currentWeekEndDay + 1;
      currentWeekEndDay = currentMonthDays;
    } else {
      currentWeekStartDay = currentWeekEndDay + 1;
      currentWeekEndDay += 7;
    }
    isLoading = true;
    await getTrainerAvailableTimes();
    isLoading = false;
  }

  getPreviousWeek() async {
    final now = DateTime.now();
    final date = DateTime(
      year,
      months.indexOf(currentMonth) + 1,
      currentWeekStartDay -7,
      now.hour,
      now.minute,
    );
    loggerObject.wtf(date.toIso8601String());
    loggerObject.wtf(now.add(const Duration(days: -7)).toIso8601String());

    if(now.add(const Duration(days: -7)).isAfter(date))return;

    if (currentWeekStartDay == 1) {
      _getPreviousMonth();
      currentWeekEndDay = currentMonthDays;
      currentWeekStartDay = currentWeekEndDay - 7;
    } else if (currentWeekStartDay - 7 < 1) {
      currentWeekEndDay = currentWeekStartDay;
      currentWeekStartDay = 1;
    } else {
      currentWeekEndDay = currentWeekStartDay - 1;
      currentWeekStartDay -= 7;
    }
    isLoading = true;
    await getTrainerAvailableTimes();
    isLoading = false;
  }

  getTrainerAvailableTimes() async {
    result = await _trainerRepository.getTrainerAvailableTimes(trainerId.toString(), year,
        months.indexOf(currentMonth) + 1, currentWeekStartDay, currentWeekEndDay);

    final format = DateFormat('yyyy-MM-dd');

    for (var element1 in result.values.toList()) {
      for (var element2 in element1) {
        if (availableDate[format.format(DateTime.parse(element2['start_time']))] ==
            null) {
          availableDate[format.format(DateTime.parse(element2['start_time']))] =
              <AvailableTime>[];
        }
        availableDate[format.format(DateTime.parse(element2['start_time']))]!
            .add(AvailableTime.fromJson(element2));
      }
    }
    currentDays.value = result.keys.toList();
  }

  _getNextMonth() {
    int index = months.indexOf(currentMonth);

    if (index == months.length - 1) {
      index = -1;
    }
    currentMonth = months[index + 1];
    currentMonthDays = daysInMonth(year, index);
  } //a

  _getPreviousMonth() {
    int index = months.indexOf(currentMonth);

    if (index == 0) {
      index == 12;
    }
    currentMonth = months[index - 1];
    currentMonthDays = daysInMonth(year, index);
  }

  List<Widget> generateDaysWidget(currentContext) {
    List<Widget> widgets = [];
    for (var element in currentDays) {
      widgets.add(
        SizedBox(
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: Get.width / 80),
              SizedBox(
                width: 60,
                child: Text(
                    "${currentWeekStartDay + widgets.length} " + _customizeText(element),
                    style: TextStyle(
                        color: Get.theme.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
              ),

              const Expanded(child: SizedBox()),
              SizedBox(
                width: MediaQuery.of(currentContext).size.width * 0.7,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        _generateAvailableTimes(element, currentContext: currentContext),
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              // Expanded(child: SizedBox(width: Get.width / 50)),
            ],
          ),
        ),
      );
    }
    return widgets;
  }

  _customizeText(String text) {
    text = text.toUpperCase();
    bool isEnglish = Get.locale?.languageCode == 'en';
    if (isEnglish) {
      return text.substring(0, 3);
    } else {
      return text;
    }
  }

  formattedDateHM(String date) {
    DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
    String formattedDate = DateFormat('hh:mm').format(tempDate);
    return formattedDate;
  }

  String formattedDatedd(String date) {
    DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
    String formattedDate = DateFormat('dd').format(tempDate);

    String formatedMoth = DateFormat('MM').format(tempDate);

    return '$formattedDate ' + _customizeText(months[int.parse(formatedMoth) - 1]);
  }

  bookingDate(String id, String startTime, {currentContext}) async {
    //log('message');
    Utils.openLoadingDialog();
    bookedDate.value = BookAppointment(id: id, time: startTime);
    ApiResult uri = await _trainerRepository.bookPrivateSession(bookedDate.value.id!, "");
    Utils.closeDialog();
    if (uri.data != null) {
      if (!Get.isRegistered<SubscruptionController>()) {
        Get.lazyPut(() => SubscruptionController());
      }
      Navigator.push(
        currentContext,
        MaterialPageRoute(
          builder: (context) => MyCustomeWebPage(
            urlWebPage: uri.data['url'],
            subscruptionController: Get.find<SubscruptionController>(),
          ),
        ),
      );
    } else {
      Utils.openSnackBar(title: uri.message!);
    }
    //log(bookedDate.value.time!);
  }

  _generateAvailableTimes(String currentDay, {currentContext}) {
    List<Widget> widgets = [];
    if (result[currentDay] == null || result[currentDay].isEmpty) {
      widgets.add(
        Text(
          'No_available_sessions'.tr,
          style: const TextStyle(color: Color(0xFFA0A0A0), fontSize: 14),
        ),
      );
    } else {
      final s = result[currentDay];
      loggerObject.i(s);
      for(var element  in s){
        if (element['start_time'] != null) {
          final tempStart =
              DateFormat("yyyy-MM-dd hh:mm:ss").parse(element['start_time']);
          final tempEnd = DateFormat("yyyy-MM-dd hh:mm:ss").parse(element['end_time']);
          final startTime = DateFormat('hh:mm a').format(tempStart);
          final endTime = DateFormat('hh:mm a').format(tempEnd);


          loggerObject.w(tempStart);

          if(DateTime.now().isAfter(tempStart)){
            widgets.add(
              Text(
                'No_available_sessions'.tr,
                style: const TextStyle(color: Color(0xFFA0A0A0), fontSize: 14),
              ),
            );
            break;
          }
          widgets.add(
            InkWell(
              onTap: () async {
                Utils.openLoadingDialog();
                bookedDate.value =
                    BookAppointment(id: element['id'], time: element['start_time']);
                ApiResult uri =
                    await _trainerRepository.bookPrivateSession(bookedDate.value.id!, "");
                Utils.closeDialog();
                if (uri.data != null) {
                  if (!Get.isRegistered<SubscruptionController>()) {
                    Get.lazyPut(() => SubscruptionController());
                  }
                  Navigator.push(
                    currentContext,
                    MaterialPageRoute(
                      builder: (context) => MyCustomeWebPage(
                        urlWebPage: uri.data['url'],
                        subscruptionController: Get.find<SubscruptionController>(),
                      ),
                    ),
                  );
                } else {
                  Utils.openSnackBar(title: uri.message!);
                }
                //log(bookedDate.value.time!);
              },
              child: Builder(builder: (context) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(startTime, style: const TextStyle(fontSize: 12)),
                      const Text(' -> ', style: TextStyle(fontSize: 12)),
                      Text(endTime, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                );
              }), //Text(formattedDate, style: const TextStyle(color: Color(0xFFA0A0A0), fontSize: 14)),
            ),
          );

          widgets.add(const SizedBox(width: 30));
        }
      }
    }
    return widgets;
  }

  _unselectedTimeWidget(String formattedDate) {
    return Text(formattedDate, style: const TextStyle(fontSize: 14));
  }

  _selectedTimeWidget(String formattedDate) {
    return Container(
      decoration: BoxDecoration(
          color: Get.theme.primaryColor, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(5),
      child:
          Text(formattedDate, style: const TextStyle(color: Colors.white, fontSize: 14)),
    );
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    BaseOptions options = BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60 * 1000), // 60 seconds
      receiveTimeout: const Duration(seconds: 60 * 1000), // 60 seconds
    );
    Dio dio = Dio(options);
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      dio.options.headers = {
        'Authorization':
            'Bearer sk_test_51Mcu7xGzWWC5CGyymFAmZaGVoxgCXsjWOxphx9syueUWYtIUXpFIiPc8NSutjVknQEBUgsZylvze2xWUMxZUUpvV002LLuP4RF',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      var response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: body,
      );

      return response.data;
    } catch (err) {
      //log('err charging user: ${err.toString()}');
    }
  }
}
