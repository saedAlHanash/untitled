part of 'apply_cubit.dart';

class ApplyInitial extends AbstractCubit<bool> {
  final ApplyRequest request;
  final int tempParam;

  const ApplyInitial({
    required super.result,
    super.error,
    required this.request,
    required this.tempParam,
    super.statuses,
  });

  factory ApplyInitial.initial() {
    return ApplyInitial(
      result: false,
      error: '',
      tempParam: 0,
      request: ApplyRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error,tempParam];

  ApplyInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    ApplyRequest? request,
    int? tempParam,
  }) {
    return ApplyInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      tempParam: tempParam ?? this.tempParam,
    );
  }
}
