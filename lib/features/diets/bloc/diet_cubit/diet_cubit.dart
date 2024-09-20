import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../data/response/diet_response.dart';

part 'diet_state.dart';

class DietCubit extends MCubit<DietInitial> {
  DietCubit() : super(DietInitial.initial());

  @override
  String get nameCache => '${AppSharedPreference.getLocal}diet';

  @override
  String get filter => state.filter;

  Future<void> getDiet({bool newData = false, required String dietId}) async {
    emit(state.copyWith(request: dietId));

    await getDataAbstract(
      fromJson: Diet.fromJson,
      state: state,
      getDataApi: _getDiet,
      newData: newData,
    );
  }

  Future<Pair<Diet?, String?>> _getDiet() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.diet,
      path: state.request.toString(),
    );

    if (response.statusCode.success) {
      return Pair(Diet.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  void setDiet(dynamic diet) {
    if (diet is! Diet) return;

    emit(state.copyWith(result: diet));
  }
}
