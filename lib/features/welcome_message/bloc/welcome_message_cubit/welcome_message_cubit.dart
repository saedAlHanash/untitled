import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/welcome_message_response.dart';

part 'welcome_message_state.dart';

class WelcomeMessageCubit extends MCubit<WelcomeMessageInitial> {
  WelcomeMessageCubit() : super(WelcomeMessageInitial.initial());

  @override
  String get nameCache => 'welcomeMessage';

  Future<void> getWelcomeMessage() async {
    if (await checkCashed()) return;

    final pair = await _getWelcomeMessage();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<WelcomeMessage?, String?>> _getWelcomeMessage() async {
    final response = await APIService().callApi(type: ApiType.get,url: GetUrl.welcomeMessage);

    if (response.statusCode.success) {
      return Pair(WelcomeMessage.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  Future<bool> checkCashed() async {
    final cacheType = await needGetData();

    emit(
      state.copyWith(
        statuses: cacheType.getState,
        result: WelcomeMessage.fromJson(await getDataCached()),
      ),
    );

    if (cacheType == NeedUpdateEnum.no) return true;
    return false;
  }
}
