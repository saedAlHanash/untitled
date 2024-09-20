import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/util/shared_preferences.dart';
import 'package:fitness_storm/features/notifications/data/response/notifications_response.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';

part 'notifications_state.dart';

class NotificationsCubit extends MCubit<NotificationsInitial> {
  NotificationsCubit() : super(NotificationsInitial.initial());

  @override
  String get nameCache => '${AppSharedPreference.getLocal}notifications';

  Future<void> getNotifications({bool newData = false}) async {
    getDataAbstract(
      fromJson: NotificationsResponse.fromJson,
      state: state,
      getDataApi: _getDataApi,
    );
  }

  Future<Pair<NotificationsResponse?, String?>> _getDataApi() async {
    final response =
        await APIService().callApi(type: ApiType.get, url: GetUrl.notification);

    if (response.statusCode.success) {
      return Pair(NotificationsResponse.fromJson(response.jsonBodyPure), null);
    } else {
      return response.getPairError;
    }
  }

  Future<void> setCount() async {
    await AppSharedPreference.setNotificationsRead(state.result.numberOfResults);
    emit(state.copyWith(numOfRead: state.result.numberOfResults));
  }
}
