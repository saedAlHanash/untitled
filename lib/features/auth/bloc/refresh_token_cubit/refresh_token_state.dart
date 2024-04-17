part of 'refresh_token_cubit.dart';

class RefreshTokenInitial extends AbstractCubit<bool> {


  const RefreshTokenInitial({
    required super.result,
    super.error,
    super.statuses,
  });

  factory RefreshTokenInitial.initial() {
    return const RefreshTokenInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  RefreshTokenInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return RefreshTokenInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}