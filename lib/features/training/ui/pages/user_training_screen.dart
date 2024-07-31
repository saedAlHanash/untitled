import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/features/training/ui/widget/current_exercise_widget.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/User%20Training/Widget/exercises_listview.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/User%20Training/Widget/rest_widget.dart';
import 'package:fitness_storm/Widgets/vimeo_player.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/util/my_style.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../Screen/Trainee Screens/User Training/Widget/slide_widget.dart';
import '../../../../core/app/app_provider.dart';
import '../../bloc/temp_cubit/training_cubit.dart';

class UserTrainingScreen extends StatefulWidget {
  const UserTrainingScreen({super.key});

  @override
  State<UserTrainingScreen> createState() => _UserTrainingScreenState();
}

class _UserTrainingScreenState extends State<UserTrainingScreen> {
  TrainingCubit get cubit => context.read<TrainingCubit>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: cubit.canPop,
      onPopInvoked: (didPop) => cubit.onPop.call(didPop),
      child: Scaffold(
          appBar:
              AppBarWidget(title: BlocBuilder<TrainingCubit, TrainingInitial>(
            builder: (context, state) {
              return DrawableText(
                text: state.result.name,
                size: 24.0.spMin,
                color: Colors.white,
                fontFamily: FontManager.cairoBold.name,
              );
            },
          )),
          body: BlocBuilder<TrainingCubit, TrainingInitial>(
            builder: (context, state) {
              if (state.statuses.loading) {
                return MyStyle.loadingWidget();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: cubit.isZumba
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  VimeoPlayer(
                    key: UniqueKey(),
                    videoId: cubit.currentExercise.name,
                  ),
                  cubit.isZumba
                      ? 0.0.verticalSpace
                      : CurrentExerciseWidget(
                          color: Colors.white,
                          title: cubit.currentExercise.name,
                          isSecondsBased: cubit.currentExercise.secondBased,
                          reps: cubit.currentExercise.repetitions,
                          set: cubit.currentExercise.setCount,
                          notes: cubit.currentExercise.notes,
                        ),
                  cubit.isZumba ? 0.0.verticalSpace : ExerciseListView(),
                  (AppProvider.isTrainer)
                      ? 0.0.verticalSpace
                      : SizedBox(
                          height: Get.height / 8,
                        ),
                ],
              );
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: BlocBuilder<TrainingCubit, TrainingInitial>(
            builder: (context, state) {
              if (state.statuses.loading) {
                return MyStyle.loadingWidget();
              }
              return (cubit.complete)
                  ? Container(
                      color: Get.theme.colorScheme.secondary,
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'already_play'.tr,
                        style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        // textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                      ),
                    )
                  : cubit.isZumba || (AppProvider.isTrainer)
                      ? 0.0.verticalSpace
                      : cubit.isRest && cubit.startTime > 0
                          ? RestWidget(
                              seconds: (state.result.type == "Loop Exercise")
                                  ? cubit.startTime
                                  : 0,
                              isBreak: cubit.isBreak,
                            )
                          : SlidWidget(
                              repetationNumber: cubit.currentExercise
                                  .repetitions[cubit.currentSet - 1].count,
                              setNumber: cubit.currentSet,
                            );
            },
          )),
    );
  }
}
