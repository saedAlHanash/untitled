
import '../../../../core/api_manager/api_service.dart';

class ApplyRequest {
  String? name;
  String? phone;
  String? email;
  var cv = UploadFile(nameField: 'cv');
  var certificateOfGraduation = UploadFile(nameField: 'certificateofgraduation');
  var certificateOfCourseAttended = UploadFile(nameField: 'certificateofcourseattended');

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mobile': phone,
      'email': email,
    };
  }
}
