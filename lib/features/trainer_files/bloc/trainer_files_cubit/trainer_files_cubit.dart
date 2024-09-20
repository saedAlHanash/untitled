import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../data/response/trainer_file_response.dart';

part 'trainer_files_state.dart';

class TrainerFilesCubit extends MCubit<TrainerFilesInitial> {
  TrainerFilesCubit() : super(TrainerFilesInitial.initial());

  @override
  String get nameCache => '${AppSharedPreference.getLocal}trainer_files';

  Future<void> getTrainerFiles({bool newData = false}) async {
    getDataAbstract(
      fromJson: TrainerFile.fromJson,
      state: state,
      getDataApi: _getDataApi,
    );
  }

  Future<Pair<List<TrainerFile>?, String?>> _getDataApi() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: PostUrl.trainerFiles,
      path: AppSharedPreference.getMyId.toString(),
    );

    if (response.statusCode.success) {
      return Pair(TrainerFiles.fromJson(response.jsonBodyPure).data, null);
    } else {
      return response.getPairError;
    }
  }
}
