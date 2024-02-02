import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitness_storm/core/util/my_style.dart';

import '../../strings/app_color_manager.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    Key? key,
    this.titleText,
    this.elevation,
    this.zeroHeight,
    this.actions,
    this.title,
    this.color,
  }) : super(key: key);

  final String? titleText;
  final Widget? title;
  final Color? color;
  final bool? zeroHeight;
  final double? elevation;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color ?? AppColorManager.whit,
      surfaceTintColor: color ?? AppColorManager.whit,
      toolbarHeight: (zeroHeight ?? false) ? 0 : 80.0.h,
      // scrolledUnderElevation: 0,
      title: title ??
          DrawableText(
            text: titleText ?? '',
            size: 22.0.spMin,
            fontFamily: FontManager.cairo.name,
          ),
      leading: Navigator.canPop(context)
          ? BackBtnWidget(
              appBarColor: color ?? AppColorManager.whit,
            )
          : null,
      actions: actions,
      elevation: elevation ?? 0.0,
      shadowColor: AppColorManager.black.withOpacity(0.28),
      iconTheme: const IconThemeData(color: AppColorManager.mainColor),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(1.0.sw, (zeroHeight ?? false) ? 0 : 80.0.h);
}
