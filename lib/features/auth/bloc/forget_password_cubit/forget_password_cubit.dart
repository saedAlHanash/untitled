import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/util/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../generated/l10n.dart';
import '../../data/request/forget_pass_request.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordInitial> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial.initial());

  Future<void> forgetPassword() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _forgetPasswordApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _forgetPasswordApi() async {
    final response = await APIService().postApi(
        url: PostUrl.forgetPassword, body: {'email': state.request.phoneOrEmail});

    if (response.statusCode.success) {
      await AppSharedPreference.cashRestPassEmail(state.request.phoneOrEmail);
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }

  set setPhoneOrEmail(String? phoneOrEmail) => state.request.phoneOrEmail = phoneOrEmail;

  String? get validatePhoneOrEmail {
    if (!(state.request.phoneOrEmail ?? '').isEmail) {
      return S().invalidEmail;
    }
    return null;
  }
}
