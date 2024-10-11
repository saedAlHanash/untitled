import 'package:dio/dio.dart';

import '../../Model/subscription_model.dart';
import '../../Utils/utils.dart';
import '../../features/coupon/data/request/pay_request.dart';
import '../Api/api_result.dart';
import '../Api/methods.dart';
import '../Api/urls.dart';

class SubscriptionRepository {

  Future<SubscriptionsModel> subscribePaymentPlan() async {
    Options option = Utils.getOptions(withToken: true, all: true);
    try {
      final result =
          await Methods.getJson(url: TRAINEEURLS.subscribePaymentPlan, options: option);
      if (result!.statusCode == 200) {
        return SubscriptionsResponse.fromJson(result.data).data;
      }
    } catch (error) {}
    return SubscriptionsModel.fromJson({});
  }

  Future<dynamic> createNewSubscription({
    required PayRequest request,
  }) async {
    // Map<String, dynamic> data = {
    //   "subscription_id": subscriptionId,
    // };
    Options option = Utils.getOptions(withToken: true, all: true);
    try {
      ApiResult result = await Methods.post(
        url: TRAINEEURLS.subscribtionPay,
        data: request.toJson(),
        options: option,
      );
      if (result.type == ApiResultType.success) {
        return result;
      }
    } catch (error) {}
    return ApiResultType.failure;
  }

  Future<dynamic> cancelSubscription(String note) async {
    Map<String, dynamic> data = {'note': note};
    Options option = Utils.getOptions(withToken: true, all: true);
    try {
      final result = await Methods.post(
          url: TRAINEEURLS.cancelSubscription, data: data, options: option);
      if (result.type == ApiResultType.success) {
        return result;
      }
    } catch (error) {}
    return ApiResultType.failure;
  }
}
