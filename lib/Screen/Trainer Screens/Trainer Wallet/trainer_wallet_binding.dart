import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Wallet/trainer_wallet_controller.dart';
import 'package:get/instance_manager.dart';

class TrainerWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrainerWalletController());
  }
}
