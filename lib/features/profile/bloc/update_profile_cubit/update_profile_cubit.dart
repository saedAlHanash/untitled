import 'dart:async';

import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../generated/l10n.dart';
import '../../data/response/profile_response.dart';

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

    await APIService().postApi(
      url: PostUrl.survey,
      body: state.request.fitnessSurvey.toJson(),
    );

    final response = await APIService().postApi(
      url: PostUrl.updateProfile,
      body: state.request.toJson(),
    );

    if (response.statusCode.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }

  set setName(String? val) => state.request.name = val;

  set setEmail(String? val) => state.request.email = val;

  set setPhone(String? val) => state.request.mobile = val;

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

  String? get validatePhoneOrEmail {
    if (state.request.email.isBlank) {
      return '${S().email} - ${S().phoneNumber}'
          ' ${S().isRequired}';
    }
    return null;
  }
}
