import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/trainer_file_response.dart';

part 'trainer_files_state.dart';

class TrainerFilesCubit extends MCubit<TrainerFilesInitial> {
  TrainerFilesCubit() : super(TrainerFilesInitial.initial());

  @override
  String get nameCache => 'trainer_files';

  @override
  String get filter => state.request ?? '';

  Future<void> getTrainerFiles({bool newData = false}) async {
    final checkData = await checkCashed1(
        state: state, fromJson: TrainerFile.fromJson, newData: newData);

    if (checkData) return;

    final pair = await _getTrainerFiles();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<TrainerFile>?, String?>> _getTrainerFiles() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: PostUrl.trainerFiles,
      path: AppProvider.myId.toString(),
    );

    if (response.statusCode.success) {
      return Pair(TrainerFiles.fromJson(response.jsonBodyPure).data, null);
    } else {
      return response.getPairError;
    }
  }
}
