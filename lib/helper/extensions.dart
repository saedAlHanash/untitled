import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../Screen/Trainee Screens/coupon/coupon_cubit/coupon_cubit.dart';



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
}

extension SplitByLength on String {
  List<String> splitByLength1(int length, {bool ignoreEmpty = false}) {
    List<String> pieces = [];

    for (int i = 0; i < this.length; i += length) {
      int offset = i + length;
      var piece = substring(i, offset >= this.length ? this.length : offset);

      if (ignoreEmpty) {
        piece = piece.replaceAll(RegExp(r'\s+'), '');
      }

      pieces.add(piece);
    }
    return pieces;
  }

  bool get canSendToSearch {
    if (isEmpty) false;

    return split(' ').last.length > 2;
  }

  String get formatPrice => oCcy.format(this);

  String get removeSpace => replaceAll(' ', '');

  int get numberOnly {
    try {
      return int.parse(this);
    } on Exception {
      return 0;
    }
  }

  double get getCost {
    RegExp regExp = RegExp(r"(\d+\.\d+)");
    String? match = regExp.stringMatch(this);
    double number = double.parse(match ?? '0');
    return number;
  }

  String get removeDuplicates {
    List<String> words = split(' ');
    Set<String> uniqueWords = Set<String>.from(words);
    List<String> uniqueList = uniqueWords.toList();
    String output = uniqueList.join(' ');
    return output;
  }
}

extension StringHelper on String? {
  bool get isBlank {
    return this?.trim().isEmpty ?? true;
  }
}

final oCcy = NumberFormat("#,###", "en_US");

extension MaxInt on num {
  int get maxInt => 2147483647;

  String get formatPrice => oCcy.format(this);

  int get myRound {
    if (toInt() < this) return toInt() + 1;
    return toInt();
  }

  num getPercentage(num p) => this * p / 100;
}

extension CubitStateHelper on CubitStatuses {
  bool get isLoading => this == CubitStatuses.loading;

  bool get isDone => this == CubitStatuses.done;
}

extension FirstItem<E> on Iterable<E> {
  E? firstItem() {
    if (isEmpty) {
      return null;
    } else {
      return first;
    }
  }

  E? lastItem() {
    if (isEmpty) {
      return null;
    } else {
      return last;
    }
  }
}

extension DateUtcHelper on DateTime {
  int get hashDate => (day * 61) + (month * 83) + (year * 23);

  DateTime get getUtc => DateTime.utc(year, month, day);

  String get formatDate => DateFormat.yMd().format(this);

  String get formatTime {
    var t = DateFormat('h:mm a').format(this);

    return t.replaceAll('PM', 'م').replaceAll('AM', 'ص');
  }

  String get formatDateTime => '$formatDate $formatTime';

  String get formatFullDate => '$formatDayName  $formatDate  $formatTime';

  String get formatDayName {
    initializeDateFormatting();
    return DateFormat('EEEE', 'ar_SA').format(this);
  }

  DateTime addFromNow({int? year, int? month, int? day}) {
    return DateTime(
        this.year + (year ?? 0), this.month + (month ?? 0), this.day + (day ?? 0));
  }

  DateTime initialFromDateTime({required DateTime date, required TimeOfDay time}) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  String get formatDateAther => DateFormat('yyyy/MM/dd HH:MM').format(this);

  String formatDuration({DateTime? serverDate}) {
    final difference = this.difference(serverDate ?? DateTime.now());

    final months = difference.inDays ~/ 30;
    final days = difference.inDays % 30;
    final hours = difference.inHours % 24;
    final minutes = difference.inMinutes % 60;
    final seconds = difference.inSeconds % 60;

    final formattedDuration = StringBuffer();
    formattedDuration.write('since: ');
    var c = 0;
    if (months > 0) {
      c++;
      formattedDuration.write(' / $months Month');
    }
    if (days > 0 && c < 2) {
      c++;
      formattedDuration.write(' / $days Day');
    }
    if (hours > 0 && c < 2) {
      c++;
      formattedDuration.write(' / $hours Hour');
    }
    if (minutes > 0 && c < 2) {
      c++;
      formattedDuration.write(' / $minutes m');
    }
    if (seconds > 0 && c < 2) {
      c++;
      formattedDuration.write(' / $seconds s');
    }

    return formattedDuration.toString().trim().replaceFirst('/', '');
  }

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

extension ScrollMax on ScrollController {
  bool get isMax => position.maxScrollExtent == offset;

  bool get isMin => offset == 0;
}
