import 'package:fitness_storm/Screen/Trainee%20Screens/Training/training_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Widget/training_exercise.dart';

class TrainingScreen extends GetView<TrainingController> {
  const TrainingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: TraingingExercise(),
      ),
    );
  }
}
