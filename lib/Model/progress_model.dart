import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:get/get.dart';
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
  DateTime? from;
  DateTime? to;

  String get inMinute {
    if (from == null || to == null) return '0 ${'minute'.tr}';
    return '${(to!.difference(from!).inSeconds.abs()/60).toStringAsFixed(2)} ${'minute'.tr}';
  }

  LogUser({this.title, this.from, this.to});

  LogUser.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    from = DateTime.tryParse(json['from'] ?? '');
    to = DateTime.tryParse(json['to'] ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['from'] = from?.toIso8601String();
    data['to'] = to?.toIso8601String();
    return data;
  }
}
