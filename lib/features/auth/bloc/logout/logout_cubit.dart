import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/util/firebase_analytics_service.dart';
import '../../../../core/util/pair_class.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutInitial> {
  LogoutCubit() : super(LogoutInitial.initial());

  Future<void> logout() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    sl<FirebaseAnalyticService>().logout();

    final pair = await _logoutApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _logoutApi() async {
    final response = await APIService().callApi(type: ApiType.post,
      url: PostUrl.logout,
    );

    await AppProvider.logout();

    if (response.statusCode.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }
}
