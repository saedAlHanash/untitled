part of 'plan_cubit.dart';

class PlanInitial extends AbstractState<Plan> {

 final  PodPlayerController? videoController;

  const PlanInitial({
    required super.result,
    super.error,
    required super.request,
     this.videoController,
    // required this.tempParam,
    super.statuses,
  });

  factory PlanInitial.initial() {
    return PlanInitial(
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
    if (videoController != null)   videoController!,
    if (request != null) request,
   
  ];

  PlanInitial copyWith({
    CubitStatuses? statuses,
    Plan? result,
    String? error,
    int? request,
    PodPlayerController? videoController,
    // bool? tempParam,
  }) {
    return PlanInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      videoController: videoController ?? this.videoController,
      // tempParam: tempParam ?? this.tempParam,
    );
  }
}
