import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/models/plan_model.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';

part 'trainer_my_plans_state.dart';

class TrainerMyPlansCubit extends MCubit<TrainerMyPlansInitial> {
  TrainerMyPlansCubit() : super(TrainerMyPlansInitial.initial());

  @override
  String get nameCache => '${AppSharedPreference.getLocal}trainer_my_plans';

  @override
  String get filter => state.filter;

  @override
  int get timeInterval => 300;

  Future<void> getTrainerMyPlans({bool newData = false}) async {
    await getDataAbstract(
      fromJson: Plan.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<List<Plan>?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.trainerMyPlans,
    );

    if (response.statusCode.success) {
      return Pair(Plans.fromJson(response.jsonBodyPure).data, null);
    } else {
      return response.getPairError;
    }
  }

  Future<void> addPlan(Plan item) async {
    final listJson = await addOrUpdateDate([item]);
    if (listJson == null) return;
    final list = listJson.map((e) => Plan.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }

  Future<void> deletePlanFromCache(String id) async {
    final listJson = await deleteDate([id]);
    if (listJson == null) return;
    final list = listJson.map((e) => Plan.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }
}
