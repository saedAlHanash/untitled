import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../trainer/data/response/trainer.dart';
import '../../data/request/trainers_filter.dart';

part 'search_state.dart';

class SearchCubit extends MCubit<SearchInitial> {
  SearchCubit() : super(SearchInitial.initial());

  @override
  String get nameCache => 'SearchCubit';

  @override
  String get filter => state.filter;

  Future<void> getSearch({bool newData = false, TrainerFilter? request}) async {
    emit(state.copyWith(request: request));

    await getDataAbstract(
      fromJson: TrainerModel.fromJson,
      state: state,
      getDataApi: _getSearch,
      newData: newData,
    );
  }

  set setTrainingType(TrainingTypeEnum e) => state.mRequest.trainingType = e;

  set setTrainingLeve(TrainingLevelEnum e) => state.mRequest.fitnessLevel = e;

  Future<Pair<List<TrainerModel>?, String?>> _getSearch() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.search,
      query: state.mRequest.toJson(),
    );

    if (response.statusCode.success) {
      final json = response.jsonBodyPure;
      return Pair(
          json["data"] == null
              ? []
              : List<TrainerModel>.from(
                  json["data"]!.map((x) => TrainerModel.fromJson(x))),
          null);
    } else {
      return response.getPairError;
    }
  }
}
