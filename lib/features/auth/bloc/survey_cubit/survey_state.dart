part of 'survey_cubit.dart';

class SurveyInitial extends AbstractState<bool> {
  final FitnessSurvey request;
  // final bool surveyParam;

  const SurveyInitial({
    required super.result,
    super.error,
    required this.request,
    // required this.surveyParam,
    super.statuses,
  });

  factory SurveyInitial.initial() {
    return SurveyInitial(
      result: false,
      error: '',
      // surveyParam: false,
      request: FitnessSurvey.fromJson({}),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  SurveyInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    FitnessSurvey? request,
    // bool? surveyParam,
  }) {
    return SurveyInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      // surveyParam: surveyParam ?? this.surveyParam,
    );
  }
}
