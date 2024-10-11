import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/models/plan_model.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';

part 'active_plans_state.dart';

class ActivePlansCubit extends MCubit<ActivePlansInitial> {
  ActivePlansCubit() : super(ActivePlansInitial.initial());

  @override
  String get nameCache => '${AppSharedPreference.getLocal}activePlans';

  @override
  String get filter => state.filter;

  Future<void> getActivePlans({bool newData = false}) async {
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
      url: GetUrl.activePlans,
    );

    if (response.statusCode.success) {
      final list = Plans.fromJson(response.jsonBodyPure).data;
      if (list.isNotEmpty) {
        AppSharedPreference.setCurrentPlanId(list.first.id.toString());
      }
      return Pair(list, null);
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
