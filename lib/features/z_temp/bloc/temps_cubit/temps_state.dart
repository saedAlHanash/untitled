part of 'temps_cubit.dart';

class TempsInitial extends AbstractState<List<Temp>> {
  const TempsInitial({
    required super.result,
    super.error,
    super.request,
    super.statuses,
  }); //

  factory TempsInitial.initial() {
    return const TempsInitial(
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

  TempsInitial copyWith({
    CubitStatuses? statuses,
    List<Temp>? result,
    String? error,
    dynamic request,
  }) {
    return TempsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
