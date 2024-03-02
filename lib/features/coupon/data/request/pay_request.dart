class PayRequest {
  PayRequest({
    this.name,
    this.phone,
    this.email,
    this.code,
    this.subscriptionId,
  });

  String? name;
  String? phone;
  String? email;
  String? code;
  String? subscriptionId;

  factory PayRequest.fromJson(Map<String, dynamic> json) {
    return PayRequest(
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      email: json["email"] ?? "",
      code: json["code"] ?? "",
      subscriptionId: json["subscription_id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "code": code,
        "subscription_id": subscriptionId,
      }..removeWhere((key, value) => value == null);
}
