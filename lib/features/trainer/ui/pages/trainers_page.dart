import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/trainers_cubit/trainers_cubit.dart';
import '../widget/trainer_widget.dart';


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
