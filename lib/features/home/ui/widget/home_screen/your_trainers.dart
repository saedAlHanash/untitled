import 'package:fitness_storm/features/trainer/ui/widget/your_trainer_item.dart';
import 'package:fitness_storm/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../features/trainer/bloc/trainers_cubit/trainers_cubit.dart';
import '../../../../../../../generated/l10n.dart';
import '../../widget/list_header.dart';

class YourTrainers extends StatelessWidget {
  const YourTrainers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListHeader(
          headerTitle: S.of(context).privateSessions,
          seeAllFunction: () => startTrainersPage(),
        ),
        SizedBox(
          height: .3.sh,
          child: BlocBuilder<TrainersCubit, TrainersInitial>(
            builder: (context, state) {
              final list =
              state.result.where((e) => e.numberOfPrivateHours > 0).take(4).toList();
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () => startTrainerPage(context, list[i].id),
                    child: YourTrainersItem(trainer: list[i]),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}