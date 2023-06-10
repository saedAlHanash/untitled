class SubscriptionsModel {
  int? privateSessionSubscription;
  List<SubscriptionsPlans>? subscriptionsPlans;

  SubscriptionsModel(
      {this.privateSessionSubscription, this.subscriptionsPlans});

  SubscriptionsModel.fromJson(Map<String, dynamic> json) {
    privateSessionSubscription = json['private_session_subscription'];
    if (json['subscriptions'] != null) {
      subscriptionsPlans = <SubscriptionsPlans>[];
      json['subscriptions'].forEach((v) {
        subscriptionsPlans!.add(SubscriptionsPlans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['private_session_subscription'] = privateSessionSubscription;
    if (subscriptionsPlans != null) {
      data['subscriptions'] =
          subscriptionsPlans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubscriptionsPlans {
  String? id;
  int? duration;
  double? price;
  String? type;
  bool? currentSubscription;

  SubscriptionsPlans(
      {this.id,
      this.duration,
      this.price,
      this.type,
      this.currentSubscription});

  SubscriptionsPlans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    duration = json['duration'];

    price = double.parse(json['price'].toString());
    type = json['type'];
    currentSubscription = json['current_subscription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['duration'] = duration;
    data['price'] = price;
    data['type'] = type;
    data['current_subscription'] = currentSubscription;
    return data;
  }
}
