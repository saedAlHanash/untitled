import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../strings/app_color_manager.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    this.child,
    this.onTap,
    this.text = '',
    this.color,
    this.elevation,
    this.textColor,
    this.width,
    this.height,
    this.enable = true,
    this.toUpper = false,
    this.padding,
    this.radios,
  });

  final Widget? child;
  final String text;
  final Color? textColor;
  final Color? color;
  final double? elevation;
  final double? width;
  final double? height;
  final double? radios;
  final bool enable;
  final EdgeInsets? padding;
  final Function()? onTap;
  final bool toUpper;

  @override
  Widget build(BuildContext context) {
    final child = this.child ??
        DrawableText(
          text: toUpper ? text.toUpperCase() : text,
          color: textColor ?? AppColorManager.whit,
          fontFamily: FontManager.cairoBold.name,
          fontWeight: FontWeight.bold,
          size: 16.0.sp,
        );

    return SizedBox(
      width: width ?? .9.sw,
      height: height ?? 40.0.h,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(radios ?? 8.0.r),
              ),
            ),
          ),
          shadowColor: WidgetStatePropertyAll(const Color(0xFF4C2E84).withOpacity(0.2)),
          elevation: WidgetStatePropertyAll(elevation ?? 10.0.r),
          backgroundColor: WidgetStatePropertyAll(
              color ?? (enable ? AppColorManager.mainColor : Colors.grey)),
          padding: WidgetStatePropertyAll(
              padding ?? const EdgeInsets.symmetric(vertical: 0.0).r),
          alignment: Alignment.center,
        ),
        onPressed: !(enable ?? true) ? null : onTap,
        child: child,
      ),
    );
  }
}

class MyButtonOutLine extends StatelessWidget {
  const MyButtonOutLine({
    super.key,
    this.child,
    this.onTap,
    this.text = '',
    this.color,
    this.elevation,
    this.textColor,
    this.width,
    this.enable,
    this.toUpper = true,
    this.padding,
  });

  final Widget? child;
  final String text;
  final Color? textColor;
  final Color? color;
  final double? elevation;
  final double? width;
  final bool? enable;
  final EdgeInsets? padding;
  final Function()? onTap;
  final bool toUpper;

  @override
  Widget build(BuildContext context) {
    final child = this.child ??
        DrawableText(
          text: toUpper ? text.toUpperCase() : text,
          color: textColor ?? AppColorManager.mainColor,
          fontFamily: FontManager.cairoSemiBold.name,
          size: 14.0.sp,
        );

    return SizedBox(
      width: width ?? .9.sw,
      height: 45.0.h,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              side: BorderSide(color: color ?? AppColorManager.mainColor),
              borderRadius: BorderRadius.all(
                Radius.circular(15.0.r),
              ),
            ),
          ),

          elevation: const WidgetStatePropertyAll(0.0),
          backgroundColor: WidgetStatePropertyAll(color ?? AppColorManager.whit),
          // padding: MaterialStatePropertyAll(padding),
          padding: WidgetStatePropertyAll(const EdgeInsets.symmetric(vertical: 0.0).r),
          alignment: Alignment.center,
        ),
        onPressed: !(enable ?? true) ? null : onTap,
        child: child,
      ),
    );
  }
}

class MyButtonRound extends StatelessWidget {
  const MyButtonRound({
    super.key,
    this.child,
    this.onTap,
    this.text = '',
    this.color,
    this.elevation,
    this.textColor,
    this.width,
    this.withOpacity = true,
    this.toUpper = false,
    this.padding,
    this.enable = true,
  });

  final Widget? child;
  final String text;
  final Color? textColor;
  final Color? color;
  final double? elevation;
  final double? width;
  final bool withOpacity;
  final EdgeInsets? padding;
  final Function()? onTap;
  final bool toUpper;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    final child = this.child ??
        DrawableText(
          text: toUpper ? text.toUpperCase() : text,
          color: textColor ?? AppColorManager.whit,
          fontFamily: FontManager.cairoSemiBold.name,
        );

    return SizedBox(
      width: width ?? 150.0.w,
      height: 40.0.h,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(200.0.r),
              ),
            ),
          ),
          shadowColor: WidgetStatePropertyAll(const Color(0xFF4C2E84).withOpacity(0.2)),
          elevation: WidgetStatePropertyAll(enable ? elevation ?? 10.0.r : 0),
          backgroundColor: WidgetStatePropertyAll(
              enable ? color ?? AppColorManager.mainColor : AppColorManager.grey),
          // padding: MaterialStatePropertyAll(padding),
          padding: WidgetStatePropertyAll(const EdgeInsets.symmetric(vertical: 3.0).r),
          alignment: Alignment.center,
        ),
        onPressed: !enable ? null : onTap,
        child: child,
      ),
    );
  }
}
