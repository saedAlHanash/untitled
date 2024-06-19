part of 'create_bundle_cubit.dart';

class CreateBundleInitial extends AbstractState<String> {
  final Bundle bundle;
  final CreateBundleRequest request;
  final int notify;

  const CreateBundleInitial({
    required super.result,
    super.error,
    required this.bundle,
    required this.request,
    required this.notify,
    super.statuses,
  });

  factory CreateBundleInitial.initial() {
    return CreateBundleInitial(
      result: '',
      error: '',
      notify: 0,
      bundle: Bundle.fromJson({}),
      request: CreateBundleRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error,notify];

  CreateBundleInitial copyWith({
    CubitStatuses? statuses,
    String? result,
    String? error,
    Bundle? bundle,
    CreateBundleRequest? request,
    int? notify,
  }) {
    return CreateBundleInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      bundle: bundle ?? this.bundle,
      request: request ?? this.request,
      notify: notify ?? this.notify,
    );
  }
}
