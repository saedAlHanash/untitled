import 'package:bloc/bloc.dart';
import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/util/abstraction.dart';
import 'package:fitness_storm/features/profile/data/response/profile_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/firebase_analytics_service.dart';
import '../../../../core/util/pair_class.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileInitial> {
  ProfileCubit() : super(ProfileInitial.initial());

  Future<void> getProfile({bool? newData}) async {
    if (state.result.id != 0 && newData == null) {
      return;
    }
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getProfileApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await AppProvider.cashProfile(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
      sl<FirebaseAnalyticService>().initUser(user: pair.first!);
    }
  }

  Future<Pair<Profile?, String?>> _getProfileApi() async {
    final response = await APIService().callApi(type: ApiType.get,
      url: GetUrl.profile,
    );

    if (response.statusCode.success) {
      return Pair(Profile.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }
}
