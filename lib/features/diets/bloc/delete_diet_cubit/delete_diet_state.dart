part of 'delete_diet_cubit.dart';

class DeleteDietInitial extends AbstractState<bool> {
  const DeleteDietInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
  }); //

  factory DeleteDietInitial.initial() {
    return const DeleteDietInitial(
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
  DeleteDietInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    String? request,
  }) {
    return DeleteDietInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
