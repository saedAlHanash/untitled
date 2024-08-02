import 'package:fitness_storm/Data/Repositories/trainee_repository.dart';
import 'package:fitness_storm/Model/progress_model.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:quiver/time.dart';

class ProgressScreenController extends GetxController {
  List<ProgressModel> progressModel = <ProgressModel>[];
  TraineeRepository traineeRepository = TraineeRepository();
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

  String get currentMonth => _currentMonth.value;

  int get currentWeekEndDay => _currentWeekEndDay.value;

  int get currentWeekStartDay => _currentWeekStartDay.value;

  int get currentMonthDays => _currentMonthDays.value;

  bool get hasTwoMonths => _hasTwoMonths.value;

  int get secondMonthStartDay => _secondMonthStartDay.value;

  int get secondMonthEndDay => _secondMonthEndDay.value;

  String get secondMonth => _secondMonth.value;

  bool get isLoading => _isLoading.value;

  set currentMonth(value) => _currentMonth.value = value;

  set currentWeekEndDay(value) => _currentWeekEndDay.value = value;

  set currentWeekStartDay(value) => _currentWeekStartDay.value = value;

  set currentMonthDays(value) => _currentMonthDays.value = value;

  set hasTwoMonths(value) => _hasTwoMonths.value = value;

  set secondMonthStartDay(value) => _secondMonthStartDay.value = value;

  set secondMonthEndDay(value) => _secondMonthEndDay.value = value;

  set secondMonth(value) => _secondMonth.value = value;

  set isLoading(value) => _isLoading.value = value;

  @override
  Future<void> onInit() async {
    _isLoading.value = true;
    await getStartMonth();
    await getUserProgress();

    _isLoading.value = false;
    super.onInit();
  }


  bool hasTwoDigits(int number) {
    String numberString = number.toString();
    return numberString.length == 2;
  }

  getUserProgress() async {
    final dateFormat = DateFormat('yyyy-MM-dd', 'en');
    final index = months.indexOf(currentMonth);
    final monthNumber = index + 1;
    var monthNumberString = monthNumber.toString();
    var currentStartDayWeekString = currentWeekStartDay.toString();
    var currentEndDayWeekString = currentWeekEndDay.toString();

    if (!hasTwoDigits(monthNumber)) {
      monthNumberString = "0$monthNumber";
    }
    if (!hasTwoDigits(currentWeekStartDay)) {
      currentStartDayWeekString = '0$currentWeekStartDay';
    }
    if (!hasTwoDigits(currentWeekEndDay)) {
      currentEndDayWeekString = '0$currentWeekEndDay';
    }

    final fromDate = '$year-$monthNumberString-$currentStartDayWeekString';
    final endDate = '$year-$monthNumberString-$currentEndDayWeekString';


    final from = DateTime.parse(fromDate);
    final to = DateTime.parse(endDate);

    progressModel = await traineeRepository
        .getTraineeProgress(dateFormat.format(from), to: dateFormat.format(to));
  }

  getStartMonth() {
    final someDateTime = DateTime.now();
    final monthNumber = someDateTime.month;
    year = someDateTime.year;
    currentMonth = months[monthNumber - 1];
    currentMonthDays = daysInMonth(year, monthNumber);
  }

  getNextWeek() async {
    if (currentWeekEndDay == currentMonthDays) {
      _getNextMonth();
      currentWeekStartDay = 1;
      currentWeekEndDay = 7;
    } else if (currentWeekEndDay + 7 > currentMonthDays) {
      currentWeekStartDay = currentWeekEndDay + 1;
      currentWeekEndDay = currentMonthDays;
    } else {
      currentWeekStartDay = currentWeekEndDay + 1;
      currentWeekEndDay = currentWeekStartDay + 7;
      int l;
    }
    isLoading = true;
    await getUserProgress();
    isLoading = false;
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
      currentWeekEndDay =
          currentWeekStartDay - 1 == 0 ? 1 : currentWeekStartDay - 1;
      currentWeekStartDay =
          currentWeekEndDay - 7 == 0 ? 1 : currentWeekEndDay - 7;
    }
    isLoading = true;
    await getUserProgress();
    isLoading = false;
  }

  _getNextMonth() {
    int index = months.indexOf(currentMonth);

    if (index == months.length - 1) {
      index = -1;
    }
    currentMonth = months[index + 1];
    currentMonthDays = daysInMonth(year, index + 1);
  }

  _getPreviousMonth() {
    int index = months.indexOf(currentMonth);
    if (index == 0) {
      index == 12;
    }
    currentMonth = months[index - 1];
    currentMonthDays = daysInMonth(year, index);
  }

  String changeTextDayName(String dayName) {
    switch (dayName) {
      case 'Sunday':
        return 'Sun';
      case 'Monday':
        return 'Mon';
      case 'Tuesday':
        return 'Tues';
      case 'Wednesday':
        return 'Wed';
      case 'Thursday':
        return 'Thu';
      case 'Friday':
        return 'Fri';
      case 'Saturday':
        return 'Sat';
      default:
        return '';
    }
  }
}
