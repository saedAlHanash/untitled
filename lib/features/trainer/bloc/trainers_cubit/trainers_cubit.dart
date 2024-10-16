import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/trainer.dart';

part 'trainers_state.dart';

class TrainersCubit extends MCubit<TrainersInitial> {
  TrainersCubit() : super(TrainersInitial.initial());

  @override
  String get nameCache => 'trainers';

  @override
  String get filter => state.filter;

  @override
  int get timeInterval => 300;

  Future<void> getTrainers({bool newData = false}) async {
    await getDataAbstract(
      fromJson: TrainerModel.fromJson,
      state: state,
      getDataApi: _getTrainers,
      newData: newData,
    );
  }

  Future<Pair<List<TrainerModel>?, String?>> _getTrainers() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: PostUrl.trainers,
    );

    if (response.statusCode.success) {
      return Pair(Trainers.fromJson(response.jsonBodyPure).data, null);
    } else {
      return response.getPairError;
    }
  }
}
