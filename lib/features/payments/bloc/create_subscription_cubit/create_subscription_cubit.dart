import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../coupon/data/request/pay_request.dart';

part 'create_subscription_state.dart';

class CreateSubscriptionCubit extends Cubit<CreateSubscriptionInitial> {
  CreateSubscriptionCubit() : super(CreateSubscriptionInitial.initial());

  Future<void> createSubscription({required CreateSubscriptionRequest request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));
    final pair = await _createSubscriptionApi();

    if (pair.first == null) {
      emit(state.copyWith(error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<String?, String?>> _createSubscriptionApi() async {
    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.createSubscription,
      body: state.mRequest.toJson(),
    );

    if (response.statusCode.success) {
      return Pair(response.jsonBodyPure['url'] ?? '', null);
    } else {
      return response.getPairError;
    }
  }
}
