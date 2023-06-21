import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Repositories/Trainer%20Repository/trainer_auth_repository.dart';
import 'package:fitness_storm/Model/trainer.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:fitness_storm/Utils/storage_controller.dart';
import 'package:fitness_storm/Utils/utils.dart';
import 'package:get/get.dart';

import '../../chat/util.dart';

class TrainerProfileController extends GetxController {
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(value) => _isLoading.value = value;

  late final Trainer trainerProfile;

  final TrainerAuthRepository _trainerAuthRepository = TrainerAuthRepository();

  @override
  Future<void> onInit() async {
    super.onInit();
    await getTrainerProfile();
  }

  logout() async {
    Utils.openLoadingDialog();
    final storageController = StorageController();
    var res = await _trainerAuthRepository.trainerLogout();
    if (res.type == ApiResultType.success) {
      storageController.token = '';
      storageController.rememberToken = '';
      await logoutChatUser();
      ;
      Get.back();
      // Utils.openSnackBar(title: 'Logout Success');
      Get.offAllNamed(AppRoutes.signIn);
    } else {
      if (res.message == 'Unauthenticated.') {
        storageController.token = '';
        storageController.rememberToken = '';
        Get.back();
        // Utils.openSnackBar(title: 'Logout Success');
        Get.offAllNamed(AppRoutes.signIn);
      }
      await logoutChatUser();
      ;
      Get.back();
      Utils.openSnackBar(message: res.message!);
    }
  }

  getTrainerProfile() async {
    isLoading = true;
    final result = await _trainerAuthRepository.getTrainerProfile();
    if (result.type == ApiResultType.success) {
      trainerProfile = Trainer.fromJson(result.data);
    } else {
      Utils.openSnackBar(title: 'Something_Went_Wrong'.tr);
    }
    isLoading = false;
  }

  onMyPlansButtonPressed() {
    log('message');
    Get.toNamed(AppRoutes.trainerPlans);
  }

  onTrainerProfileButtonPressed() {
    Get.toNamed(AppRoutes.trainerProfileOverview, arguments: trainerProfile);
  }
}
