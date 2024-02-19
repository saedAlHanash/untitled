import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/util/shared_preferences.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../response/profile_response.dart';

class UpdateProfileRequest {
  UpdateProfileRequest({
    this.name,
    this.emailOrPhone,

    this.receiverPhone,
    this.governorId,
    this.address,
    this.oldPass,
    this.newPass,
    this.rePass,
  });

  String? receiverPhone;
  int? governorId;
  String? address;
  String? name;
  String? emailOrPhone;


  UploadFile? avatar;
  String? oldPass;
  String? newPass;
  String? rePass;

  UpdateType? type;

  factory UpdateProfileRequest.initial() {
    final user = AppProvider.profile;
    return UpdateProfileRequest(
      name: user.name,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email_or_phone": emailOrPhone,
        "address": address,
        "old_password": oldPass,
        "new_password": newPass,
        "receiver_phone": receiverPhone,
        "governor_id": governorId == 0 ? null : governorId,
        "new_password_confirmation": rePass,
      }..removeWhere((key, value) => value == null);
}
