import 'package:fitness_storm/core/util/shared_preferences.dart';

class ResetPasswordRequest {
  ResetPasswordRequest({
    this.password,
    this.code,
  });

  String? password;
  String? code;

  Map<String, dynamic> toJson() => {
        "email": AppSharedPreference.getRestPassEmail,
        "code": code,
        "password": password,
      };
}
