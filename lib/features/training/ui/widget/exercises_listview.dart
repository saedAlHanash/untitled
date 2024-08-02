import 'package:fitness_storm/features/training/ui/widget/training_exercise_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/temp_cubit/training_cubit.dart';

class ExerciseListView extends StatefulWidget {
  const ExerciseListView({super.key});

  @override
  State<ExerciseListView> createState() => _ExerciseListViewState();
}

class _ExerciseListViewState extends State<ExerciseListView> {
  int i = -1;
  TrainingCubit get cubit => context.read<TrainingCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainingCubit, TrainingInitial>(
      builder: (context, state) {
        return Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: cubit.exercises.length,
            itemBuilder: (context, i) =>
                GestureDetector(
                  onTap: () async => await cubit.changeExercise(i),
                  child: GestureDetector(
                    onTap: () async => await cubit.changeExercise(i),
                    child: TrainingExerciseWidget(
                      isSecondsBased: cubit.exercises[i].secondBased,
                      reps: cubit.exercises[i].repetitions,
                      sets: cubit.exercises[i].setCount,
                      title: cubit.exercises[i].name,
                      isFinished: cubit.completedExercises[i] ||
                          i == cubit.currentIndex,
                      //i <= cubit.currentIndex,
                      isPlaying: i ==
                          (cubit.currentIndex < 0
                              ? 0
                              : cubit.currentIndex),
                    ),
                  ),
                ),
          ),
        );
      },
    );
  }
}
