import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/api_manager/request_models/command.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/diet_response.dart';

part 'diets_state.dart';

class DietsCubit extends MCubit<DietsInitial> {
  DietsCubit() : super(DietsInitial.initial());

  @override
  String get nameCache => 'diets';

  @override
  String get filter =>  state.request?.toString() ?? '';

  Future<void> getDiets({bool newData = false}) async {
    await getDataAbstract(
      fromJson: Diet.fromJson,
      state: state,
      getDataApi: _getDiets,
      newData: newData,
    );
  }

  Future<Pair<List<Diet>?, String?>> _getDiets() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.diets,
    );

    if (response.statusCode.success) {
      return Pair(Diets.fromJson(response.jsonBodyPure).data, null);
    } else {
      return response.getPairError;
    }
  }

  Future<void> addDiet(Diet item) async {
    final listJson = await addOrUpdateDate([item]);
    if (listJson == null) return;
    final list = listJson.map((e) => Diet.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }

  Future<void> deleteDietFromCache(String id) async {
    final listJson = await deleteDate([id]);
    if (listJson == null) return;
    final list = listJson.map((e) => Diet.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }
}
