import 'dart:typed_data';

import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Utils/utils.dart';
import '../../../../core/api_manager/api_helper.dart';
import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../generated/l10n.dart';
import '../../data/request/apply_request.dart';

part 'apply_state.dart';

class ApplyCubit extends Cubit<ApplyInitial> {
  ApplyCubit() : super(ApplyInitial.initial());

  Future<void> sendRequest() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _sendRequestApi();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _sendRequestApi() async {
    final response = await APIService().uploadMultiPart(
      url: PostUrl.apply,
      additional: '',
      fields: state.request.toJson(),
      files: [
        state.request.cv,
        state.request.certificateOfGraduation,
        state.request.certificateOfCourseAttended,
      ],
    );

    if (response.statusCode.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }

  set setName(String? name) => state.request.name = name;

  set setPhone(String? phone) => state.request.phone = phone;

  set setEmail(String? email) => state.request.email = email;

  set setCv(Uint8List bytes) {
    state.request.cv = UploadFile(
      fileBytes: bytes,
      nameField: 'cv',
    );
    emit(state.copyWith(tempParam: state.tempParam + 1));
  }

  set setCertificateOfGraduation(Uint8List bytes) {
    state.request.certificateOfGraduation = UploadFile(
      fileBytes: bytes,
      nameField: 'certificateofgraduation',
    );
    emit(state.copyWith(tempParam: state.tempParam + 1));
  }

  set setCertificateOfCourseAttended(Uint8List bytes) {
    state.request.certificateOfCourseAttended = UploadFile(
      fileBytes: bytes,
      nameField: 'certificateofcoursesattended',
    );
    emit(state.copyWith(tempParam: state.tempParam + 1));
  }

  String? get validateName {
    if ((state.request.name ?? '').isEmpty) {
      return S().nameEmpty;
    }
    return null;
  }

  String? get validatePhone {
    if (state.request.phone.isBlank) {
      return '';
    }
    return null;
  }

  String? get validateEmail {
    if (state.request.email.isBlank) {
      return '';
    }
    return null;
  }

  String? get validateCv {
    if (state.request.cv.fileBytes == null) {
      return '${S().cv} ${S().isRequired}';
    }
    return null;
  }

  String? get validateCertificateOfGraduation {
    if (state.request.certificateOfGraduation.fileBytes == null) {
      return '${S().certificateOfGraduation} ${S().isRequired}';
    }
    return null;
  }

  String? get validateCertificateOfCourseAttended {
    if (state.request.certificateOfCourseAttended.fileBytes == null) {
      return '${S().certificateOfCourseAttended} ${S().isRequired}';
    }
    return null;
  }

  bool validateImages() {
    if (validateCv?.isNotEmpty == true) {
      Utils.openSnackBar(title: '', message: validateCv!);
      return false;
    }
    if (validateCertificateOfGraduation?.isNotEmpty == true) {
      Utils.openSnackBar(title: '', message: validateCertificateOfGraduation!);
      return false;
    }
    if (validateCertificateOfCourseAttended?.isNotEmpty == true) {
      Utils.openSnackBar(title: '', message: validateCertificateOfCourseAttended!);
      return false;
    }
    return true;
  }
}
