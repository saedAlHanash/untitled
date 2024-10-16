part of 'create_subscription_cubit.dart';

class CreateSubscriptionInitial extends AbstractState<String> {
  const CreateSubscriptionInitial({
    required super.request,
    required super.result,
    super.error,
    super.statuses,
  });

  CreateSubscriptionRequest get mRequest => request;

  factory CreateSubscriptionInitial.initial() {
    return CreateSubscriptionInitial(
      result: '',
      request: CreateSubscriptionRequest(),
    );
  }

  @override
  List<Object> get props => [statuses, result, error, if (request != null) request];

  CreateSubscriptionInitial copyWith({
    CubitStatuses? statuses,
    String? result,
    String? error,
    CreateSubscriptionRequest? request,
  }) {
    return CreateSubscriptionInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }


}
