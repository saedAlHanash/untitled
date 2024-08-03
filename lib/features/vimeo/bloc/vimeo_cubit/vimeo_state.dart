part of 'vimeo_cubit.dart';

class VimeoInitial extends AbstractState<String> {
  final PodPlayerController? controller;

  const VimeoInitial({
    required super.result,
    this.controller,
    super.error,
    required super.request,
    super.statuses,
  });

  factory VimeoInitial.initial() {
    return const VimeoInitial(
      result: '',
      error: '',
      request: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        if (controller != null) controller!,
        if (request != null) request,
      ];

  VimeoInitial copyWith({
    CubitStatuses? statuses,
    String? result,
    String? error,
    String? request,
    PodPlayerController? controller,
  }) {
    return VimeoInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      controller: controller ?? this.controller,
    );
  }
}
