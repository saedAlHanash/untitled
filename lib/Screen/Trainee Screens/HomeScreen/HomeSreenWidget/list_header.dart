import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ListHeader extends StatefulWidget {
  const ListHeader({super.key, required this.headerTitle, required this.seeAllFunction});

  final String headerTitle;
  final Function seeAllFunction;

  @override
  State<ListHeader> createState() => _ListHeaderState();
}

class _ListHeaderState extends State<ListHeader> {
  Widget _buildSeeAllButton() {
    return widget.headerTitle != 'Trending Plans'
        ? Row(
            children: [
              TextButton(
                onPressed: () => widget.seeAllFunction(),
                child: DrawableText(
                  text: 'see_all'.tr,
                  color: Get.theme.primaryColor,
                ),
              ),
              CircleAvatar(
                backgroundColor: Get.theme.primaryColor,
                radius: 7,
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 10,
                ),
              )
            ],
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DrawableText(
            text: widget.headerTitle,
            color: Get.theme.primaryColor,
            size: 18.sp,
            fontWeight: FontWeight.w500,
          ),
          _buildSeeAllButton()
        ],
      ),
    );
  }
}
