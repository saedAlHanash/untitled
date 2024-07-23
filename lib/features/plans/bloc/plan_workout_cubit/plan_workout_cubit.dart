import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/plan_workout_response.dart';

part 'plan_workout_state.dart';

class PlanWorkoutsCubit extends MCubit<PlanWorkoutsInitial> {
  PlanWorkoutsCubit() : super(PlanWorkoutsInitial.initial());

  @override
  String get nameCache => 'plan_workouts';

  @override
  String get filter => state.request?.toString() ?? '';

  Future<void> getPlanWorkouts({bool newData = false, required int id}) async {
    emit(state.copyWith(request: id));

    final checkData = await checkCashed1(
      state: state,
      fromJson: PlanWorkout.fromJson,
      newData: newData,
    );

    if (checkData) return;

    final pair = await _getPlanWorkouts();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<PlanWorkout>?, String?>> _getPlanWorkouts() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.planWorkouts(state.request),
    );

    if (response.statusCode.success) {
      return Pair(PlanWorkouts.fromJson(response.jsonBodyPure).data, null);
    } else {
      return response.getPairError;
    }
  }
}
