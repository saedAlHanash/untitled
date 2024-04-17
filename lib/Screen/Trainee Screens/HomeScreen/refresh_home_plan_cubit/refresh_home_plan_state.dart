part of 'refresh_home_plan_cubit.dart';

class RefreshHomePlanState {
  final int count;

  const RefreshHomePlanState({
    required this.count,
  });

  factory RefreshHomePlanState.initial() {
    return const RefreshHomePlanState(
      count: 0,
    );
  }

  RefreshHomePlanState copyWith({
    int? count,
  }) {
    return RefreshHomePlanState(
      count: count ?? this.count,
    );
  }
}
