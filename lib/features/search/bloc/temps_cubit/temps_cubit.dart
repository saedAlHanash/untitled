import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../data/response/temp_response.dart';

part 'temps_state.dart';

class TempsCubit extends MCubit<TempsInitial> {
  TempsCubit() : super(TempsInitial.initial());

  @override
  String get nameCache => '${AppSharedPreference.getLocal}temps';

  @override
  String get filter => state.filter;

  Future<void> getTemps({bool newData = false}) async {
    await getDataAbstract(
      fromJson: Temp.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<List<Temp>?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.temps,
    );

    if (response.statusCode.success) {
      return Pair(Temps.fromJson(response.jsonBody).items, null);
    } else {
      return response.getPairError;
    }
  }

  Future<void> addTemp(Temp item) async {
    final listJson = await addOrUpdateDate([item]);
    if (listJson == null) return;
    final list = listJson.map((e) => Temp.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }

  Future<void> deleteTempFromCache(String id) async {
    final listJson = await deleteDate([id]);
    if (listJson == null) return;
    final list = listJson.map((e) => Temp.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }
}
