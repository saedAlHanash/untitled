import 'package:fitness_storm/core/extensions/extensions.dart';

import '../../../../core/strings/enum_manager.dart';

class WalletResponse {
  WalletResponse({
    required this.data,
  });

  final List<Wallet> data;

  factory WalletResponse.fromJson(Map<String, dynamic> json) {
    return WalletResponse(
      data: json["data"] == null
          ? []
          : List<Wallet>.from(json["data"]!.map((x) => Wallet.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Wallet {
  Wallet({
    required this.id,
    required this.price,
    required this.type,
    required this.balance,
    required this.time,
  });

  final int id;
  final num price;
  final WalletType type;
  final num balance;
  final DateTime? time;

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json["id"] ?? 0,
      price: json["price"] ?? 0,
      type: (json["type"] ?? "").toString().getWalletType,
      balance: json["balance"] ?? 0,
      time: DateTime.tryParse(json["time"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "type": type.name,
        "balance": balance,
        "time": time?.toIso8601String(),
      };
}
