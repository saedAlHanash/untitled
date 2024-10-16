import 'package:collection/collection.dart';
import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/subscription_response.dart';

part 'subscriptions_state.dart';

class SubscriptionsCubit extends MCubit<SubscriptionsInitial> {
  SubscriptionsCubit() : super(SubscriptionsInitial.initial());

  @override
  String get nameCache => 'subscriptions';

  @override
  String get filter => state.filter;

  Future<void> getSubscriptions({bool newData = false}) async {
    await getDataAbstract(
      fromJson: Subscription.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<List<Subscription>?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.subscriptions,
    );

    if (response.statusCode.success) {
      return Pair(Subscriptions.fromJson(response.jsonBodyPure).data.subscriptions, null);
    } else {
      return response.getPairError;
    }
  }

  Future<void> addSubscription(Subscription item) async {
    final listJson = await addOrUpdateDate([item]);
    if (listJson == null) return;
    final list = listJson.map((e) => Subscription.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }

  Future<void> deleteSubscriptionFromCache(String id) async {
    final listJson = await deleteDate([id]);
    if (listJson == null) return;
    final list = listJson.map((e) => Subscription.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }
}
