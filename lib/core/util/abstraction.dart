import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

import '../../services/caching_service/caching_service.dart';
import '../api_manager/api_service.dart';
import '../api_manager/request_models/command.dart';
import '../error/error_manager.dart';
import '../strings/enum_manager.dart';

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

  bool get loading => statuses == CubitStatuses.loading;
}

abstract class MCubit<AbstractState> extends Cubit<AbstractState> {
  MCubit(super.initialState);

  String get nameCache => '';

  String get filter => '';

  int? get timeInterval => null;

  Future<NeedUpdateEnum> needGetData() async {
    if (nameCache.isEmpty) return NeedUpdateEnum.withLoading;
    return await CachingService.needGetData(
      nameCache,
      filter: filter,
      timeInterval: timeInterval,
    );
  }

  Future<void> storeData(dynamic data) async {
    await CachingService.sortData(data: data, name: nameCache, filter: filter);
  }

  Future<void> sortDataChat(dynamic data) async {
    await CachingService.sortDataChat(data: data, name: nameCache, filter: filter);
  }

  Future<Iterable<dynamic>?> addOrUpdateDate(
    List<dynamic> data, {
    String? name,
    String? cachedFilter,
  }) async {
    return await CachingService.addOrUpdate(
      data: data,
      name: name ?? nameCache,
      filter: filter,
    );
  }

  Future<Iterable<dynamic>?> deleteDate(List<String> data) async {
    return await CachingService.delete(data: data, name: nameCache, filter: filter);
  }

  Future<Iterable<dynamic>> getListCached() async {
    final data = await CachingService.getList(nameCache, filter: filter);
    return data;
  }

  Future<Iterable<Message>> getListCachedChat() async {
    final data = await CachingService.getListChat(nameCache, filter: filter);

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
    void Function(dynamic data, CubitStatuses emitState)? onSuccess,
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

      if (onSuccess != null) {
        onSuccess.call(data, emitState);
      } else {
        emit(
          state.copyWith(
            result: data,
            statuses: emitState,
          ),
        );
      }

      if (cacheType == NeedUpdateEnum.no) return true;

      return false;
    } catch (e) {
      loggerObject.e('checkCashed1$nameCache: $e');

      return false;
    }
  }

  Future<void> getDataAbstract<T>({
    required T Function(Map<String, dynamic>) fromJson,
    required dynamic state,
    required Function getDataApi,
    bool newData = false,
    void Function()? onError,
    void Function(dynamic data, CubitStatuses emitState)? onSuccess,
  }) async {
    final checkData = await checkCashed1(
      state: state,
      fromJson: fromJson,
      newData: newData,
      onSuccess: onSuccess,
    );

    if (checkData) {
      loggerObject.f('$nameCache stopped on cache');
      return;
    }

    final pair = await getDataApi.call();

    if (pair.first == null) {
      if (isClosed) return;
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
      onError?.call();
    } else {
      await storeData(pair.first);

      if (onSuccess != null) {
        onSuccess.call(pair.first, CubitStatuses.done);
      } else {
        if (isClosed) return;
        emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
      }
    }
  }
}
