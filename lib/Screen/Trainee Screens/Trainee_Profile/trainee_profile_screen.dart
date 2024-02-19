// import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee_Profile/Widget/subscription_plan_button.dart';
// import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee_Profile/Widget/trainee_profile_body.dart';
// import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee_Profile/Widget/user_profile_info_buttons.dart';
// import 'package:fitness_storm/Screen/Trainee%20Screens/Trainee_Profile/trainee_profile_controller.dart';
// import 'package:fitness_storm/core/extensions/extensions.dart';
// import 'package:fitness_storm/router/app_router.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
//
// import '../../../core/app/app_provider.dart';
// import '../../../features/auth/bloc/logout/logout_cubit.dart';
// import 'Widget/trainee_profile_header.dart';
// import 'Widget/trainer_button.dart';
//
// class TraineeProfileScreen extends GetView<TraineeProfileController> {
//   const TraineeProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: Theme.of(context).primaryColor, // status bar color
//     ));
//     // controller.getUserProfile();
//
//     return BlocListener<LogoutCubit, LogoutInitial>(
//       listenWhen: (p, c) => c.statuses.done,
//       listener: (context, state) {
//         startLogin();
//       },
//       child: Obx(
//         () => SizedBox(
//           width: Get.width,
//           child: controller.isLoading
//               ? Center(child: CircularProgressIndicator(color: Get.theme.primaryColor))
//               : Padding(
//                   padding: EdgeInsets.symmetric(horizontal: Get.width / 12.5),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const TraineeProfileHeader(),
//                         if (AppControl.isAppleAccount) //add this for apple store
//                           const SubscriptionPlanButton(),
//                         const TraineeProfileBody(),
//                         const TrainerButton(),
//                         const UserProfileInfoButtons(),
//                         const SizedBox(height: 20)
//                       ],
//                     ),
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }
