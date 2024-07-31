part of 'create_trainer_file_cubit.dart';

class CreateTrainerFileInitial extends AbstractState<TrainerFile> {
  const CreateTrainerFileInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
  }); //

  CreateTrainerFileRequest get mRequest => request;

  factory CreateTrainerFileInitial.initial() {
    return CreateTrainerFileInitial(
      result: TrainerFile.fromJson({}),
      error: '',
      request: CreateTrainerFileRequest.fromJson({}),
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

  CreateTrainerFileInitial copyWith({
    CubitStatuses? statuses,
    TrainerFile? result,
    String? error,
    CreateTrainerFileRequest? request,
  }) {
    return CreateTrainerFileInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
