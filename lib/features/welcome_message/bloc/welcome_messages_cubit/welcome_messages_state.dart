part of 'welcome_messages_cubit.dart';

class WelcomeMessagesInitial extends AbstractState<List<WelcomeMessage>> {
  // final WelcomeMessageRequest request;
  // final  bool welcomeMessageParam;
  const WelcomeMessagesInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.welcomeMessageParam,
    super.statuses,
  });//

  factory WelcomeMessagesInitial.initial() {
    return const WelcomeMessagesInitial(
      result: [],
      error: '',
      // welcomeMessageParam: false,
      // request: WelcomeMessageRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  WelcomeMessagesInitial copyWith({
    CubitStatuses? statuses,
    List<WelcomeMessage>? result,
    String? error,
    // WelcomeMessageRequest? request,
    // bool? welcomeMessageParam,
  }) {
    return WelcomeMessagesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      // welcomeMessageParam: welcomeMessageParam ?? this.welcomeMessageParam,
    );
  }
}
