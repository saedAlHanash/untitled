import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/util/shared_preferences.dart';
import 'package:fitness_storm/features/auth/data/request/login_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/firebase_analytics_service.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../generated/l10n.dart';
import '../../../../main.dart';
import '../../data/response/login_response.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginInitial> {
  LoginCubit() : super(LoginInitial.initial());

  Future<void> login() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _loginApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      saveFCM();
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
      sl<FirebaseAnalyticService>()
          .login(data: pair.first!, loginMethod: 'email_and_password');
    }
  }

  Future<Pair<LoginData?, String?>> _loginApi() async {
    final response = await APIService().postApi(
      additional: state.userType == UserType.trainer
          ? additionalConstTrainer
          : additionalConstUser,
      url: state.userType == UserType.guest
          ? PostUrl.loginGuest
          : PostUrl.loginUrl,
      body: state.request.toJson(),
    );

    if (response.statusCode.success) {
      final pair = Pair(LoginData.fromJson(response.jsonBody), null);

      await AppProvider.cashLoginData(pair.first, userType: state.userType);

      await AppSharedPreference.removePhoneOrEmail();

      return pair;
    } else {
      return response.getPairError;
    }
  }

  set setPhoneOrEmail(String? phoneOrEmail) =>
      state.request.phoneOrEmail = phoneOrEmail;

  set setPassword(String? password) => state.request.password = password;

  bool get isTrainer => state.userType == UserType.trainer;

  set changeUserType(UserType? userType) {
    emit(state.copyWith(userType: userType));
  }

  String? get validatePhoneOrEmail {
    if (!(state.request.phoneOrEmail ?? '').trim().isEmail) {
      return S().invalidEmail;
    }
    return null;
  }

  String? get validatePassword {
    if (state.request.password.isBlank) {
      return '${S().password} ${S().isRequired}';
    }
    return null;
  }
}
