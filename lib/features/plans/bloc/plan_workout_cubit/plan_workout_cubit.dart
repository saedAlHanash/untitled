import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/models/plan_model.dart';
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
  String get filter => state.mRequest.id.toString();

  Future<void> getPlanWorkouts({bool newData = false, required Plan plan}) async {
    emit(state.copyWith(request: plan));

    getDataAbstract(
      fromJson: PlanWorkout.fromJson,
      state: state,
      getDataApi: _getPlanWorkouts,
      newData: newData,
      onSuccess: (data, emitState) {
        final finishIds =
            state.mRequest.days.where((e) => e.completed).map((e) => e.dayNumber);

        for (var e in (data as List<PlanWorkout>)) {
          e.isFinish = finishIds.contains(e.dayNumber);
        }

        emit(
          state.copyWith(
            result: data,
            statuses: emitState,
          ),
        );
      },
    );
  }

  Future<Pair<List<PlanWorkout>?, String?>> _getPlanWorkouts() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.planWorkouts(state.mRequest.id),
    );

    if (response.statusCode.success) {

      final list = PlanWorkouts.fromJson(response.jsonBodyPure).data;

      return Pair(list, null);
    } else {
      return response.getPairError;
    }
  }
}
