class NotificationModel {
  List<Data>? data;
  int? numberOfPages;
  int? numberOfResults;
  int? unReadNotification;

  NotificationModel(
      {this.data,
      this.numberOfPages,
      this.numberOfResults,
      this.unReadNotification});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    numberOfPages = json['number_of_pages'];
    numberOfResults = json['number_of_results'];
    unReadNotification = json['un_read_notification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['number_of_pages'] = this.numberOfPages;
    data['number_of_results'] = this.numberOfResults;
    data['un_read_notification'] = this.unReadNotification;
    return data;
  }
}

class Data {
  String? body;
  String? createdAt;

  Data({this.body, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = this.body;
    data['created_at'] = this.createdAt;
    return data;
  }
}
