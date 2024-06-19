import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:fitness_storm/features/trainer/data/response/trainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../Screen/Trainee Screens/HomeScreen/HomeSreenWidget/yourTainerWidget/your_trainer_widget.dart';
import '../widget/trainer_widget.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/trainers_cubit/trainers_cubit.dart';


class TrainersPage extends StatelessWidget {
  const TrainersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).ourTrainer),
      body: BlocBuilder<TrainersCubit, TrainersInitial>(
        builder: (context, state) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () => startTrainerPage(context, state.result[i].id),
                child: TrainerWidget(trainer: state.result[i]),
              );
            },
          );
        },
      ),
    );
  }
}
