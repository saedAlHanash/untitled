import 'dart:async';
import 'dart:typed_data';

import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_widget.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../generated/l10n.dart';
import '../../data/response/profile_response.dart';
import '../profile_cubit/profile_cubit.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileInitial> {
  UpdateProfileCubit() : super(UpdateProfileInitial.initial());

  Future<void> updateProfile() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _updateProfileApi();

    if (pair.first == null) {
      emit(state.copyWith(error: pair.second, statuses: CubitStatuses.error));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _updateProfileApi() async {
    await APIService().callApi(type: ApiType.post,
      url: PostUrl.survey,
      body: state.request.fitnessSurvey.toJson(),
    );

    final response = await APIService().uploadMultiPart(
      url: PostUrl.updateProfile,
      fields: state.request.toJsonForUpdate(),
      files: [state.request.avatar],
    );

    if (response.statusCode.success) {
      ctx!.read<ProfileCubit>().getProfile(newData: true);
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }

  set setName(String? val) => state.request.name = val;

  set setAvatar(Uint8List bytes) {
    state.request.avatar = UploadFile(
      fileBytes: bytes,
      nameField: 'image',
    );
  }

  set setEmail(String? val) => state.request.email = val;

  set setPhone(String? val) => state.request.mobile = val;

  set setDate(DateTime? val) => state.request.birthDate = val;

  set setGender(String? val) => state.request.gender = val;

  set setWeight(num? val) => state.request.fitnessSurvey.weight = val;

  set setHeight(num? val) => state.request.fitnessSurvey.height = val;

  set setDailyExercise(num? val) => state.request.fitnessSurvey.dailyExercise = val;

  set setWeeklyExercise(num? val) => state.request.fitnessSurvey.weeklyExercise = val;

  set setTrainingGoal(String? val) => state.request.fitnessSurvey.trainingGoal = val;

  set setPreferredWorkoutLocationId(String? val) =>
      state.request.fitnessSurvey.preferredWorkoutLocationId = val;

  set setTrainingLevelId(String? val) =>
      state.request.fitnessSurvey.trainingLevelId = val;

  String? get validateName {
    if (state.request.name.isBlank) {
      return S().nameEmpty;
    }
    return null;
  }

  String? get validateEmail {
    if (!(state.request.email ?? '').isEmail) {
      return '${S().wrong} ${S().email}';
    }
    return null;
  }

  String? get validatePhone {
    if (state.request.mobile.isBlank) {
      return '${S().wrong} ${S().phone}';
    }
    return null;
  }

  String? get validateDate {
    if (state.request.birthDate == null) {
      return '${S().wrong} ${S().birthDate}';
    }
    return null;
  }

  String? get validateWeight {
    if (state.request.fitnessSurvey.weight.isEmpty) {
      return '${S().wrong} ${S().weight}';
    }
    return null;
  }

  String? get validateHeight {
    if (state.request.fitnessSurvey.height.isEmpty) {
      return '${S().wrong} ${S().height}';
    }
    return null;
  }

  String? get validateDays {
    if (state.request.fitnessSurvey.dailyExercise.isEmpty) {
      return '${S().wrong} ${S().hoursDay}';
    }
    return null;
  }

  String? get validateHours {
    if (state.request.fitnessSurvey.weeklyExercise.isEmpty) {
      return '${S().wrong} ${S().daysWeek}';
    }
    return null;
  }
}
