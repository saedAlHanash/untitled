part of 'subscribe_plan_cubit.dart';

class SubscribePlanInitial extends AbstractState<Plan> {
  final PodPlayerController? videoController;

  const SubscribePlanInitial({
    required super.result,
    super.error,
    required super.request,
    this.videoController,
    // required this.tempParam,
    super.statuses,
  });

  factory SubscribePlanInitial.initial() {
    return SubscribePlanInitial(
      result: Plan.fromJson({}),
      error: '',
      // tempParam: false,
      request: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        if (videoController != null) videoController!,
        if (request != null) request,
      ];

  SubscribePlanInitial copyWith({
    CubitStatuses? statuses,
    Plan? result,
    String? error,
    int? request,
    PodPlayerController? videoController,
    // bool? tempParam,
  }) {
    return SubscribePlanInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      videoController: videoController ?? this.videoController,
      // tempParam: tempParam ?? this.tempParam,
    );
  }
}
