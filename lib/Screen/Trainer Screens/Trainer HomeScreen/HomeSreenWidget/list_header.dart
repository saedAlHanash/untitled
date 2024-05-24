import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListHeader extends StatefulWidget {
  final String headerTitle;
  final Function seeAllFunction;

  const ListHeader(
      {    super.key, required this.headerTitle, required this.seeAllFunction})
      ;

  @override
  State<ListHeader> createState() => _ListHeaderState();
}

class _ListHeaderState extends State<ListHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildHeaderTitleText(headerTitle: widget.headerTitle),
          _buildSeeAllButton()
        ],
      ),
    );
  }

  Widget _buildSeeAllButton() {
    return Row(
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
    );
  }

  Widget _buildHeaderTitleText({required String headerTitle}) {
    return Text(
      widget.headerTitle,
      style: TextStyle(
        color: Get.theme.primaryColor,
        fontSize: 18,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
