class SubscriptionsResponse {
  SubscriptionsResponse({
    required this.data,
  });

  final SubscriptionsModel data;

  factory SubscriptionsResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionsResponse(
      data: SubscriptionsModel.fromJson(json["data"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class SubscriptionsModel {
  SubscriptionsModel({
    required this.privateSessionSubscription,
    required this.subscriptions,
  });

  final num privateSessionSubscription;
  final List<SubscriptionsPlans> subscriptions;

  factory SubscriptionsModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionsModel(
      privateSessionSubscription: json["private_session_subscription"] ?? 0,
      subscriptions: json["subscriptions"] == null
          ? []
          : List<SubscriptionsPlans>.from(
              json["subscriptions"]!.map((x) => SubscriptionsPlans.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "private_session_subscription": privateSessionSubscription,
        "subscriptions": subscriptions.map((x) => x.toJson()).toList(),
      };
}

class SubscriptionsPlans {
  SubscriptionsPlans({
    required this.id,
    required this.duration,
    required this.price,
    required this.priceAfterDiscount,
    required this.type,
    required this.isActive,
    required this.countOfSubscribers,
    required this.currentSubscription,
    required this.discountPercentage,
  });

  final String id;
  final num duration;
  final num price;
  final num priceAfterDiscount;
  final String type;
  final num isActive;
  final num countOfSubscribers;
   bool currentSubscription;
  final num discountPercentage;

  factory SubscriptionsPlans.fromJson(Map<String, dynamic> json) {
    return SubscriptionsPlans(
      id: json["id"] ?? "",
      duration: json["duration"] ?? 0,
      price: json["price"] ?? 0,
      priceAfterDiscount: json["price_after_discount"] ?? 0,
      type: json["type"] ?? "",
      isActive: json["is_active"] ?? 0,
      countOfSubscribers: json["count_of_subscribers"] ?? 0,
      currentSubscription: json["current_subscription"] ?? false,
      discountPercentage: json["discount_percentage"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "duration": duration,
        "price": price,
        "price_after_discount": priceAfterDiscount,
        "type": type,
        "is_active": isActive,
        "count_of_subscribers": countOfSubscribers,
        "current_subscription": currentSubscription,
        "discount_percentage": discountPercentage,
      };
}


