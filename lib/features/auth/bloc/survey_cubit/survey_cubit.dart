import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../profile/data/response/profile_response.dart';

part 'survey_state.dart';

class SurveyCubit extends Cubit<SurveyInitial> {
  SurveyCubit() : super(SurveyInitial.initial());

  Future<void> updateSurvey() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _bookedAppointmentsApi();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  void setRequest(FitnessSurvey request) {
    emit(state.copyWith(request: request));
  }

  Future<Pair<bool?, String?>> _bookedAppointmentsApi() async {
    final response = await APIService().postApi(
      url: PostUrl.survey,
      body: state.request.toJson(),
    );

    if (response.statusCode.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }
}
