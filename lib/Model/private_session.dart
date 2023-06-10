import 'dart:developer';

import 'package:intl/intl.dart';

class Wallet {
  int? id;
  int? price;
  String? type;
  int? balance;
  String? file;
  String? time;

  Wallet(
      {required this.id,
      required this.price,
      required this.type,
      required this.balance,
      required this.file,
      required this.time});

  Wallet.fromJson(Map<String, dynamic> json) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
    DateTime dateTime = dateFormat.parse(json['time']);
    String day = dateTime.day.toString();
    String month = months[dateTime.month - 1];
    String timehour = '${dateTime.hour}:${dateTime.minute}';
    String date = '${day}, ${month} ${timehour}'; //dateFormat.format(dateTime);
    id = json['id'];
    price = json['price'];
    type = json['type'];
    balance = json['balance'];
    file = json['file'];
    time = date;
    log(time!);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['type'] = this.type;
    data['balance'] = this.balance;
    data['file'] = this.file;
    data['time'] = this.time;
    return data;
  }
}
