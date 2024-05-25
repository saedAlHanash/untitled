import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/features/notifications/data/response/notifications_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';


part 'notifications_state.dart';

class NotificationsCubit extends MCubit<NotificationsInitial> {
  NotificationsCubit() : super(NotificationsInitial.initial());

  @override
  String get nameCache => 'notifications';

  Future<void> getNotifications({bool newData = false}) async {
    if (await checkCashed(newData:newData)) return;

    final pair = await _getNotifications();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(
          statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<NotificationModel>?, String?>> _getNotifications() async {
    final response = await APIService().getApi(url: GetUrl.notification);

    if (response.statusCode.success) {
      return Pair(NotificationsResponse.fromJson(response.jsonBodyPure).data, null);
    } else {
      return response.getPairError;
    }
  }

  Future<bool> checkCashed({bool newData = false}) async {
    final cacheType =newData?NeedUpdateEnum.withLoading: await needGetData();

    emit(
      state.copyWith(
        statuses: cacheType.getState,
        result:
            (await getListCached()).map((e) => NotificationModel.fromJson(e)).toList(),
      ),
    );

    if (cacheType == NeedUpdateEnum.no) return true;
    return false;
  }
}
