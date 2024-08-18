import 'package:chat_web_app/util/extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../../api_manager/api_service.dart';
import '../../api_manager/enum_manager.dart';
import '../../app_widget.dart';
import '../../services/caching_service/caching_service.dart';

abstract class AbstractState<T> extends Equatable {
  final CubitStatuses statuses;
  final String error;
  final T result;
  final dynamic request;

  const AbstractState({
    this.statuses = CubitStatuses.init,
    this.error = '',
    this.request,
    required this.result,
  });
}

abstract class AbstractState1<T> extends Equatable {
  final CubitStatuses statuses;
  final StateControl control;
  final T result;

  const AbstractState1({
    required this.control,
    this.statuses = CubitStatuses.init,
    required this.result,
  });
}

class StateControl {
  String? error;
  dynamic request;

  StateControl();
}

abstract class MCubit<AbstractState> extends Cubit<AbstractState> {
  MCubit(super.initialState);

  String get nameCache => '';

  String get filter => '';

  Future<NeedUpdateEnum> needGetData() async {
    if (nameCache.isEmpty) return NeedUpdateEnum.withLoading;
    return await CachingService.needGetData(nameCache, filter: filter);
  }

  Future<void> storeData(dynamic data) async {
    await CachingService.sortData(data: data, name: nameCache, filter: filter);
  }

  Future<Iterable<dynamic>> getListCached() async {
    final data = await CachingService.getList(nameCache, filter: filter);
    return data;
  }

  Future<dynamic> getDataCached() async {
    return (await CachingService.getData(nameCache, filter: filter)) ??
        <String, dynamic>{};
  }

  Future<bool> checkCashed1<T>({
    required dynamic state,
    required T Function(Map<String, dynamic>) fromJson,
    bool newData = false,
  }) async {
    if (newData) {
      emit(state.copyWith(statuses: CubitStatuses.loading));
      return false;
    }

    try {
      final cacheType = await needGetData();
      final emitState = cacheType.getState;
      dynamic data;

      if (state.result is List) {
        data = (await getListCached()).map((e) => fromJson(e)).toList();
      } else {
        data = fromJson(await getDataCached());
      }

      emit(
        state.copyWith(
          statuses: emitState,
          result: data,
        ),
      );

      if (cacheType == NeedUpdateEnum.no) return true;

      return false;
    } catch (e) {
      loggerObject.e(e);
      return false;
    }
  }

  Future<void> getDataAbstract({
    required Function(Map<String, dynamic>) fromJson,
    required dynamic state,
    required Future getDataApi,
    bool newData = false,
    void Function()? onError,
    void Function()? onSuccess,
  }) async {
    final checkData = await checkCashed1(
      state: state,
      fromJson: fromJson,
      newData: newData,
    );

    if (checkData) return;

    final pair = await getDataApi;

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
      onError?.call();
    } else {
      await storeData(pair.first);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
      onSuccess?.call();
    }
  }
}

showErrorFromApi(AbstractState state) {
  if (ctx == null) return;
  ScaffoldMessenger.of(ctx!).showSnackBar(
    SnackBar(
      content: Text(
        state.error,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.redAccent,
    ),
  );
}
