import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/util/shared_preferences.dart';
import 'package:fitness_storm/features/auth/data/request/login_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/firebase_analytics_service.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../firebase_options.dart';
import '../../data/response/login_response.dart';

part 'login_social_state.dart';

class LoginSocialCubit extends Cubit<LoginSocialInitial> {
  LoginSocialCubit() : super(LoginSocialInitial.initial());

  Future<void> loginGoogle() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final fireAuthUser = await _googleSignIn();

    if (fireAuthUser == null) return;

    final pair = await _loginSocialApi(user: fireAuthUser);

    await _googleSignOut();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
      sl<FirebaseAnalyticService>().login(data: pair.first!,loginMethod: 'google');
    }
  }

  Future<void> _googleSignOut() async {
    try {
      await state.googleSignIn.disconnect();
      await state.googleSignIn.signOut();
      //loggerObject.w('GoogleSignIn signOut');
    } catch (e) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: e.toString()));
      showErrorFromApi(state);
      loggerObject.e(e);
    }
  }

  Future<UserCredential?> _googleSignIn() async {
    try {
      final googleAccount = await state.googleSignIn.signIn();

      final googleAuthentication = await googleAccount!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication.accessToken,
        idToken: googleAuthentication.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      loggerObject.e(e);
      emit(state.copyWith(statuses: CubitStatuses.error, error: e.toString()));
      showErrorFromApi(state);
      return null;
    }
  }

  Future<Pair<LoginData?, String?>> _loginSocialApi(
      {required UserCredential user}) async {
    final response = await APIService().postApi(
      url: PostUrl.loginSocial,
      body: {
        "email": user.user?.email,
        "provider_id": user.user?.uid,
        "name": user.user?.displayName,
      },
    );

    if (response.statusCode.success) {
      final pair = Pair(LoginData.fromJson(response.jsonBody), null);

      await AppProvider.cashLoginData(pair.first, userType: UserType.user);
      AppSharedPreference.removePhoneOrEmail();

      return pair;
    } else {
      return response.getPairError;
    }
  }
}
