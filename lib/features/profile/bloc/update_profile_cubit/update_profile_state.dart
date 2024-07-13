part of 'update_profile_cubit.dart';

class UpdateProfileInitial extends AbstractState<bool> {
  final Profile request;

  const UpdateProfileInitial({
    required super.result,
    required this.request,
    super.error,
    super.statuses,
  });

  @override
  List<Object> get props => [statuses, result, error,request];

  factory UpdateProfileInitial.initial() {
    return UpdateProfileInitial(
      request: AppProvider.profile,
      result: false,
    );
  }

  UpdateProfileInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? image,
    String? error,
    Profile? request,
  }) {
    return UpdateProfileInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
