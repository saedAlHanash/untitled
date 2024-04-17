part of 'login_cubit.dart';

class LoginInitial extends AbstractCubit<LoginData> {
  final LoginRequest request;
 final  bool isTrainer;
  const LoginInitial({
    required super.result,
    super.error,
    required this.request,
     required this.isTrainer,
    super.statuses,
  });

  factory LoginInitial.initial() {
    return LoginInitial(
      result: LoginData.fromJson({}),
      error: '',
      isTrainer: false,
      request: LoginRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error,isTrainer];

  LoginInitial copyWith({
    CubitStatuses? statuses,
    LoginData? result,
    String? error,
    LoginRequest? request,
    bool? isTrainer,
  }) {
    return LoginInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      isTrainer: isTrainer ?? this.isTrainer,
    );
  }
}
