// part of 'available_times_trainer_cubit.dart';
//
// class AvailableTimesTrainerInitial extends AbstractCubit<List<AvailableTime>> {
//   final AvailableTimesRequest request;
//   // final  bool availableTimesParam;
//   const AvailableTimesTrainerInitial({
//     required super.result,
//     super.error,
//     required this.request,
//     // required this.availableTimesParam,
//     super.statuses,
//   });//
//
//   factory AvailableTimesTrainerInitial.initial() {
//     return  AvailableTimesTrainerInitial(
//       result: [],
//       error: '',
//       // availableTimesParam: false,
//       request: AvailableTimesRequest(),
//       statuses: CubitStatuses.init,
//     );
//   }
//
//   @override
//   List<Object> get props => [statuses, result, error];
//
//   AvailableTimesTrainerInitial copyWith({
//     CubitStatuses? statuses,
//     List<AvailableTime>? result,
//     String? error,
//     AvailableTimesRequest? request,
//     // bool? availableTimesParam,
//   }) {
//     return AvailableTimesTrainerInitial(
//       statuses: statuses ?? this.statuses,
//       result: result ?? this.result,
//       error: error ?? this.error,
//       request: request ?? this.request,
//       // availableTimesParam: availableTimesParam ?? this.availableTimesParam,
//     );
//   }
// }
