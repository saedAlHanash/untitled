import 'package:fitness_storm/Utils/protact_screen_service.dart';
import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/util/my_style.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:fitness_storm/features/training/ui/widget/current_exercise_widget.dart';
import 'package:fitness_storm/features/vimeo/bloc/vimeo_cubit/vimeo_cubit.dart';
import 'package:fitness_storm/features/vimeo/ui/pages/vimeo_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../generated/l10n.dart';
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
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        context.read<VimeoCubit>().initial(vimeoId: cubit.currentExercise.video);
      },
      child: Scaffold(
        appBar: AppBarWidget(
          canPop: cubit.canPop,
          onPopInvoked: (didPop, result) {
            if (didPop) return;
            NoteMessage.showCheckDialog(
              context,
              text: S.of(context).didYouFinishYourTraining,
              textButton: S.of(context).done,
              textCancelButton: S.of(context).iLlComeBackLater,
              image: '',
              onConfirm: (b) {
                if (b) context.read<TrainingCubit>().completeDay();
                Navigator.pop(context);
              },
            );
          },
          titleText: context.watch<TrainingCubit>().state.result.name,
        ),
        body: BlocBuilder<TrainingCubit, TrainingInitial>(
          builder: (context, state) {
            if (state.loading) {
              return MyStyle.loadingWidget();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment:
                  cubit.isZumba ? MainAxisAlignment.center : MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                const VimeoPlayer(),
                if (!cubit.isZumba) ...[
                  CurrentExerciseWidget(
                    color: Colors.white,
                    title: cubit.currentExercise.name,
                    isSecondsBased: cubit.currentExercise.secondBased,
                    reps: cubit.currentExercise.repetitions,
                    set: cubit.currentExercise.setCount,
                    notes: cubit.currentExercise.notes,
                  ),
                  const ExerciseListView()
                ],
                0.2.sh.verticalSpace,
              ],
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _FAB(),
      ),
    );
  }
}

class _FAB extends StatefulWidget {
  const _FAB({super.key});

  @override
  State<_FAB> createState() => _FABState();
}

class _FABState extends State<_FAB> {
  TrainingCubit get cubit => context.read<TrainingCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainingCubit, TrainingInitial>(
      builder: (context, state) {
        return (state.statuses.loading)
            ? 0.0.verticalSpace
            : (cubit.complete)
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
                        : Builder(builder: (context) {
                            if (cubit.currentSet < 1 ||
                                cubit.currentExercise.repetitions.isEmpty) {
                              return 0.0.verticalSpace;
                            }
                            loggerObject.v(cubit.currentExercise.repetitions.length);
                            return BlocProvider.value(
                              value: context.read<VimeoCubit>(),
                              child: SlidWidget(
                                repetationNumber: cubit.currentExercise
                                    .repetitions[cubit.currentSet - 1].count,
                                setNumber: cubit.currentSet,
                              ),
                            );
                          });
      },
    );
  }
}
