import 'package:fitness_storm/core/extensions/extensions.dart';

class NotificationsResponse {
  NotificationsResponse({
    required this.data,
    required this.numberOfPages,
    required this.numberOfResults,
    required this.unReadNotification,
  });

  final List<NotificationModel> data;
  final num numberOfPages;
  final num numberOfResults;
  final num unReadNotification;

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    return NotificationsResponse(
      data: json["data"] == null
          ? []
          : List<NotificationModel>.from(
              json["data"]!.map((x) => NotificationModel.fromJson(x))),
      numberOfPages: json["number_of_pages"] ?? 0,
      numberOfResults: json["number_of_results"] ?? 0,
      unReadNotification: json["un_read_notification"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x?.toJson()).toList(),
        "number_of_pages": numberOfPages,
        "number_of_results": numberOfResults,
        "un_read_notification": unReadNotification,
      };
}

class NotificationModel {
  String get getCreatedAt {
    if (createdAt == null) return '';
    var date = createdAt!.fixTimeZone;
    String text = '';
    text = '${date.formatTime}\n${date.formatDate}';

    return text;
  }

  NotificationModel({
    required this.title,
    required this.body,
    required this.type,
    required this.data,
    required this.createdAt,
  });

  final String title;
  final String body;
  final String type;
  final Data? data;
  final DateTime? createdAt;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json["title"] ?? "",
      body: json["body"] ?? "",
      type: json["type"] ?? "",
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "type": type,
        "data": data?.toJson(),
        "created_at": createdAt?.toIso8601String(),
      };
}

class Data {
  Data({
    required this.date,
  });

  final DateTime? date;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      date: DateTime.tryParse(json["date"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "date": date?.toIso8601String(),
      };
}
