import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class ReadMoreTextWidget extends StatelessWidget {
  final String text;

  const ReadMoreTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      style: const TextStyle(color: Color(0xFF565C63)),
      trimMode: TrimMode.Line,
      trimLines: 2,
      lessStyle: TextStyle(color: Theme.of(Get.context!).primaryColor),
      moreStyle: TextStyle(color: Theme.of(Get.context!).primaryColor),
    );
  }
}
