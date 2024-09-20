import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:m_cubit/abstraction.dart';

import '../api_manager/api_service.dart';
import '../api_manager/api_url.dart';
import '../error/error_manager.dart';
import '../models/booked_appointments.dart';
import '../strings/enum_manager.dart';
import '../util/pair_class.dart';
import '../widgets/spinner_widget.dart';

extension SplitByLength on String {
  List<String> splitByLength1(int length, {bool ignoreEmpty = false}) {
    List<String> pieces = [];

    for (int i = 0; i < this.length; i += length) {
      int offset = i + length;
      String piece = substring(i, offset >= this.length ? this.length : offset);

      if (ignoreEmpty) {
        piece = piece.replaceAll(RegExp(r'\s+'), '');
      }

      pieces.add(piece);
    }
    return pieces;
  }

  AttachmentType getLinkType({AttachmentType? type}) {
    if (type == AttachmentType.video) {
      if (contains('youtube')) {
        return AttachmentType.youtube;
      } else {
        return AttachmentType.video;
      }
    }
    return AttachmentType.image;
  }

  bool get canSendToSearch {
    if (isEmpty) false;

    return split(' ').last.length > 2;
  }

  int get numberOnly {
    final regex = RegExp(r'\d+');

    final numbers = regex.allMatches(this).map((match) => match.group(0)).join();

    try {
      return int.parse(numbers);
    } on Exception {
      return 0;
    }
  }

  String fixPhone() {
    if (startsWith('0')) return this;

    return '0$this';
  }

  String get formatPrice => '${oCcy.format(numberOnly)}.0';

  bool get isZero => (num.tryParse(this) ?? 0) == 0;

  String get removeSpace => replaceAll(' ', '');

  OrderStatus get getStatusEnum {
    if (toLowerCase() == 'pending') return OrderStatus.pending;
    if (toLowerCase() == 'accepted') return OrderStatus.accepted;
    if (toLowerCase() == 'shipped') return OrderStatus.shipped;
    if (toLowerCase() == 'delivered') return OrderStatus.delivered;
    if (toLowerCase() == 'canceled') return OrderStatus.canceled;
    return OrderStatus.pending;
  }

  DeviceStatus get getDeviceStatusEnum {
    if (toLowerCase() == 'pending') return DeviceStatus.pending;
    if (toLowerCase() == 'accepted') return DeviceStatus.accepted;
    if (toLowerCase() == 'notfound') return DeviceStatus.notFound;
    if (toLowerCase() == 'rejected') return DeviceStatus.reject;
    return DeviceStatus.accepted;
  }

  WalletType get getWalletType {
    if (toLowerCase() == 'income') return WalletType.income;
    if (toLowerCase() == 'invoice') return WalletType.invoice;
    return WalletType.income;
  }

  num get tryParseOrZero => num.tryParse(this) ?? 0;

  int get tryParseOrZeroInt => int.tryParse(this) ?? 0;

  bool get tryParseBoolOrFalse => toString() == '1' || toString() == 'true';

  String get fixAvatarImage {
    if (startsWith('http') || isEmpty) return this;
    final String link = "https://$baseUrl/$this";
    return link;
  }
}

extension StringHelper on String? {
  bool get isBlank {
    if (this == null) return true;
    return this!.replaceAll(' ', '').isEmpty;
  }

  String get fixAvatarImage {
    if (this == null) return '';
    if (this!.startsWith('http')) return this!;
    final String link = "https://$baseUrl/$this";
    return link;
  }

  bool get getBool {
    if (this == null) return false;
    final pars = int.tryParse(this!);
    if (pars == null) return this! == 'true';
    return pars == 1;
  }
}

final oCcy = NumberFormat("#,###", "en_US");

extension MaxInt on num {
  int get max => 2147483647;

  String get formatPrice => oCcy.format(this);
}

extension NumH on num? {
  bool get isEmpty => this == null || this == 0;
}

extension HelperJson on Map<String, dynamic> {
  num getAsNum(String key) {
    if (this[key] == null) return -1;
    return num.tryParse((this[key]).toString()) ?? -1;
  }
}

extension ResponseHelper on http.Response {
  Map<String, dynamic> get jsonBody {
    try {
      return jsonDecode(body)['data'] ?? {};
    } catch (e) {
      return jsonDecode('{}');
    }
  }

  Map<String, dynamic> get jsonBodyPure {
    try {
      return jsonDecode(body);
    } catch (e) {
      return jsonDecode('{}');
    }
  }

  Map<String, dynamic> get jsonBodyData {
    try {
      if (body.startsWith('[')) {
        final convertString = '{"data": $body}';
        final json = jsonDecode(convertString);
        return json;
      }
      return jsonDecode(body);
    } catch (e) {
      loggerObject.e(e);
      return jsonDecode('{}');
    }
  }

  // Pair<T?, String?> getPairError<T>() {
  //   return Pair(null, ErrorManager.getApiError(this));
  // }
  get getPairError {
    return Pair(null, ErrorManager.getApiError(this));
  }
}

extension CubitStatusesHelper on CubitStatuses {
  bool get loading => this == CubitStatuses.loading;

  bool get done => this == CubitStatuses.done;
}

extension FormatDuration on Duration {
  String get format =>
      '${inMinutes.remainder(60).toString().padLeft(2, '0')}:${(inSeconds.remainder(60)).toString().padLeft(2, '0')}';
}

extension ApiStatusCode on int {
  bool get success => (this >= 200 && this <= 210);

