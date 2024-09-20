import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../data/response/plan_workout_response.dart';

part 'plan_workout_state.dart';

class PlanWorkoutsCubit extends MCubit<PlanWorkoutsInitial> {
  PlanWorkoutsCubit() : super(PlanWorkoutsInitial.initial());

  @override
  String get nameCache => '${AppSharedPreference.getLocal}plan_workouts';

  @override
  String get filter => state.filter;

  Future<void> getPlanWorkouts({bool newData = false, required int id}) async {
    emit(state.copyWith(request: id));

    getDataAbstract(
      fromJson: PlanWorkout.fromJson,
      state: state,
      getDataApi: _getPlanWorkouts,
      newData: newData,
    );
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
