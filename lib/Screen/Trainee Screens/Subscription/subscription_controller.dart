import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../Data/Repositories/subscription_repository.dart';
import '../../../Data/Repositories/trainee_repository.dart';
import '../../../Model/subscription_model.dart';
import '../../../Utils/utils.dart';
import '../../../features/coupon/data/request/pay_request.dart';
import '../../../features/profile/data/response/profile_response.dart';

class SubscruptionController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxBool _isBuy = false.obs;
  final Rx<SubscriptionsModel> _subscriptionsModel =
      SubscriptionsModel.fromJson({}).obs;
  final TraineeRepository _traineeRepository = TraineeRepository();
  late Profile userProfile;
  late Rx<bool> _isSubscribe = false.obs;
  final RxString _nameUser = "".obs;

  bool get isLoading => _isLoading.value;

  bool get isBuy => _isBuy.value;

  bool get isSubscribe => _isSubscribe.value;

  String get nameUser => _nameUser.value;

  SubscriptionsModel get subscriptions => _subscriptionsModel.value;

  set isLoading(value) => _isLoading.value = value;

  set isSubscribe(value) => _isSubscribe.value = value;

  set subscriptions(value) => _subscriptionsModel.value = value;

  set isBuy(value) => _isBuy.value = value;

  set nameUser(value) => _nameUser.value = value;

  final _subscriptionRepository = SubscriptionRepository();
  WebViewController? webViewControllerl;
  Map<String, dynamic>? paymentIntentData;

  getSubscribtionPaymentPlan() async {
    isLoading = true;
    subscriptions = await _subscriptionRepository.subscribePaymentPlan();

    for (var element in subscriptions.subscriptions.toList()) {
      if (element.currentSubscription) {
        _isSubscribe = true.obs;
        break;
      }
    }

    getUserProfile();
    isLoading = false;
  }

  @override
  Future<void> onInit() async {
    getSubscribtionPaymentPlan();
    super.onInit();
  }

  getUserProfile() async {
    isLoading = true;
    ApiResult result = await _traineeRepository.getUserProfile();
    if (result.type == ApiResultType.success) {
      userProfile = Profile.fromJson(result.data);
      nameUser = userProfile.name;
    } else {
      Utils.openSnackBar(title: 'Something_Went_Wrong'.tr);
    }
    isLoading = false;
  }

  changeIsSubscrip() {
    _isSubscribe = false.obs;
    update();
  }

  Future<String> makePayment({
    required PayRequest request,
  }) async {

    try {
      isLoading = true;
      var d1 = await createPaymentIntent(request);
      String uri = d1.data['url'];
      return uri;
    } catch (e, s) {
      Utils.openSnackBar(title: 'failure'.tr, message: 'An_error_occurred'.tr);
      isLoading = false;
      //log('exception:$e$s');
    }
    return "";
  }

  createPaymentIntent(PayRequest request) async {
    try {
      return await _subscriptionRepository.createNewSubscription(
        request: request,
      );
    } catch (err) {
      //log('err charging user: ${err.toString()}');
    }
  }

  cancelSubscribtion({required String? cancelReason}) async {
    try {
      return await _subscriptionRepository
          .cancelSubscription(cancelReason ?? '');
    } catch (err) {
      //log('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(double amount) {
    final a = (amount.toInt()) * 100;
    return a.toString();
  }
}
