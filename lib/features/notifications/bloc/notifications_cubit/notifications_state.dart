part of 'notifications_cubit.dart';

class NotificationsInitial extends AbstractCubit<NotificationsResponse> {
  // final NotificationRequest request;
  final  int numOfRead;
  const NotificationsInitial({
    required super.result,
    super.error,
    // required this.request,
    required this.numOfRead,
    super.statuses,
  }); //

  factory NotificationsInitial.initial() {
    return  NotificationsInitial(
      result: NotificationsResponse.fromJson({}),
      error: '',
      numOfRead: AppSharedPreference.getNotificationsRead,
      // request: NotificationRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error,numOfRead];

  NotificationsInitial copyWith({
    CubitStatuses? statuses,
    NotificationsResponse? result,
    String? error,
    // NotificationRequest? request,
    int? numOfRead,
  }) {
    return NotificationsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      numOfRead: numOfRead ?? this.numOfRead,
    );
  }
}
