import 'package:fitness_storm/Data/Repositories/subscription_repository.dart';
import 'package:get/state_manager.dart';

class MyPaymentController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxInt _tabIndex = 0.obs;
  List<dynamic> traineeNextPayment = [];
  SubscriptionRepository subscriptionRepository = SubscriptionRepository();

  // final myTabController = TabController(length: 3, vsync: this);

  int get tabIndex => _tabIndex.value;

  set tabIndex(value) => _tabIndex.value = value;

  bool get isLoading => _isLoading.value;

  set isLoading(value) => _isLoading.value = value;

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading = true;
    tabIndex = 0;
    traineeNextPayment = await getNextPayment();
    isLoading = false;
  }

  void changeTabIndex(int index) {
    tabIndex = index;
  }

  getNextPayment() async {
    return await subscriptionRepository.getNextPayment();
  }
}
