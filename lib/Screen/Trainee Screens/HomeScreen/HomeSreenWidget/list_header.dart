import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ListHeader extends StatefulWidget {
  const ListHeader(
      {    super.key, required this.headerTitle, required this.seeAllFunction})
      ;

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
                child: Text(
                  'see_all'.tr,
                  style: TextStyle(color: Get.theme.primaryColor, fontSize: 14),
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

  Widget _buildHeaderTitleText({required String headerTitle}) {
    return Text(
      widget.headerTitle,
      style: TextStyle(
        color: Get.theme.primaryColor,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildHeaderTitleText(headerTitle: widget.headerTitle),
          _buildSeeAllButton()
        ],
      ),
    );
  }
}
