import 'package:fitness_storm/Screen/Trainee%20Screens/Training/training_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class TraingingExercise extends GetWidget<TrainingController> {
  const TraingingExercise({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ScrollSnapList(
            listController: controller.scrollController,
            onItemFocus: controller.onItemFocused,
            itemSize: Get.width,
            shrinkWrap: true,
            itemCount: controller.exercises.length,
            scrollDirection: Axis.horizontal,
            dynamicItemSize: true,
            scrollPhysics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return SizedBox(
                width: Get.width,
                height: Get.height,
                // child:
                // PageWidget(
                //   videoId: controller.exercises[index].video!,
                //   sets: controller.exercises[index].setCount!,
                //   //TODO REPS
                // reps: controller.exercises[index].repetitionCount!,
                //   checks: controller.checkboxController[index],
                // ),
              );
            },
            // dynamicSizeEquation: customEquation, //optional
          ),
        ),
      ],
    );
  }
}
