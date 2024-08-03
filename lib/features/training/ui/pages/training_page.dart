import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/Utils/protact_screen_service.dart';
import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:fitness_storm/features/training/ui/widget/current_exercise_widget.dart';
import 'package:fitness_storm/features/vimeo/bloc/vimeo_cubit/vimeo_cubit.dart';

import 'package:fitness_storm/features/vimeo/ui/pages/vimeo_player.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/util/my_style.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../core/injection/injection_container.dart';
import '../../bloc/temp_cubit/training_cubit.dart';
import '../widget/exercises_listview.dart';
import '../widget/rest_widget.dart';
import '../widget/slide_widget.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key});

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  TrainingCubit get cubit => context.read<TrainingCubit>();

  @override
  void initState() {
    ProtectScreenService().startProtect(Get.context);
    super.initState();
  }

  @override
  void dispose() {
    ProtectScreenService().stopProtect();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TrainingCubit, TrainingInitial>(
      listener: (context, state) {
        context
            .read<VimeoCubit>()
            .initial(vimeoId: cubit.currentExercise.video);
      },
      child: BlocBuilder<TrainingCubit, TrainingInitial>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBarWidget(
                canPop: cubit.canPop,
                onPopInvoked: (didPop) => cubit.onPop.call(didPop),
                titleText: state.result.name,
              ),
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
                      // VimeoPlayer(
                      //   key: UniqueKey(),
                      //   videoId: cubit.currentExercise.video,
                      //   onInitController: (videoController) {},
                      // ),
                      FutureBuilder(
                        future:
                            Future.delayed(const Duration(seconds: 1), () => 0),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return VimeoPlayer(
                              key: UniqueKey(),
                              videoId: cubit.currentExercise.video,
                              onInitController: (videoController) {},
                            );
                          } else {
                            return MyStyle.loadingWidget();
                          }
                        },
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
                      cubit.isZumba
                          ? 0.0.verticalSpace
                          : const ExerciseListView(),
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
                                  seconds:
                                      (state.result.type == "Loop Exercise")
                                          ? cubit.startTime
                                          : 0,
                                  isBreak: cubit.isBreak,
                                )
                              : Builder(builder: (context) {
                                  loggerObject.w(cubit.currentSet);
                                  if (cubit.currentSet < 1 ||
                                      cubit.currentExercise.repetitions
                                          .isEmpty) {
                                    return 0.0.verticalSpace;
                                  }
                                  loggerObject.v(
                                      cubit.currentExercise.repetitions.length);
                                  return SlidWidget(
                                    repetationNumber: cubit
                                        .currentExercise
                                        .repetitions[cubit.currentSet - 1]
                                        .count,
                                    setNumber: cubit.currentSet,
                                  );
                                });
                },
              ));
        },
      ),
    );
  }
}
