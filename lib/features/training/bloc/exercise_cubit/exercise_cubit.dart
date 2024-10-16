import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/exercises_response.dart';

part 'exercise_state.dart';

class ExercisesCubit extends MCubit<ExercisesInitial> {
  ExercisesCubit() : super(ExercisesInitial.initial());

  @override
  String get nameCache => 'exercises';

  @override
  String get filter => state.filter;

  Future<void> getExercises({bool newData = false, required int id}) async {
    emit(state.copyWith(request: id));
    await getDataAbstract(
      fromJson: Exercise.fromJson,
      state: state,
      getDataApi: _getDataApi,
    );
  }

  Future<Pair<List<Exercise>?, String?>> _getDataApi() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.exercises(state.request),
    );

    if (response.statusCode.success) {
      final json = response.jsonBodyPure;
      return Pair(
          json["data"] == null
              ? []
              : List<Exercise>.from(json["data"]!.map((x) => Exercise.fromJson(x))),
          null);
    } else {
      return response.getPairError;
    }
  }
}
