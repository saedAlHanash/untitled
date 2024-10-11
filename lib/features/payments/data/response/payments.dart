class Payments {
  Payments({
    required this.data,
  });

  final List<Payment> data;

  factory Payments.fromJson(Map<String, dynamic> json) {
    return Payments(
      data: json["data"] == null
          ? []
          : List<Payment>.from(json["data"]!.map((x) => Payment.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Payment {
  Payment({
    required this.id,
    required this.subscriptionId,
    required this.duration,
    required this.price,
    required this.endsAt,
    required this.type,
    required this.code,
    required this.couponAmount,
    required this.isPaid,
  });

  final String id;
  final int subscriptionId;
  final num duration;
  final num price;
  final DateTime? endsAt;
  final String type;
  final dynamic code;
  final dynamic couponAmount;
  final bool isPaid;

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json["id"] ?? "",
      subscriptionId: json["subscription_id"] ?? 0,
      duration: json["duration"] ?? 0,
      price: json["price"] ?? 0,
      endsAt: DateTime.tryParse(json["ends_at"] ?? ""),
      type: json["type"] ?? "",
      code: json["code"],
      couponAmount: json["coupon_amount"],
      isPaid: json["is_paid"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "subscription_id": subscriptionId,
        "duration": duration,
        "price": price,
        "ends_at": endsAt?.toIso8601String(),
        "type": type,
        "code": code,
        "coupon_amount": couponAmount,
        "is_paid": isPaid,
      };
}
