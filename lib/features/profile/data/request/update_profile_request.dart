import 'package:fitness_storm/core/app/app_provider.dart';

class UpdateProfileRequest {
  UpdateProfileRequest({
    this.name,
    this.email,
    this.image,
    this.mobile,
    this.birthDate,
    this.gender,
  });

  String? name;
  String? email;
  String? image;
  String? mobile;
  DateTime? birthDate;
  String? gender;

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "mobile": mobile,
        "birth_date": birthDate?.toIso8601String(),
        "gender": gender,
      };

  factory UpdateProfileRequest.initial() {
    final user = AppProvider.profile;

    return UpdateProfileRequest(
      name: user.name,
      email: user.email,
      image: user.image,
      mobile: user.mobile,
      birthDate: user.birthDate,
      gender: user.gender,
    );
  }
}
