import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:fitness_storm/features/home/ui/widget/app_bar_home.dart';
import 'package:fitness_storm/features/trainer/ui/widget/your_trainer_item.dart';
import 'package:fitness_storm/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../../../../features/trainer/bloc/trainers_cubit/trainers_cubit.dart';
import '../../../../../../../generated/l10n.dart';
import '../../../../../Utils/Routes/app_pages.dart';
import '../../../../../core/strings/app_color_manager.dart';
import '../../../../plans/bloc/active_plans_cubit/active_plans_cubit.dart';
import '../../../../plans/bloc/plans_cubit/plans_cubit.dart';
import '../../../../plans/bloc/free_plans_cubit/free_plans_cubit.dart';
import 'paid_plans.dart';

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