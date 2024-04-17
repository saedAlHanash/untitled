part of 'remove_time_cubit.dart';

class RemoveTimeInitial extends AbstractCubit<bool> {
  final int id;
  // final bool removeTimeParam;

  const RemoveTimeInitial({
    required super.result,
    super.error,
    required this.id,
    // required this.removeTimeParam,
    super.statuses,
  });

  factory RemoveTimeInitial.initial() {
    return const RemoveTimeInitial(
      result: false,
      error: '',
      // removeTimeParam: false,
      id: 0,
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  RemoveTimeInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    int? id,
    // bool? removeTimeParam,
  }) {
    return RemoveTimeInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
      // removeTimeParam: removeTimeParam ?? this.removeTimeParam,
    );
  }
}
