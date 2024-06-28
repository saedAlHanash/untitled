import 'package:fitness_storm/Data/Repositories/auth_repository.dart';
import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Main%20Home/Widget/trainer_navigation_bar_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/strings/enum_manager.dart';
import '../../../features/fire_chat/get_chats_rooms_bloc/get_rooms_cubit.dart';
import '../../../main.dart';


class TrainerMainHomeController extends GetxController {
  TrainerAppNavigationBarController navController = TrainerAppNavigationBarController();

  final AuthRepository _authRepository = AuthRepository();
  String? token;

  @override
  Future<void> onInit() async {
    saveFCM();

    super.onInit();
  }


}
