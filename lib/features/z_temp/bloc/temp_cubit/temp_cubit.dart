import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/temp_response.dart';

part 'temp_state.dart';

class TempCubit extends MCubit<TempInitial> {
  TempCubit() : super(TempInitial.initial());

  @override
  String get nameCache => 'temp';

  @override
  String get filter => state.filter;

  Future<void> getTemp({bool newData = false, required String tempId}) async {

    emit(state.copyWith(request: tempId));

    await getDataAbstract(
      fromJson: Temp.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );

  }

  Future<Pair<Temp?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.temp,
      query: {'Id': state.request},
    );

    if (response.statusCode.success) {
      return Pair(Temp.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  void setTemp(dynamic temp) {
    if(temp is! Temp)return;

    emit(state.copyWith(result: temp));
  }

}
