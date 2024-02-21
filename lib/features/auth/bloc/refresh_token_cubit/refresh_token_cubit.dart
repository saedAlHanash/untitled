import 'package:equatable/equatable.dart';
import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../data/response/login_response.dart';

part 'refresh_token_state.dart';

class RefreshTokenCubit extends Cubit<RefreshTokenInitial> {
  RefreshTokenCubit() : super(RefreshTokenInitial.initial());

  Future<void> refreshToken() async {
    // emit(state.copyWith(statuses: CubitStatuses.loading));
    // final pair = await refreshTokenApi();
    //
    // if (pair.first == null) {
    //   emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    //   showErrorFromApi(state);
    // } else {
    //   emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    // }
  }

  static Future<Pair<bool?, String?>> refreshTokenApi() async {
    final response = await APIService().postApi(url: PostUrl.refreshToken, header: {
      'Content-Type': 'application/json',
      'Accept': 'Application/json',
      'Authorization': 'Bearer ${AppProvider.refreshToken}',
    });

    if (response.statusCode.success) {
      final token = (response.jsonBody['access_token'] ?? '').toString();
      AppProvider.cashLoginData(
        AppSharedPreference.loginDate.copyWith(accessToken: token),
        isTrainer: AppProvider.isTrainer,
      );
      return Pair(true, null);
    } else {
      return Pair(true, 'error');
    }
  }
}
