class LoginData {
  LoginData({
    required this.id,
    required this.accessToken,
    required this.refreshToken,
    required this.isFirstTime,
    required this.isConfirmed,
    required this.confirmationCode,
  });

  final String id;
  final String accessToken;
  final String refreshToken;
  final bool isFirstTime;
  final bool isConfirmed;
  final dynamic confirmationCode;

  factory LoginData.fromJson(Map<String, dynamic> json){
    return LoginData(
      id: json["id"] ?? "",
      accessToken: json["access_token"] ?? "",
      refreshToken: json["refresh_token"] ?? "",
      isFirstTime: json["is_first_time"] ?? false,
      isConfirmed: json["is_confirmed"] ?? false,
      confirmationCode: json["confirmation_code"],
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

}
