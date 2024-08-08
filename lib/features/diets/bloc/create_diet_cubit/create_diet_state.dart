part of 'create_diet_cubit.dart';

class CreateDietInitial extends AbstractState<Diet> {
  const CreateDietInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
  }); //

  CreateDietRequest get mRequest => request;

  factory CreateDietInitial.initial() {
    return CreateDietInitial(
      result: Diet.fromJson({}),
      error: '',
      request: CreateDietRequest.fromJson({}),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [
    statuses,
    result,
    error,
    if (request != null) request,
  ];

  CreateDietInitial copyWith({
    CubitStatuses? statuses,
    Diet? result,
    String? error,
    CreateDietRequest? request,
  }) {
    return CreateDietInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
