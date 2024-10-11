import 'dart:io';

import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../strings/app_color_manager.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    this.titleText,
    this.elevation,
    this.zeroHeight,
    this.leading,
    this.actions,
    this.title,
    this.color,
    this.canPop = true,
    this.onPopInvoked,
  });

  final String? titleText;
  final Widget? title;
  final Widget? leading;
  final Color? color;
  final bool? zeroHeight;
  final double? elevation;
  final List<Widget>? actions;
  final bool canPop;

  final Function(bool, dynamic result)? onPopInvoked;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: onPopInvoked,
      child: AppBar(
        backgroundColor: color ?? AppColorManager.mainColor,
        surfaceTintColor: color ?? AppColorManager.mainColor,
        toolbarHeight: (zeroHeight ?? false) ? 0 : 70.0.h,
        // scrolledUnderElevation: 0,
        title: title ??
            DrawableText(
              text: titleText ?? '',
              size: 24.0.spMin,
              color: Colors.white,
              fontFamily: FontManager.bold.name,
            ),
        leading: leading ??
            (Navigator.canPop(context)
                ? BackBtnWidget(
                    canPop: canPop,
                    onPopInvoked: onPopInvoked,
                    appBarColor: color ?? AppColorManager.mainColor,
                  )
                : null),
        centerTitle: true,
        actions: actions,
        elevation: elevation ?? 0.0,
        shadowColor: AppColorManager.black.withOpacity(0.28),
        iconTheme: const IconThemeData(color: AppColorManager.mainColor),
      ),
    );
  }

  @override
  Size get preferredSize => Size(1.0.sw, (zeroHeight ?? false) ? 0 : 70.0.h);
}

class BackBtnWidget extends StatelessWidget {
  const BackBtnWidget({
    super.key,
    required this.appBarColor,
    this.canPop = true,
    this.onPopInvoked,
  });

  final Color appBarColor;
  final bool canPop;

  final Function(bool, dynamic)? onPopInvoked;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (!canPop) {
          onPopInvoked?.call(false, null);
          return;
        }
        if (!Navigator.canPop(context)) return;
        Navigator.pop(context);
      },
      icon: Icon(
        Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
        color: isColorDark(appBarColor) ? Colors.white : AppColorManager.black,
      ),
    );
  }
}
