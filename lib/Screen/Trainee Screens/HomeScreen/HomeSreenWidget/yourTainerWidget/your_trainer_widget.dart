// ignore_for_file: invalid_use_of_protected_member

import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/HomeSreenWidget/yourTainerWidget/your_trainer_item.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/HomeScreen/home_screen_controller.dart';
import 'package:fitness_storm/features/appointments/data/request/bundles_request.dart';
import 'package:fitness_storm/features/trainer/data/response/trainer.dart';
import 'package:fitness_storm/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../features/appointments/bloc/available_times_cubit/available_times_cubit.dart';
import '../../../../../features/appointments/bloc/bundles_cubit/bundles_cubit.dart';
import '../../../../../features/appointments/data/request/available_times_request.dart';
import '../../../../../features/plans/bloc/trainer_plans_cubit/trainer_plans_cubit.dart';
import '../../../../../features/trainer/bloc/trainer_cubit/trainer_cubit.dart';
import '../../../../../features/trainer/ui/pages/trainer_page.dart';
import '../list_header.dart';

class YourTrainersWidget extends GetWidget<HomeScreenController> {
  const YourTrainersWidget({super.key});

  Widget _buildYourTrainersList({required List<TrainerModel> trainers}) {
    return SizedBox(
      height: .3.sh,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: trainers.length,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () => startTrainerPage(context, trainers[i].id),
            child: YourTrainersItem(trainer: trainers[i]),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListHeader(
            headerTitle: 'private_sessions'.tr,
            seeAllFunction: () {
              startTrainersPage();
            }),
        _buildYourTrainersList(
          trainers: controller.yourTrainer.value
              .getRange(0,
                  controller.yourTrainer.length > 3 ? 3 : controller.yourTrainer.length)
              .toList(),
        )
      ],
    );
  }
}

void startTrainerPage(BuildContext context, int id) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<TrainerCubit>()..getTrainer(id: id)),
            BlocProvider(create: (_) => sl<TrainerPlansCubit>()..getPlans(id: id)),
            BlocProvider(
              create: (_) => sl<AvailableTimesCubit>()
                ..getAvailableTimes(
                  request: AvailableTimesRequest(),
                  trainer: TrainerModel.fromJson({'id': id}),
                ),
            ),
            BlocProvider(
              create: (_) =>
                  sl<BundlesCubit>()..getBundles(request: BundlesRequest(trainerId: id)),
            ),
          ],
          child: const TrainerPage(),
        );
      },
    ),
  );
}
