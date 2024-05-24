import 'package:flutter/material.dart';

import '../strings/app_color_manager.dart';
import '../util/my_style.dart';

class MyCardWidget extends StatelessWidget {
  const MyCardWidget({
        super.key,
    this.margin,
    this.padding,
    this.cardColor = AppColorManager.cardColor,
    required this.child,
    this.elevation = 2,
    this.radios,
  }) ;

  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color cardColor;
  final Widget child;
  final double elevation;
  final double? radios;

  @override
  Widget build(BuildContext context) {
    var innerPadding = padding ?? MyStyle.cardPadding;

    //محتوى البطاقة
    final cardChild = Padding(padding: innerPadding, child: child);

    return Card(
      margin: margin,
      color: cardColor,
      clipBehavior: Clip.hardEdge,
      elevation: elevation,
      surfaceTintColor: cardColor,
      shadowColor: Colors.black.withOpacity(0.16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radios ?? MyStyle.cardRadios),
      ),
      child: cardChild,
    );
  }
}
