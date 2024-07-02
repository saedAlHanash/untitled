part of 'change_video_cubit.dart';

class ChangeVideoInitial extends AbstractState<bool> {
  const ChangeVideoInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
  }); //

  factory ChangeVideoInitial.initial() {
    return const ChangeVideoInitial(
      result: false,
      error: '',
      request: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [
    statuses,
    result,
    error,
    if (request != null) request,
   
  ];
  ChangeVideoInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    String? request,
  }) {
    return ChangeVideoInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
