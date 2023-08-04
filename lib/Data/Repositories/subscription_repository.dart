 

import 'package:dio/dio.dart';
import 'package:fitness_storm/Model/payment_private_session.dart';
import 'package:fitness_storm/Model/trainee_next_payment.dart';

import '../../Model/subscription_model.dart';
import '../../Utils/utils.dart';
import '../Api/api_result.dart';
import '../Api/methods.dart';
import '../Api/urls.dart';

class SubscriptionRepository {
  Future<List<dynamic>> getNextPayment() async {
    Options option = Utils.getOptions(withToken: true, all: true);
    try {
      List<dynamic> traineeNextPayments = [];
      ApiResult result =
          await Methods.get(url: TRAINEEURLS.getMyPayment, options: option);
      if (result.type == ApiResultType.success) {
        result.data.forEach(
            (payment) => traineeNextPayments.add(TraineeNextPayment.fromJson(payment)));
      }
      result =
          await Methods.get(url: TRAINEEURLS.getMyPaymentPrivateSession, options: option);
      if (result.type == ApiResultType.success) {
        result.data.forEach((payment) =>
            traineeNextPayments.add(PaymentPrivateSession.fromJson(payment)));
      }
      return traineeNextPayments;
    } catch (e) {
     //log(e.toString());
    }
    return [];
  }

  Future<SubscriptionsModel> subscribePaymentPlan() async {
    Options option = Utils.getOptions(withToken: true, all: true);
    try {
      final result =
          await Methods.getJson(url: TRAINEEURLS.subscribePaymentPlan, options: option);
      if (result!.statusCode == 200) {
        return SubscriptionsResponse.fromJson(result.data).data;
      }
    } catch (error) {
      
    }
    return SubscriptionsModel.fromJson({});
  }

  Future<dynamic> createNewSubscription({
    required String subscriptionId,
  }) async {
    // Map<String, dynamic> data = {
    //   "subscription_id": subscriptionId,
    // };
    Options option = Utils.getOptions(withToken: true, all: true);
    try {
      ApiResult result = await Methods.post(
          url: TRAINEEURLS.subscribtionPay,
          data: {
            "subscription_id": subscriptionId,
          },
          options: option);
      if (result.type == ApiResultType.success) {
        return result;
      }
    } catch (error) {
      
    }
    return ApiResultType.failure;
  }

  Future<dynamic> cancelSubscription() async {
    Map<String, dynamic> data = {};
    Options option = Utils.getOptions(withToken: true, all: true);
    try {
      ApiResult result = await Methods.post(
          url: TRAINEEURLS.cancelSubscription, data: data, options: option);
      if (result.type == ApiResultType.success) {
        return result;
      }
    } catch (error) {
      
    }
    return ApiResultType.failure;
  }
}
