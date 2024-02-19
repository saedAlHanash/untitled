// part of 'bookmarked_cubit.dart';
//
// class BookmarkedInitial extends AbstractCubit<List<BookmarkedModel>> {
//   // final BookmarkedRequest request;
//   // final  bool bookmarkedParam;
//   const BookmarkedInitial({
//     required super.result,
//     super.error,
//     // required this.request,
//     // required this.bookmarkedParam,
//     super.statuses,
//   });
//
//   factory BookmarkedInitial.initial() {
//     return const BookmarkedInitial(
//       result: [],
//       error: '',
//       // bookmarkedParam: false,
//       // request: BookmarkedRequest(),
//       statuses: CubitStatuses.init,
//     );
//   }
//
//   @override
//   List<Object> get props => [statuses, result, error];
//
//   BookmarkedInitial copyWith({
//     CubitStatuses? statuses,
//     List<BookmarkedModel>? result,
//     String? error,
//     // BookmarkedRequest? request,
//     // bool? bookmarkedParam,
//   }) {
//     return BookmarkedInitial(
//       statuses: statuses ?? this.statuses,
//       result: result ?? this.result,
//       error: error ?? this.error,
//       // request: request ?? this.request,
//       // bookmarkedParam: bookmarkedParam ?? this.bookmarkedParam,
//     );
//   }
// }
