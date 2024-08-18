import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../api_manager/api_service.dart';
import '../api_manager/enum_manager.dart';


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

