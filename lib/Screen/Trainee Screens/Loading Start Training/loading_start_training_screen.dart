 

import 'package:fitness_storm/Screen/Trainee%20Screens/Loading%20Start%20Training/loading_start_training_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoadingStartTrainginScreen
    extends GetView<LoadingStartTrainingController> {
  const LoadingStartTrainginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   //log(controller.title);
    return Scaffold(
        body: Center(child: Lottie.asset('asset/Images/start1.json')));
  }
}
