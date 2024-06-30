import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/trainer.dart';

part 'trainers_state.dart';

class TrainersCubit extends MCubit<TrainersInitial> {
  TrainersCubit() : super(TrainersInitial.initial());

  @override
  String get nameCache => 'trainers';

  @override
  String get filter =>   state.request ?? '';

  Future<void> getTrainers({bool newData = false}) async {

    final checkData = await checkCashed1(
        state: state, fromJson: TrainerModel.fromJson, newData: newData);

    if (checkData) return;

    final pair = await _getTrainers();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
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
