import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/bundles_request.dart';
import '../../data/response/bundles_response.dart';

part 'bundles_state.dart';

class BundlesCubit extends Cubit<BundlesInitial> {
  BundlesCubit() : super(BundlesInitial.initial());

  Future<void> getBundles({BundlesRequest? request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));
    final pair = await _bookedAppointmentsApi();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<Bundle>?, String?>> _bookedAppointmentsApi() async {
    final response = await APIService().getApi(
      url: GetUrl.bundles,
      query: state.request.toJson(),
    );

    if (response.statusCode.success) {
      return Pair(BundlesResponse.fromJson(response.jsonBodyPure).data, null);
    } else {
      return response.getPairError;
    }
  }
}
