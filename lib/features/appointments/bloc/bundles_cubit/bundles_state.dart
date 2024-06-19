part of 'bundles_cubit.dart';

class BundlesInitial extends AbstractState<List<Bundle>> {
  final BundlesRequest request;
  // final bool bundlesParam;

  const BundlesInitial({
    required super.result,
    super.error,
    required this.request,
    // required this.bundlesParam,
    super.statuses,
  });

  factory BundlesInitial.initial() {
    return  BundlesInitial(
      result: const [],
      error: '',
      // bundlesParam: false,
      request: BundlesRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  BundlesInitial copyWith({
    CubitStatuses? statuses,
    List<Bundle>? result,
    String? error,
    BundlesRequest? request,
    // bool? bundlesParam,
  }) {
    return BundlesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      // bundlesParam: bundlesParam ?? this.bundlesParam,
    );
  }
}
