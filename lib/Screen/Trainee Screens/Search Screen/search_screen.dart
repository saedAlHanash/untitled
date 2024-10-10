import 'package:fitness_storm/Screen/Trainee%20Screens/Search%20Screen/Widget/term_and_condition_widget.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Search%20Screen/search_screen_controller.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../generated/assets.dart';
import 'Widget/search_bar_widget.dart';

class SearchScreen extends GetView<SearchScreenController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1.0.sh,
        width: 1.0.sw,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColorManager.mainColor,
              AppColorManager.secondColor,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            height: Get.height / 1.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Expanded(
                  child: Column(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 0.6.sw,
                          child: ImageMultiType(
                            url: Assets.imagesWhiteLogo,
                          ),
                        ),
                      ),
                      const SearchBarWidget()
                    ],
                  ),
                ),
                const TermAndConditionWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
