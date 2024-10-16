part of 'cancel_subscription_cubit.dart';

class CancelSubscriptionInitial extends AbstractState<String> {
  const CancelSubscriptionInitial({
    required super.request,
    required super.result,
    super.error,
    super.statuses,
  });

  String get mRequest => request;

  factory CancelSubscriptionInitial.initial() {
    return CancelSubscriptionInitial(
      result: '',
      request: '',
    );
  }

  @override
  List<Object> get props => [statuses, result, error, if (request != null) request];

  CancelSubscriptionInitial copyWith({
    CubitStatuses? statuses,
    String? result,
    String? error,
    String? request,
  }) {
    return CancelSubscriptionInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }


}
