import 'package:fitness_storm/Data/Api/api_result.dart';
import 'package:fitness_storm/Data/Repositories/auth_repository.dart';
import 'package:fitness_storm/Data/Repositories/trainee_repository.dart';
import 'package:fitness_storm/Model/user_profile.dart';
import 'package:fitness_storm/Utils/Constants/constants.dart';
import 'package:fitness_storm/Utils/Routes/app_pages.dart';
import 'package:fitness_storm/Utils/storage_controller.dart';
import 'package:fitness_storm/Utils/utils.dart';
import 'package:fitness_storm/helperClass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../chat/util.dart';

class TraineeProfileController extends GetxController {
  final TraineeRepository _traineeRepository = TraineeRepository();
  final AuthRepository _authRepository = AuthRepository();
  final Rx<UserProfile> _userProfile = UserProfile().obs;
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmationPassword = TextEditingController();

  final RxBool _isLoading = false.obs;
  final RxBool _isSuccessRequest = false.obs;

  bool get isLoading => _isLoading.value;

  bool get isSuccessRequest => _isSuccessRequest.value;

  UserProfile get userProfile => _userProfile.value;

  set isLoading(value) => _isLoading.value = value;

  set isSuccessRequest(value) => _isSuccessRequest.value = value;

  set userProfile(value) => _userProfile.value = value;

  @override
  Future<void> onInit() async {
    await getUserProfile();
    super.onInit();
  }

  getUserProfile() async {
    isLoading = true;
    ApiResult result = await _traineeRepository.getUserProfile();
    if (result.type != ApiResultType.success) {
      Utils.openSnackBar(title: 'Something_Went_Wrong'.tr);
    } else {
      userProfile = UserProfile.fromJson(result.data);
      userProfile.gender == '' ? 'male' : userProfile.gender;
      userProfile.image ?? "";
    }
    isLoading = false;
  }

  deleteAccount() async {
    isLoading = true;
    Utils.openLoadingDialog();
    ApiResult result = await _traineeRepository.deleteAccount();
    if (result.type == ApiResultType.success) {
      Utils.closeDialog();
      Get.offAllNamed(AppRoutes.signIn);
      userProfile = UserProfile.fromJson(result.data);
    } else {
      Utils.openSnackBar(title: 'Something_Went_Wrong'.tr);
    }
    isLoading = false;
  }

  editProfile() async {
    isLoading = true;
    Utils.openLoadingDialog();
    userProfile.fitnessSurvey!.preferredWorkoutLocationId = HelperClass.workoutLocation;
    ApiResult result = await _traineeRepository.editProfile(userProfile.toJson());
    if (result.type == ApiResultType.success) {
      await getUserProfile();
      loginChatUser(userProfile.id!,userProfile.name!);
      Utils.closeDialog();
    } else {
      Utils.openSnackBar(title: 'Something_Went_Wrong'.tr);
    }
    Utils.closeDialog();
    isLoading = false;
  }

  void changePassword() async {
    if (newPassword.text != confirmationPassword.text) {
      Utils.openSnackBar(title: 'Confirm_password_does_not_match_password'.tr);
    } else {
      Get.back();
      Utils.openLoadingDialog();
      isLoading = true;
      ApiResult result = await _traineeRepository.changePassword(newPassword.text);
      if (result.type == ApiResultType.success) {
        Utils.closeDialog();
        Utils.openSnackBar(title: 'Password_changed'.tr);
        isSuccessRequest = true;
        Get.back();
      } else {
        Utils.closeDialog();
        isSuccessRequest = false;
        Utils.openSnackBar(title: 'Something_Went_Wrong'.tr);
      }
      isLoading = false;
    }
  }

  logout() async {
    Utils.openLoadingDialog();
    StorageController storageController = StorageController();
    var res = await _authRepository.traineeLogout();
    if (res.type == ApiResultType.success) {
      GetStorage getStorage = GetStorage();
      await getStorage.write('currentPlan', null);
      storageController.token = '';
      storageController.rememberToken = '';
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
      Get.back();
      Utils.openSnackBar(message: res.message!);
    }
  }

  logoutGoogle() async {
    await GoogleSignIn().signOut();
    StorageController storageController = StorageController();
    storageController.token = '';
    storageController.rememberToken = '';
    storageController.methodTakeAuthentication = '';
    GetStorage getStorage = GetStorage();
    await getStorage.write('currentPlan', null);
    Get.back();
    // Utils.openSnackBar(title: 'Logout Success');
    Get.offAllNamed(AppRoutes.signIn);
  }

  logoutDependingOnTheLoginMethod() async {
    GetStorage getStorage = GetStorage();
    String methodLogin = await getStorage.read(Constants.methodTakeAuthentication);

    switch (methodLogin) {
      case 'google':
        {
          await logoutGoogle();
          await logoutChatUser();

          break;
        }

      case 'facebook':
        {
          break;
        }
      default:
        {
          await logout();
          await logoutChatUser();
          break;
        }
    }
  }

  onProfileInfoClick() {
    Get.toNamed(AppRoutes.traineeProfileInfo, arguments: userProfile);
  }

  onBookmarkedClick() {
    Get.toNamed(AppRoutes.bookmarkedScreen);
  }

  onMyPaymentsClick() {
    Get.toNamed(AppRoutes.myPaymentScreen);
  }


}
