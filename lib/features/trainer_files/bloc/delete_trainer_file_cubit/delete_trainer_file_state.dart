part of 'delete_trainer_file_cubit.dart';

class DeleteTrainerFileInitial extends AbstractState<bool> {
  const DeleteTrainerFileInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
  }); //

  factory DeleteTrainerFileInitial.initial() {
    return const DeleteTrainerFileInitial(
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
  DeleteTrainerFileInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    String? request,
  }) {
    return DeleteTrainerFileInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
