import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../data/response/welcome_message_response.dart';

part 'welcome_message_state.dart';

class WelcomeMessageCubit extends MCubit<WelcomeMessageInitial> {
  WelcomeMessageCubit() : super(WelcomeMessageInitial.initial());

  @override
  String get nameCache => '${AppSharedPreference.getLocal}welcomeMessage';

  Future<void> getWelcomeMessage() async {

    await getDataAbstract(
      fromJson: WelcomeMessage.fromJson,
      state: state,
      getDataApi: _getWelcomeMessage,
      newData: true,
    );

  }

  Future<Pair<WelcomeMessage?, String?>> _getWelcomeMessage() async {
    final response = await APIService().callApi(type: ApiType.get,url: GetUrl.welcomeMessage);

    if (response.statusCode.success) {
      return Pair(WelcomeMessage.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }


}
