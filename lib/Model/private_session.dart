

class Wallet {
  int? id;
  num? price;
  String? type;
  num? balance;
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
    DateTime dateTime = (DateTime.tryParse(json['time'])??DateTime(1900));
    String day = dateTime.day.toString();
    String month = months[dateTime.month - 1];
    String timehour = '${dateTime.hour}:${dateTime.minute}';
    String date = '$day, $month $timehour'; //dateFormat.format(dateTime);
    id = json['id'];
    price = json['price'];
    type = json['type'];
    balance = json['balance'];
    file = json['file'];
    time = date;
    //log(time!);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data  = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['type'] = type;
    data['balance'] = balance;
    data['file'] = file;
    data['time'] = time;
    return data;
  }
}
