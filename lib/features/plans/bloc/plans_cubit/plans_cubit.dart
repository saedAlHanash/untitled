import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/models/plan_model.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';

part 'plans_state.dart';

class PlansCubit extends MCubit<PlansInitial> {
  PlansCubit() : super(PlansInitial.initial());

  @override
  String get nameCache => '${AppSharedPreference.getLocal}plans';

  @override
  String get filter => state.filter;

  @override
  int get timeInterval => 300;

  Future<void> getPlans({bool newData = false}) async {
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
      url: GetUrl.plans,
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
