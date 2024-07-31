import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/util/firebase_analytics_service.dart';
import 'package:fitness_storm/features/auth/data/response/login_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../generated/l10n.dart';
import '../../data/request/signup_request.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupInitial> {
  SignupCubit() : super(SignupInitial.initial());

  Future<void> signup() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _signupApi();

    if (pair.first == null) {
      emit(state.errorState(error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
     sl<AnalyticService>().signup(request: state.request);
    }
  }

  Future<Pair<bool?, String?>> _signupApi() async {
    final response = await APIService().callApi(type: ApiType.post,
      url: PostUrl.signup,
      body: state.request.toJson(),
    );

    if (response.statusCode.success) {
      await AppProvider.cashLoginData(
        LoginData.fromJson(response.jsonBody),
        userType: UserType.user,
      );

      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }

  set setName(String? name) => state.request.name = name;

  set setPhoneOrEmail(String? phoneOrEmail) => state.request.phoneOrEmail = phoneOrEmail;

  set setPassword(String? password) => state.request.password = password;

  set setRePassword(String? rePassword) => state.request.rePassword = rePassword;

  String? get validateName {
    if (state.request.name == null) {
      return S().nameEmpty;
    }
    return null;
  }

  String? get validatePhoneOrEmail {
    if (!(state.request.phoneOrEmail ?? '').isEmail) {
      return '${S().email}'
          ' ${S().isRequired}';
    }
    return null;
  }

  String? get validatePassword {
    if (state.request.password == null) {
      return '${S().password} ${S().isRequired}';
    }
    return null;
  }

  String? get validateRePassword {
    if (state.request.rePassword != state.request.password) {
      return S().passwordNotMatch;
    }
    return null;
  }
}
