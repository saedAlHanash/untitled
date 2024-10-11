part of 'payments_cubit.dart';

class PaymentsInitial extends AbstractState<List<Payment>> {
  const PaymentsInitial({
    required super.result,
    super.error,
    super.request,
    super.statuses,
  }); //

  factory PaymentsInitial.initial() {
    return const PaymentsInitial(
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

  PaymentsInitial copyWith({
    CubitStatuses? statuses,
    List<Payment>? result,
    String? error,
    dynamic request,
  }) {
    return PaymentsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
