import 'package:awesome_icons/awesome_icons.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/FilterPage/Widget/filter_container.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/FilterPage/filter_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationFilter extends GetWidget<FilterPageController> {
  const LocationFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width / 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LOCATION'.tr,
            ),
            SizedBox(height: Get.height / 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => controller.toggleHome(),
                  child: FilterContainer(
                    check: controller.homeController,
                    widget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home_outlined, size: Get.width / 10),
                        const Text('Home')
                      ],
                    ),
                    width: Get.width / 2.5,
                    height: Get.height / 6,
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.toggleGym(),
                  child: FilterContainer(
                    check: controller.gymController,
                    widget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            FontAwesomeIcons.dumbbell,
                            size: Get.width / 10,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'gym'.tr,
                          ),
                        )
                      ],
                    ),
                    width: Get.width / 2.5,
                    height: Get.height / 6,
                  ),
                )
              ],
            ),
            SizedBox(height: Get.height / 30)
          ],
        ),
      ),
    );
  }
}
