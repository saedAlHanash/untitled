import 'package:collection/collection.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/util/my_style.dart';
import '../../../appointments/bloc/booked_appointments_cubit/booked_appointments_cubit.dart';
import '../../../trainer/bloc/trainer_plans_cubit/trainer_plans_cubit.dart';
import '../../bloc/trainer_cubit/trainer_cubit.dart';
import '../widget/plan_time_frequency.dart';
import '../widget/plans_list.dart';
import '../widget/trainer_bio_widget.dart';
import '../widget/trainer_header.dart';

class TrainerPage extends StatefulWidget {
  const TrainerPage({super.key});

  @override
  State<TrainerPage> createState() => _TrainerPageState();
}

class _TrainerPageState extends State<TrainerPage> {
  late final TrainerCubit trainerCubit;

  @override
  void initState() {
    trainerCubit = context.read<TrainerCubit>();
    context.read<BookedAppointmentsCubit>().getBookedAppointments(
          trainerId: trainerCubit.state.id,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: BlocBuilder<TrainerCubit, TrainerInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                TrainerHeader(trainer: state.result),
                TrainerBioWidget(trainer: state.result),
                10.0.verticalSpace,
                BlocBuilder<TrainerPlansCubit, TrainerPlansInitial>(
                  builder: (context, state) {
                    if (state.statuses.loading) {
                      return MyStyle.loadingWidget();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: state.result.mapIndexed((i, e) {
                        return PlansList(
                          plan: e,
                          index: i,
                          subTitle: PlanTimeFrequency(
                            totalWeeks: e.totalWeeks,
                            workoutFrequency: e.workoutFrequency,
                            color: Colors.grey,
                            trainingType: '',
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
