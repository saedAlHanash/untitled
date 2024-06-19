import 'package:bloc/bloc.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/models/plan_model.dart';
import 'package:fitness_storm/core/util/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';

part 'add_favorite_state.dart';

class AddFavoriteCubit extends Cubit<AddFavoriteInitial> {
  AddFavoriteCubit() : super(AddFavoriteInitial.initial());

  Future<void> changeFavorite({required PlanModel plan}) async {
    emit(state.copyWith(
      statuses: CubitStatuses.loading,
      plan: plan,
      isFav: !plan.isBookmark,
    ));

    final pair = plan.isBookmark ? await _removeFavoriteApi() : await _addFavoriteApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      plan.isBookmark = !plan.isBookmark;
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _addFavoriteApi() async {
    final response = await APIService().callApi(type: ApiType.post,url: PostUrl.addFavorite(state.plan.id));

    if (response.statusCode.success) {
      state.plan.isBookmark = true;
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }

  Future<Pair<bool?, String?>> _removeFavoriteApi() async {
    final response = await APIService().callApi(type: ApiType.post,
      url: DeleteUrl.removeFavorite(state.plan.id),
    );

    if (response.statusCode.success) {
      state.plan.isBookmark = false;
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }
}
