import 'package:fitness_storm/core/extensions/extensions.dart';

class LoginData {
  LoginData({
    required this.id,
    required this.accessToken,
    required this.refreshToken,
    required this.isFirstTime,
    required this.isConfirmed,
    required this.confirmationCode,
  });

  final int id;
  final String accessToken;
  final String refreshToken;
  final bool isFirstTime;
  final bool isConfirmed;
  final String confirmationCode;

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      id: json["id"].toString().tryParseOrZeroInt,
      accessToken: json["access_token"] ?? "",
      refreshToken: json["refresh_token"] ?? "",
      isFirstTime: json["is_first_time"] ?? false,
      isConfirmed: json["is_confirmed"] ?? false,
      confirmationCode: json["confirmation_code"]?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "is_first_time": isFirstTime,
        "is_confirmed": isConfirmed,
        "confirmation_code": confirmationCode,
      };

  LoginData copyWith({
    int? id,
    String? accessToken,
    String? refreshToken,
    bool? isFirstTime,
    bool? isConfirmed,
    String? confirmationCode,
  }) {
    return LoginData(
      id: id ?? this.id,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      confirmationCode: confirmationCode ?? this.confirmationCode,
    );
  }
}
