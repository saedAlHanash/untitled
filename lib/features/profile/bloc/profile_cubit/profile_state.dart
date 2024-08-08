part of 'profile_cubit.dart';

class ProfileInitial extends AbstractState<Profile> {
  const ProfileInitial({
    required super.result,
    super.error,
    super.statuses,
  });

  factory ProfileInitial.initial() {
    return ProfileInitial(
      result: AppProvider.profile,
    );
  }

  @override
  List<Object> get props => [
    statuses,
    result,
    error,
    if (request != null) request,
  ];

  ProfileInitial copyWith({
    CubitStatuses? statuses,
    Profile? result,
    String? error,
  }) {
    return ProfileInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
