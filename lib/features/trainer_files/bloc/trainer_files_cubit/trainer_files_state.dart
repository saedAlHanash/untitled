part of 'trainer_files_cubit.dart';

class TrainerFilesInitial extends AbstractState<List<TrainerFile>> {
  const TrainerFilesInitial({
    required super.result,
    super.error,
    super.request,
    super.statuses,
  }); //

  factory TrainerFilesInitial.initial() {
    return const TrainerFilesInitial(
      result: [],
      error: '',
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

  TrainerFilesInitial copyWith({
    CubitStatuses? statuses,
    List<TrainerFile>? result,
    String? error,
    dynamic request,
  }) {
    return TrainerFilesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
