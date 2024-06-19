part of 'trainer_cubit.dart';

class TrainerInitial extends AbstractState<TrainerModel> {
  final int id;
  final bool isTrainer;

  const TrainerInitial({
    required super.result,
    super.error,
    required this.id,
    required this.isTrainer,
    super.statuses,
  });

  factory TrainerInitial.initial() {
    return TrainerInitial(
      result: TrainerModel.fromJson({}),
      error: '',
      isTrainer: false,
      id: 0,
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  TrainerInitial copyWith({
    CubitStatuses? statuses,
    TrainerModel? result,
    String? error,
    int? id,
    bool? isTrainer,
  }) {
    return TrainerInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
      isTrainer: isTrainer ?? this.isTrainer,
    );
  }
}
