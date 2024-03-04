// import 'package:fitness_storm/core/api_manager/api_url.dart';
// import 'package:fitness_storm/core/extensions/extensions.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../core/api_manager/api_service.dart';
// import '../../../../core/error/error_manager.dart';
// import '../../../../core/strings/enum_manager.dart';
// import '../../../../core/util/abstraction.dart';
// import '../../../../core/util/pair_class.dart';
// import '../../../appointments/data/request/available_times_request.dart';
// import '../../../appointments/data/response/available_times_response.dart';
// import '../../data/response/available_times_response.dart';
//
// part 'available_times_trainer_state.dart';
//
// class AvailableTimesTrainerCubit extends Cubit<AvailableTimesTrainerInitial> {
//   AvailableTimesTrainerCubit() : super(AvailableTimesTrainerInitial.initial());
//
//   Future<void> getAvailableTimes({AvailableTimesRequest? request}) async {
//     emit(state.copyWith(statuses: CubitStatuses.loading, request: request));
//     final pair = await _bookedAppointmentsApi();
//     if (pair.first == null) {
//       emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
//       showErrorFromApi(state);
//     } else {
//       emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first?.data));
//     }
//   }
//
//   Future<Pair<AvailableTimesResponseList?, String?>> _bookedAppointmentsApi() async {
//     final response = await APIService().getApi(
//       url: GetUrl.availableTimesTrainer,
//       query: state.request.toJson(),
//     );
//
//     if (response.statusCode.success) {
//       return Pair(AvailableTimesResponseList.fromJson(response.jsonBodyPure), null);
//     } else {
//       return response.getPairError;
//     }
//   }
// }
