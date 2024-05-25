part of 'notifications_cubit.dart';

class NotificationsInitial extends AbstractCubit<List<NotificationModel>> {
  // final NotificationRequest request;
  // final  bool notificationParam;
  const NotificationsInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.notificationParam,
    super.statuses,
  });//

  factory NotificationsInitial.initial() {
    return const NotificationsInitial(
      result: [],
      error: '',
      // notificationParam: false,
      // request: NotificationRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  NotificationsInitial copyWith({
    CubitStatuses? statuses,
    List<NotificationModel>? result,
    String? error,
    // NotificationRequest? request,
    // bool? notificationParam,
  }) {
    return NotificationsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      // notificationParam: notificationParam ?? this.notificationParam,
    );
  }
}
