part of 'forget_password_cubit.dart';

class ForgetPasswordInitial extends AbstractCubit<bool> {
  final ForgetPassRequestRequest request;

  const ForgetPasswordInitial({
    required this.request,
    required super.result,
    super.error,
    super.statuses,
  });

  factory ForgetPasswordInitial.initial() {
    return ForgetPasswordInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
      request: ForgetPassRequestRequest(),
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ForgetPasswordInitial copyWith({
    ForgetPassRequestRequest? request,
    CubitStatuses? statuses,
    dynamic result,
    String? error,
  }) {
    return ForgetPasswordInitial(
      request: request ?? this.request,
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
