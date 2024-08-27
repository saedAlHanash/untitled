import 'dart:async';

import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/create_diet_request.dart';
import '../../data/response/diet_response.dart';

part 'create_diet_state.dart';

class CreateDietCubit extends Cubit<CreateDietInitial> {
  CreateDietCubit() : super(CreateDietInitial.initial());

  Future<void> createDiet() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _createDietApi();

    if (pair.first == null) {
      emit(state.copyWith(error: pair.second, statuses: CubitStatuses.error));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<Diet?, String?>> _createDietApi() async {
    late final Response response;
    if (!state.mRequest.id.isBlank) {
      response = await APIService().callApi(
        type: ApiType.put,
        url: PutUrl.updateDiet,
        query: {'id': state.mRequest.id},
        body: state.mRequest.toJson(),
      );
    } else {
      response = await APIService().callApi(
        type: ApiType.post,
        url: PostUrl.createDiet,
        body: state.mRequest.toJson(),
      );
    }

    if (response.statusCode.success) {
      return Pair(Diet.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  void setUpdateData(Diet? shipment) {
    if (shipment == null) return;
    emit(state.copyWith(request: CreateDietRequest.fromDiet(shipment)));
  }

  bool get  updateMode =>!state.mRequest.id.isBlank;
}
