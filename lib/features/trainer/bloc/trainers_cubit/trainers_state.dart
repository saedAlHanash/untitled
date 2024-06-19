part of 'trainers_cubit.dart';

class TrainersInitial extends AbstractState<List<TrainerModel>> {
  const TrainersInitial({
    required super.result,
    super.error,
    super.request,
    super.statuses,
  }); //

  factory TrainersInitial.initial() {
    return const TrainersInitial(
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

  TrainersInitial copyWith({
    CubitStatuses? statuses,
    List<TrainerModel>? result,
    String? error,
    dynamic request,
  }) {
    return TrainersInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
