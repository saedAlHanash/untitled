import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/features/profile/data/response/profile_response.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/firebase_analytics_service.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';

part 'profile_state.dart';

class ProfileCubit extends MCubit<ProfileInitial> {
  ProfileCubit() : super(ProfileInitial.initial());

  @override
  String get nameCache => '${AppSharedPreference.getLocal}Profile';

  Future<void> getProfile({bool? newData}) async {

    if(AppProvider.token.isEmpty)return;

    await getDataAbstract(
      fromJson: Profile.fromJson,
      state: state,
      getDataApi: _getDataApi,
      newData: newData ?? false,
    );
  }

  Future<Pair<Profile?, String?>> _getDataApi() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.profile,
    );

    if (response.statusCode.success) {
      final model = Profile.fromJson(response.jsonBody);
       AppProvider.cashProfile(model);
      sl<AnalyticService>().initUser(user: model);
      return Pair(model, null);
    } else {
      return response.getPairError;
    }
  }
}
