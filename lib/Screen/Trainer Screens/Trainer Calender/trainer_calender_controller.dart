import 'package:fitness_storm/Data/Repositories/Trainer%20Repository/trainer_appointments.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quiver/time.dart';

import '../../../core/models/booked_appointments.dart';

class TrainerCalenderController extends GetxController {
  RxList<Appointment> appointments = <Appointment>[].obs;
  RxMap<String, List<Appointment>> calenders = <String, List<Appointment>>{}.obs;

  late int year;

  final RxString _currentYear = ''.obs;
  final RxString _currentMonth = ''.obs;
  final RxInt _currentWeekEndDay = 7.obs;
  final RxInt _currentWeekStartDay = 1.obs;
  final RxInt _currentMonthDays = 0.obs;
  final RxBool _hasTwoMonths = false.obs;
  final RxInt _secondMonthStartDay = 0.obs;
  final RxInt _secondMonthEndDay = 0.obs;
  final RxString _secondMonth = ''.obs;
  final RxBool _isLoading = false.obs;
  final RxBool _haveDataCalender = true.obs;
  final RxList<String> currentDays = <String>[].obs;
  Map<String, dynamic>? paymentIntentData;

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

  String get currentYear => _currentYear.value;

  String get currentMonth => _currentMonth.value;

  int get currentWeekEndDay => _currentWeekEndDay.value;

  int get currentWeekStartDay => _currentWeekStartDay.value;

  int get currentMonthDays => _currentMonthDays.value;

  bool get hasTwoMonths => _hasTwoMonths.value;

  int get secondMonthStartDay => _secondMonthStartDay.value;

  int get secondMonthEndDay => _secondMonthEndDay.value;

  String get secondMonth => _secondMonth.value;

  bool get isLoading => _isLoading.value;

  bool get haveDataCalender => _haveDataCalender.value;

  set currentYear(value) => _currentYear.value = value;

  set currentMonth(value) => _currentMonth.value = value;

  set currentWeekEndDay(value) => _currentWeekEndDay.value = value;

  set currentWeekStartDay(value) => _currentWeekStartDay.value = value;

  set currentMonthDays(value) => _currentMonthDays.value = value;

  set hasTwoMonths(value) => _hasTwoMonths.value = value;

  set secondMonthStartDay(value) => _secondMonthStartDay.value = value;

  set secondMonthEndDay(value) => _secondMonthEndDay.value = value;

  set secondMonth(value) => _secondMonth.value = value;

  set isLoading(value) => _isLoading.value = value;

  set haveDataCalender(value) => _haveDataCalender.value = value;

  @override
  Future<void> onInit() async {
    getStartMonth();
    await getTrainerAvailableTimes();
    super.onInit();
  }

  getStartMonth() {
    final someDateTime = DateTime.now();
    final monthNumber = someDateTime.month;
    year = someDateTime.year;
    currentYear = year.toString();
    currentMonth = months[monthNumber - 1];
    currentMonthDays = daysInMonth(year, monthNumber);
  }

  _getNextMonth() {
    int index = months.indexOf(currentMonth);
    //log('$currentMonth Index id $index');
    if (index == months.length - 1) {
      index = -1;
    }
    currentMonth = months[index + 1];
    currentMonthDays = daysInMonth(year, index + 1);
  }

  _getPreviousMonth() {
    int index = months.indexOf(currentMonth);
    //log('$currentMonth Index is $index');
    if (index == 0) {
      index == 12;
    }
    currentMonth = months[index - 1];
    currentMonthDays = daysInMonth(year, index - 1);
  }

  getPreviousWeek() async {
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
    update();
  }

  String nameDay(int dayNumber) {
    switch (dayNumber) {
      case 1:
        return 'Sun';
      case 2:
        return 'Mon';
      case 3:
        return 'Tus';
      case 4:
        return 'Wed';
      case 5:
        return 'Thu';
      case 6:
        return 'Fri';
      case 7:
        return 'Sat';
      default:
        return '';
    }
  }

  getTrainerAvailableTimes() async {
    TrainerAppointmentsRepository trainerAppointmentsRepository =
        TrainerAppointmentsRepository();
    isLoading = true;
    var result = await trainerAppointmentsRepository.getTrainerAvailableTimes();

    if (result.isEmpty) {
      haveDataCalender = false;
    } else {
      haveDataCalender = true;
      result.forEach((e) {
        final model = Appointment.fromJson(e);

        if (calenders[DateFormat('yyyy-MM-dd').format(model.startTime)] == null ||
            calenders[DateFormat('yyyy-MM-dd').format(model.startTime)]!.isEmpty) {
          calenders[DateFormat('yyyy-MM-dd').format(model.startTime)] = [];
          calenders[DateFormat('yyyy-MM-dd').format(model.startTime)]!.add(model);
        } else {
          calenders[DateFormat('yyyy-MM-dd').format(model.startTime)]!.add(model);
        }
      });
    }
    isLoading = false;
  }

// _customizeText(String text) {
//   text = text.toUpperCase();
//   return text.substring(0, 3);
// }
}
