import 'package:fitness_storm/Widgets/plan_time_freqency.dart';
import 'package:fitness_storm/Widgets/see_all_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/models/plan_model.dart';
import 'bookmarked_screen_controller.dart';

class BookmarkedScreen extends GetView<BookmarkedScreenController> {
  const BookmarkedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('bookmarked_plans'.tr),
        titleTextStyle:
            const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        // centerTitle: true,
      ),
      body: Column(
        children: [
          // BookmarkFilterRow(selectedIndex: controller.selectedIndex),
          Obx(() => Expanded(child: _buildBookmarkPlansList(controller.plans))),
        ],
      ),
    );
  }

  Widget _buildBookmarkPlansList(List<PlanModel> plans) {
    return controller.isLoading
        ? const Center(child: CircularProgressIndicator.adaptive())
        : ListView.builder(
            shrinkWrap: true,
            itemCount: plans.length,
            itemBuilder: (context, index) {
              return SeeAllListItem(
                plan: controller.plans[index],
                index: index,
                isPressed: controller.addPlanToFavorite,
                subTitle: PlanTimeFrequency(
                  totalWeeks: plans[index].totalWeeks,
                  workoutFrequency: plans[index].workoutFrequency,
                  color: Colors.grey,
                ),
              );
            },
          );
  }
}
