import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/features/payments/data/response/wallet_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletInitial> {
  WalletCubit() : super(WalletInitial.initial());

  Future<void> getWallet() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _bookedAppointmentsApi();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<Wallet>?, String?>> _bookedAppointmentsApi() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.wallet,
    );

    if (response.statusCode.success) {
      return Pair(WalletResponse.fromJson(response.jsonBodyPure).data, null);
    } else {
      return response.getPairError;
    }
  }
}
