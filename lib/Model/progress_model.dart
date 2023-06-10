import 'package:intl/intl.dart';

class ProgressModel {
  String? type;
  LogUser? logUser;

  ProgressModel({this.type, this.logUser});

  ProgressModel.fromJson(Map<String, dynamic> json) {
    logUser =
        json['LogUser'] != null ? LogUser.fromJson(json['LogUser']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (logUser != null) {
      data['LogUser'] = logUser!.toJson();
    }
    return data;
  }
}

class LogUser {
  String? title;
  String? from;
  String? to;

  LogUser({this.title, this.from, this.to});

  LogUser.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    from = DateFormat('yyyy-MM-dd').format(DateTime.parse(json['from']));
    to = DateFormat('yyyy-MM-dd').format(DateTime.parse(json['to']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}
