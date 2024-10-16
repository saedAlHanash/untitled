part of 'subscriptions_cubit.dart';

class SubscriptionsInitial extends AbstractState<List<Subscription>> {
  const SubscriptionsInitial({
    required super.result,
    super.error,
    super.request,
    super.statuses,
  }); //

  factory SubscriptionsInitial.initial() {
    return const SubscriptionsInitial(
      result: [],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  bool get isSubscribe => result.firstWhereOrNull((e) => e.currentSubscription) != null;

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        if (request != null) request,
      ];

  SubscriptionsInitial copyWith({
    CubitStatuses? statuses,
    List<Subscription>? result,
    String? error,
    dynamic request,
  }) {
    return SubscriptionsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
