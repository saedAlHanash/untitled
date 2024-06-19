part of 'login_cubit.dart';

class LoginInitial extends AbstractState<LoginData> {
  final LoginRequest request;
 final  UserType userType;
  const LoginInitial({
    required super.result,
    super.error,
    required this.request,
     required this.userType,
    super.statuses,
  });

  factory LoginInitial.initial() {
    return LoginInitial(
      result: LoginData.fromJson({}),
      error: '',
      userType: UserType.user,
      request: LoginRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error,userType];

  LoginInitial copyWith({
    CubitStatuses? statuses,
    LoginData? result,
    String? error,
    LoginRequest? request,
    UserType? userType,
  }) {
    return LoginInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      userType: userType ?? this.userType,
    );
  }
}
