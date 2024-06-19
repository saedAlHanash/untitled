import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/welcome_message_response.dart';

part 'welcome_messages_state.dart';

class WelcomeMessagesCubit extends MCubit<WelcomeMessagesInitial> {
  WelcomeMessagesCubit() : super(WelcomeMessagesInitial.initial());

  @override
  String get nameCache => 'welcomeMessages';

  Future<void> getWelcomeMessages() async {
    if (await checkCashed()) return;

    final pair = await _getWelcomeMessages();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<WelcomeMessage>?, String?>> _getWelcomeMessages() async {
    final response = await APIService().callApi(type: ApiType.get,url: GetUrl.welcomeMessages);

    if (response.statusCode.success) {
      return Pair(
          WelcomeMessageResponse.fromJson(response.jsonBodyData).data, null);
    } else {
      return response.getPairError;
    }
  }

  Future<bool> checkCashed() async {
    final cacheType = await needGetData();

    emit(
      state.copyWith(
        statuses: cacheType.getState,
        result: (await getListCached())
            .map((e) => WelcomeMessage.fromJson(e))
            .toList(),
      ),
    );

    if (cacheType == NeedUpdateEnum.no) return true;
    return false;
  }
}
