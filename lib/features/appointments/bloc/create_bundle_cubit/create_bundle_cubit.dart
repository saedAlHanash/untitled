import 'package:collection/collection.dart';
import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/features/appointments/data/response/available_times_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../trainer/data/response/trainer.dart';
import '../../data/request/create_bundle_request.dart';
import '../../data/response/bundles_response.dart';

part 'create_bundle_state.dart';

class CreateBundleCubit extends Cubit<CreateBundleInitial> {
  CreateBundleCubit() : super(CreateBundleInitial.initial());

  Future<void> createBundle() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _createBundle();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<String?, String?>> _createBundle() async {
    final response = await APIService().postApi(
      url: PostUrl.createBundle,
      body: state.request.toJson(),
    );

    if (response.statusCode.success) {
      return Pair(response.jsonBodyPure['url'] ?? '', null);
    } else {
      return response.getPairError;
    }
  }

  void setData({required Bundle bundle}) {
    state.request.bundleId = bundle.id;
    emit(state.copyWith(bundle: bundle));
  }

  void selectTime(AvailableTime time) {
    if (isFull) {
      return;
    }
    for (var e in state.request.timeIds) {
      if (e.id == time.id) return;
    }

    state.request.timeIds.add(time);

    emit(state.copyWith(notify: state.notify + 1));
  }

  void removeTime(AvailableTime time) {
    state.request.timeIds.removeWhere((e) => e.id == time.id);

    emit(state.copyWith(notify: state.notify + 1));
  }

  bool get isFull => state.bundle.sessions == state.request.timeIds.length;
}
