part of 'add_time_cubit.dart';

class AddTimeInitial extends AbstractState<bool> {
  final DateTime request;
  // final bool addTimeParam;

  const AddTimeInitial({
    required super.result,
    super.error,
    required this.request,
    // required this.addTimeParam,
    super.statuses,
  });

  factory AddTimeInitial.initial() {
    return AddTimeInitial(
      result: false,
      error: '',
      // addTimeParam: false,
      request: DateTime.now(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error,request];

  AddTimeInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    DateTime? request,
    // bool? addTimeParam,
  }) {
    return AddTimeInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      // addTimeParam: addTimeParam ?? this.addTimeParam,
    );
  }
}
