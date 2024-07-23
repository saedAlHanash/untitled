part of 'add_favorite_cubit.dart';

class AddFavoriteInitial extends AbstractState<bool> {
  final bool isFav;
  final Plan plan;

  const AddFavoriteInitial({
    required super.result,
    super.statuses,
    super.error,
    required this.isFav,
    required this.plan,
  });

  factory AddFavoriteInitial.initial() {
    return AddFavoriteInitial(
      result: false,
      isFav: false,
      plan: Plan.fromJson({}),
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AddFavoriteInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    bool? isFav,
    Plan? plan,
  }) {
    return AddFavoriteInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      isFav: isFav ?? this.isFav,
      plan: plan ?? this.plan,
    );
  }
}
