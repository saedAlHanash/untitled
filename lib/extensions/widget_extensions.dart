import 'package:flutter/cupertino.dart';

extension CustomWidget on Widget {
  Widget onTap(VoidCallback onTap) {
    return GestureDetector(
      child: this,
      onTap: onTap,
    );
  }

  Widget padding(EdgeInsetsGeometry padding) {
    return Padding(
      child: this,
      padding: padding,
    );
  }
}
