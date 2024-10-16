import '../../../../core/strings/enum_manager.dart';

class Subscriptions {
  Subscriptions({
    required this.data,
  });

  final Data data;

  factory Subscriptions.fromJson(Map<String, dynamic> json) {
    return Subscriptions(
      data: Data.fromJson(json["data"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.privateSessionSubscription,
    required this.subscriptions,
  });

  final num privateSessionSubscription;
  final List<Subscription> subscriptions;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      privateSessionSubscription: json["private_session_subscription"] ?? 0,
      subscriptions: json["subscriptions"] == null
          ? []
          : List<Subscription>.from(
              json["subscriptions"]!.map((x) => Subscription.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "private_session_subscription": privateSessionSubscription,
        "subscriptions": subscriptions.map((x) => x.toJson()).toList(),
      };
}

class Subscription {
  Subscription({
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
  final SubscriptionType type;
  final num isActive;
  final num countOfSubscribers;
  final bool currentSubscription;
  final num discountPercentage;

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json["id"] ?? "",
      duration: json["duration"] ?? 0,
      price: json["price"] ?? 0,
      priceAfterDiscount: json["price_after_discount"] ?? 0,
      type: SubscriptionType.byName(json["type"] ?? ""),
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
        "type": type.name,
        "is_active": isActive,
        "count_of_subscribers": countOfSubscribers,
        "current_subscription": currentSubscription,
        "discount_percentage": discountPercentage,
      };
}
