part of 'confirm_code_cubit.dart';

class ConfirmCodeInitial extends AbstractCubit<bool> {
  final LoginRequest request;
  final bool isPassReset;

  const ConfirmCodeInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.request,
    required this.isPassReset,
  });

  factory ConfirmCodeInitial.initial() {
    return ConfirmCodeInitial(
      result: false,
      request: LoginRequest(),
      isPassReset: false,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ConfirmCodeInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    LoginRequest? request,
    bool? isPassReset,
  }) {
    return ConfirmCodeInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      isPassReset: isPassReset ?? this.isPassReset,
    );
  }
}