  //
  // int get countDiv2 {
  //   final dr = this / 2; //double result
  //   final ir = this ~/ 2; //int result
  //   return (ir < dr) ? ir + 1 : ir;
  // }
  int get countDiv2 => (this ~/ 2 < this / 2) ? this ~/ 2 + 1 : this ~/ 2;
}

extension TextEditingControllerHelper on TextEditingController {
  void clear() {
    if (text.isNotEmpty) text = '';
  }
}

extension DateUtcHelper on DateTime {
  int get hashDate => (day * 61) + (month * 83) + (year * 23);

  DateTime get getUtc => DateTime.utc(year, month, day);

  String get formatDate => DateFormat('yyyy/MM/dd', 'en').format(this);

  String get formatDateAther => DateFormat('yyyy-MM-dd HH:mm', 'en').format(this);

  String get formatTime => DateFormat('hh:mm a', 'en').format(this);

  String get dayName => DateFormat('EEEE').format(this);

  String get monthName => DateFormat('MMMM').format(this);

  String get formatDateTime => '$formatDate - $formatTime';

  String get formatDateTimeVertical => '$formatDate\n$formatTime';

  DateTime addFromNow({int? year, int? month, int? day, int? hour}) {
    return DateTime(
      this.year + (year ?? 0),
      this.month + (month ?? 0),
      this.day + (day ?? 0),
      this.hour + (hour ?? 0),
    );
  }

  DateTime initialFromDateTime({required DateTime date, required TimeOfDay time}) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  FormatDateTime getFormat({DateTime? serverDate}) {
    final difference = this.difference(serverDate ?? DateTime.now());

    final months = difference.inDays.abs() ~/ 30;
    final days = difference.inDays.abs() % 360;
    final hours = difference.inHours.abs() % 24;
    final minutes = difference.inMinutes.abs() % 60;
    final seconds = difference.inSeconds.abs() % 60;
    return FormatDateTime(
      months: months,
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );
  }

  String formatDuration({DateTime? serverDate}) {
    final result = getFormat(serverDate: serverDate);

    final formattedDuration = StringBuffer();

    formattedDuration.write('منذ: ');
    var c = 0;
    if (result.months > 0) {
      c++;
      formattedDuration.write('و ${result.months} شهر ');
    }
    if (result.days > 0 && c < 2) {
      c++;
      formattedDuration.write('و ${result.days} يوم  ');
    }
    if (result.hours > 0 && c < 2) {
      c++;
      formattedDuration.write('و ${result.hours} ساعة  ');
    }
    if (result.minutes > 0 && c < 2) {
      c++;
      formattedDuration.write('و ${result.minutes} دقيقة  ');
    }
    if (result.seconds > 0 && c < 2) {
      c++;
      formattedDuration.write('و ${result.seconds} ثانية ');
    }

    return formattedDuration.toString().trim().replaceFirst('و', '');
  }

  int get getWeekNumber {
    final DateTime firstJan = DateTime(year, 1, 1);
    // final int daysInYear = DateTime(year + 1, 1, 1).difference(firstJan).inDays;
    final int weekNumber = (difference(firstJan).inDays ~/ 7) + 1;
    // If the date is after the first Monday of the year, then it is in the current week.
    if (weekday >= 1) {
      return weekNumber;
    }
    // Otherwise, it is in the previous week.
    return weekNumber - 1;
  }

  DateTime get fixTimeZone => add(DateTime.now().timeZoneOffset);
}

extension FirstItem<E> on Iterable<E> {
  E? get firstItem => isEmpty ? null : first;
}

extension GetDateTimesBetween on DateTime {
  List<DateTime> getDateTimesBetween({
    required DateTime end,
    required Duration period,
  }) {
    var dateTimes = <DateTime>[];
    var current = add(period);
    while (current.isBefore(end)) {
      if (dateTimes.length > 24) {
        break;
      }
      dateTimes.add(current);
      current = current.add(period);
    }
    return dateTimes;
  }
}

extension EnumsH on List {
  List<SpinnerItem> getSpinnerItems({int? selected}) {
    return map(
      (e) => SpinnerItem(
        isSelected: e.index == selected,
        id: e.index,
        name: e.name,
        item: e,
      ),
    ).toList();
  }
}

extension AppointmentH on Appointment {
  bool get isNow {
    final dateTimeNow = DateTime.now().toUtc();

    final b = dateTimeNow.isAfter(startTime.toUtc());
    final a = dateTimeNow.isBefore(endTime.toUtc());

    // loggerObject.e('$a $b');
    return a && b;
  }

  bool get isExpired {
    final dateTimeNow = DateTime.now().toUtc();
    final a = dateTimeNow.isAfter(endTime.toUtc());
    return a;
  }
}

class FormatDateTime {
  final int months;
  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  const FormatDateTime({
    required this.months,
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });
}

extension NeedUpdateEnumH on NeedUpdateEnum {
  bool get loading => this == NeedUpdateEnum.withLoading;

  bool get haveData => this == NeedUpdateEnum.no || this == NeedUpdateEnum.noLoading;

  CubitStatuses get getState {
    switch (this) {
      case NeedUpdateEnum.no:
        return CubitStatuses.done;
      case NeedUpdateEnum.withLoading:
        return CubitStatuses.loading;
      case NeedUpdateEnum.noLoading:
        return CubitStatuses.done;
    }
  }
}

extension ReadOrNull on BuildContext? {
  T? readOrNull<T>() {
    try {
      return this!.read<T>();
    } on ProviderNotFoundException catch (_) {
      return null;
    }
  }
}
