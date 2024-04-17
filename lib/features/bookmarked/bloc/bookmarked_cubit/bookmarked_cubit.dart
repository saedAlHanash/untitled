// import 'package:fitness_storm/core/api_manager/api_url.dart';
// import 'package:fitness_storm/core/extensions/extensions.dart';
// import 'package:fitness_storm/core/util/shared_preferences.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../core/api_manager/api_service.dart';
// import '../../../../core/error/error_manager.dart';
// import '../../../../core/strings/enum_manager.dart';
// import '../../../../core/util/abstraction.dart';
// import '../../../../core/util/pair_class.dart';
//
// part 'bookmarked_state.dart';
//
// class BookmarkedCubit extends Cubit<BookmarkedInitial> {
//   BookmarkedCubit() : super(BookmarkedInitial.initial());
//
//   Future<void> getBookmarked() async {
//     emit(state.copyWith(statuses: CubitStatuses.loading));
//     final pair = await _bookedAppointmentsApi();
//     if (pair.first == null) {
//       emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
//       showErrorFromApi(state);
//     } else {
//       emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first?.data));
//     }
//   }
//
//   Future<Pair<BookmarkedList?, String?>> _bookedAppointmentsApi() async {
//     final response = await APIService().getApi(url: GetUrl.bookmarked);
//
//     if (response.statusCode.success) {
//       return Pair(BookmarkedList.fromJson(response.jsonBodyPure), null);
//     } else {
//       return response.getPairError;
//     }
//   }
// }
