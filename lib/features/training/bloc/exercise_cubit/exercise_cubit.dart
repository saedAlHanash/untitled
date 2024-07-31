import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/exercises_response.dart';

part 'exercise_state.dart';

class ExercisesCubit extends MCubit<ExercisesInitial> {
  ExercisesCubit() : super(ExercisesInitial.initial());

  @override
  String get nameCache => 'exercises';

  @override
  String get filter => state.request ?? '';

  Future<void> getExercises({bool newData = false, required int id}) async {
    emit(state.copyWith(request: id));
    final checkData = await checkCashed1(
        state: state, fromJson: Exercise.fromJson, newData: newData);

    if (checkData) return;

    final pair = await _getExercises();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<Exercise>?, String?>> _getExercises() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.exercises(state.request),
    );

    if (response.statusCode.success) {
      return Pair([], null);
    } else {
      return response.getPairError;
    }
  }

  Future<List<Exercise>> getExercisesAsync(
      {bool newData = false, required int id}) async {
    emit(state.copyWith(request: id));

    var list = <Exercise>[];
    final checkData = await checkCashed1(
      state: state,
      fromJson: Exercise.fromJson,
      newData: newData,
      onSuccess: (data, state) => list = data,
    );

    if (checkData) list;

    final pair = await _getExercises();

    if (pair.first != null) {
      await storeData(pair.first!);
      list = pair.first!;
      return list;
    }
    return list;
  }
}
