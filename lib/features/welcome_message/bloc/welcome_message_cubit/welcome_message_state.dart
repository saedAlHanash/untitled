part of 'welcome_message_cubit.dart';

class WelcomeMessageInitial extends AbstractCubit<WelcomeMessage> {
  // final WelcomeMessageRequest request;
  // final bool welcomeMessageParam;

  const WelcomeMessageInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.welcomeMessageParam,
    super.statuses,
  });

  factory WelcomeMessageInitial.initial() {
    return WelcomeMessageInitial(
      result: WelcomeMessage.fromJson({}),
      error: '',
      // welcomeMessageParam: false,
      // request: WelcomeMessageRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  WelcomeMessageInitial copyWith({
    CubitStatuses? statuses,
    WelcomeMessage? result,
    String? error,
    // WelcomeMessageRequest? request,
    // bool? welcomeMessageParam,
  }) {
    return WelcomeMessageInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      // welcomeMessageParam: welcomeMessageParam ?? this.welcomeMessageParam,
    );
  }
}
