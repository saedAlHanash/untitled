part of 'create_session_cubit.dart';

class CreateSessionInitial extends AbstractCubit<String> {
  // final CreateSessionRequest request;
  final int id;

  const CreateSessionInitial({
    required super.result,
    super.error,
    // required this.request,
    required this.id,
    super.statuses,
  });

  factory CreateSessionInitial.initial() {
    return const CreateSessionInitial(
      result: '',
      error: '',
      id: 0,
      // request: CreateSessionRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateSessionInitial copyWith({
    CubitStatuses? statuses,
    String? result,
    String? error,
    // CreateSessionRequest? request,
    int? id,
  }) {
    return CreateSessionInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      id: id ?? this.id,
    );
  }
}
