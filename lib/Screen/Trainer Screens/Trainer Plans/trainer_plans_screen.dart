import 'package:fitness_storm/features/bookmarked/ui/widget/see_all_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/not_found_widget.dart';
import '../../../generated/l10n.dart';
import '../Trainer HomeScreen/trainer_home_screen_controller.dart';

class TrainerPlansScreen extends GetView<TrainerHomeScreenController> {
  const TrainerPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('my_plans'.tr,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
        body: controller.isLoading.value
            ? const Center(child: CircularProgressIndicator.adaptive())
            : controller.trainerPlans.isEmpty
                ? NotFoundWidget(text: S.of(context).noPlansFound)
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.trainerPlans.length,
                    itemBuilder: (context, i) {
                      return SeeAllListItem(
                        plan: controller.trainerPlans[i],

                      );
                    },
                  ),
      ),
    );
  }
}
