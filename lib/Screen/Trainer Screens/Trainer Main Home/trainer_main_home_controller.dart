import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitness_storm/Data/Repositories/auth_repository.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Main%20Home/Widget/trainer_navigation_bar_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../Data/Api/api_result.dart';
import '../../../core/strings/enum_manager.dart';
import '../../../main.dart';
import '../../chat/get_chats_rooms_bloc/get_rooms_cubit.dart';

 

class TrainerMainHomeController extends GetxController {
  TrainerAppNavigationBarController navController = TrainerAppNavigationBarController();

  final AuthRepository _authRepository = AuthRepository();
  String? token;

  @override
  Future<void> onInit() async {
    saveFCM();
    final getRoomCubitState = Get.context?.read<GetRoomsCubit>().state.statuses;
    if (getRoomCubitState != CubitStatuses.done &&
        getRoomCubitState != CubitStatuses.loading) {
      Get.context?.read<GetRoomsCubit>().getChatRooms();
    }

    getToken();
    super.onInit();
  }

  Future<void> getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    if (token != null) await storeFcm(token!);
  }

  storeFcm(String token) async {
    ApiResult result = await _authRepository.saveFCM(token);
    //log(result.type.toString());
  }
}
