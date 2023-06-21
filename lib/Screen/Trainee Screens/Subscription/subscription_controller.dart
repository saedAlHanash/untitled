import 'dart:developer';

import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../Data/Repositories/subscription_repository.dart';
import '../../../Data/Repositories/trainee_repository.dart';
import '../../../Model/subscription_model.dart';
import '../../../Model/user_profile.dart';
import '../../../Utils/utils.dart';

class SubscruptionController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxBool _isBuy = false.obs;
  final Rx<SubscriptionsModel> _subscriptionsModel = SubscriptionsModel.fromJson({}).obs;
  final TraineeRepository _traineeRepository = TraineeRepository();
  late UserProfile userProfile;
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

  // initalizeWebViewController(String url) async {
  //   webViewControllerl = WebViewController()
  //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //     ..setBackgroundColor(const Color(0x00000000))
  //     ..setNavigationDelegate(
  //       NavigationDelegate(
  //         onProgress: (int progress) {
  //           // Update loading bar.
  //         },
  //         onPageStarted: (String url) {},
  //         onPageFinished: (String url) {},
  //         onWebResourceError: (WebResourceError error) {},
  //         onNavigationRequest: (NavigationRequest request) {
  //           if (request.url.startsWith(url)) {
  //             return NavigationDecision.prevent;
  //           }
  //           return NavigationDecision.navigate;
  //         },
  //       ),
  //     )
  //     ..loadRequest(Uri.parse(url));
  // }

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
      userProfile = UserProfile.fromJson(result.data);
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
    required num amount,
    required String currency,
    required String subscriptionId,
  }) async {
    try {
      isLoading = true;
      var d1 = await createPaymentIntent(subscriptionId);
      String uri = d1.data['url'];
      return uri;
    } catch (e, s) {
      Utils.openSnackBar(title: 'failure'.tr, message: 'An_error_occurred'.tr);
      isLoading = false;
      log('exception:$e$s');
    }
    return "";
  }

  createPaymentIntent(String subscriptionId) async {
    try {
      return await _subscriptionRepository.createNewSubscription(
        subscriptionId: subscriptionId,
      );
    } catch (err) {
      log('err charging user: ${err.toString()}');
    }
  }

  cancelSubscribtion() async {
    try {
      return await _subscriptionRepository.cancelSubscription();
    } catch (err) {
      log('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(double amount) {
    final a = (amount.toInt()) * 100;
    return a.toString();
  }
}
