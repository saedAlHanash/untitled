import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../data/response/welcome_message_response.dart';

part 'welcome_messages_state.dart';

class WelcomeMessagesCubit extends MCubit<WelcomeMessagesInitial> {
  WelcomeMessagesCubit() : super(WelcomeMessagesInitial.initial());

  @override
  String get nameCache => '${AppSharedPreference.getLocal}welcomeMessages';

  Future<void> getWelcomeMessages() async {

    getDataAbstract(
      fromJson: WelcomeMessage.fromJson,
      state: state,
      getDataApi: _getDataApi,
    );
  }

  Future<Pair<List<WelcomeMessage>?, String?>> _getDataApi() async {
    final response =
        await APIService().callApi(type: ApiType.get, url: GetUrl.welcomeMessages);

    if (response.statusCode.success) {
      return Pair(WelcomeMessageResponse.fromJson(response.jsonBodyData).data, null);
    } else {
      return response.getPairError;
    }
  }
}
