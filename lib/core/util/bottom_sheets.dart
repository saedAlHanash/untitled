import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheets {
  static bottomSheet(Widget child) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      ),
    );
  }

  static languageBottomSheet(Widget child) => bottomSheet(
        SizedBox(
          height: 150,
          child: child,
        ),
      );
}
