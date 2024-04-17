import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bookmarked_screen_controller.dart';
import 'filter_button.dart';

class BookmarkFilterRow extends GetWidget<BookmarkedScreenController> {
  final int selectedIndex;

  const BookmarkFilterRow({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width / 23.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FilterButton(
            icon: 'asset/Images/search_bar.svg',
            text: 'SEARCH'.tr,
            index: 0,
            onTap: () => controller.searchBottomSheet(false),
          ),
          FilterButton(
            icon: 'asset/Images/filter.svg',
            text: 'filter'.tr,
            index: 1,
            onTap: () => controller.filterBottomSheet(),
          ),
          FilterButton(
            icon: 'asset/Images/sort.svg',
            text: 'sort'.tr,
            index: 2,
            onTap: () => controller.sortBottomSheet(),
          )
        ],
      ),
    );
  }
}
