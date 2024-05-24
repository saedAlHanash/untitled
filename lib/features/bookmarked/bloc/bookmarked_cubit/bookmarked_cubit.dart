import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/models/plan_model.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/bookmarked_response.dart';

part 'bookmarked_state.dart';

class BookmarkedCubit extends MCubit<BookmarkedInitial> {
  BookmarkedCubit() : super(BookmarkedInitial.initial());

  @override
  String get nameCache => 'bookmarked';

  Future<void> getBookmarked({bool newData = false}) async {
    if (await checkCashed(newData: newData)) return;

    final pair = await _getBookmarked();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<PlanModel>?, String?>> _getBookmarked() async {
    final response = await APIService().getApi(url: GetUrl.bookmarked);

    if (response.statusCode.success) {
      return Pair(
          BookmarkedResponse.fromJson(response.jsonBodyPure).data, null);
    } else {
      return response.getPairError;
    }
  }

  Future<bool> checkCashed({bool newData = false}) async {
    final cacheType =
        newData ? NeedUpdateEnum.withLoading : await needGetData();

    emit(
      state.copyWith(
        statuses: cacheType.getState,
        result:
            (await getListCached()).map((e) => PlanModel.fromJson(e)).toList(),
      ),
    );

    if (cacheType == NeedUpdateEnum.no) return true;
    return false;
  }
}
