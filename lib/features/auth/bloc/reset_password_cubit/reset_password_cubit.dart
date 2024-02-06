import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../generated/l10n.dart';
import '../../data/request/reset_password_request.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordInitial> {
  ResetPasswordCubit() : super(ResetPasswordInitial.initial());

  Future<void> resetPassword() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _checkCode();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      AppSharedPreference.cashRestPassEmail('');
      await _resetPassword();
    }
  }

  Future<void> _resetPassword() async {
    final pair = await _resetPass();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      AppSharedPreference.cashRestPassEmail('');
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _checkCode() async {
    final response = await APIService().postApi(
      url: PostUrl.resetPasswordCheckCode,
      body: state.request.toJson(),
    );
    if (response.statusCode == 200) {
      final pair = Pair(true, null);
      return pair;
    } else {
      return response.getPairError;
    }
  }

  Future<Pair<bool?, String?>> _resetPass() async {
    final response = await APIService().postApi(
      url: PostUrl.resetPassword,
      body: state.request.toJson(),
    );
    if (response.statusCode == 200) {
      final pair = Pair(true, null);
      return pair;
    } else {
      return response.getPairError;
    }
  }

  set setCode(String? code) => state.request.code = code;

  set setPassword(String? password) => state.request.password = password;

  String? get validateCode {
    if (state.request.code.isBlank) {
      return S().confirmCode;
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
