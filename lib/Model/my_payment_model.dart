class MyPayments {
  NextPayment? nextPayment;
  List<Payments>? payments;

  MyPayments({this.nextPayment, this.payments});

  MyPayments.fromJson(Map<String, dynamic> json) {
    nextPayment = json['next_payment'] != null
        ? NextPayment.fromJson(json['next_payment'])
        : null;
    if (json['payments'] != null) {
      payments = <Payments>[];
      json['payments'].forEach((v) {
        payments!.add(Payments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data  = <String, dynamic>{};
    if (nextPayment != null) {
      data['next_payment'] = nextPayment!.toJson();
    }
    if (payments != null) {
      data['payments'] = payments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NextPayment {
  int? amount;
  String? description;

  NextPayment({this.amount, this.description});

  NextPayment.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data  = <String, dynamic>{};
    data['amount'] = amount;
    data['description'] = description;
    return data;
  }
}

class Payments {
  int? payment;
  String? paidAt;
  String? description;

  Payments({this.payment, this.paidAt, this.description});

  Payments.fromJson(Map<String, dynamic> json) {
    payment = json['payment'];
    paidAt = json['paid_at'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data  = <String, dynamic>{};
    data['payment'] = payment;
    data['paid_at'] = paidAt;
    data['description'] = description;
    return data;
  }
}
