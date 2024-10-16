import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/models/plan_model.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/bookmarked_response.dart';

part 'bookmarked_state.dart';

class BookmarkedCubit extends MCubit<BookmarkedInitial> {
  BookmarkedCubit() : super(BookmarkedInitial.initial());

  @override
  String get nameCache => 'bookmarked';

  Future<void> getBookmarked({bool newData = false}) async {
    getDataAbstract(
      fromJson: Plan.fromJson,
      state: state,
      getDataApi: _getDataApi,
      newData: newData,
    );
  }

  Future<Pair<List<Plan>?, String?>> _getDataApi() async {
    final response =
        await APIService().callApi(type: ApiType.get, url: GetUrl.bookmarked);

    if (response.statusCode.success) {
      return Pair(BookmarkedResponse.fromJson(response.jsonBodyPure).data, null);
    } else {
      return response.getPairError;
    }
  }

  Future<void> addBookmark(Plan item) async {
    final listJson = await addOrUpdateDate([item]);
    if (listJson == null) return;
    final list = listJson.map((e) => Plan.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }

  Future<void> deleteBookmarkFromCache(String id) async {
    final listJson = await deleteDate([id]);
    if (listJson == null) return;
    final list = listJson.map((e) => Plan.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }
}
