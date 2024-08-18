import 'package:drawable_text/drawable_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';


import '../api_manager/enum_manager.dart';
import '../util/shared_preferences.dart';
import 'app_color_manager.dart';

class MyTextFormWidget extends StatefulWidget {
  const MyTextFormWidget({
    super.key,
    this.label = '',
    this.autofocus = false,
    this.hint = '',
    this.maxLines = 1,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.maxLength = 1000,
    this.onChanged,
    this.controller,
    this.keyBordType,
    this.innerPadding,
    this.enable,
    this.icon,
    this.color = AppColorManager.mainColor,
    this.textColor,
    this.initialValue,
    this.textDirection,
    this.validator,
    this.iconWidget,
    this.iconWidgetLift,
    this.onChangedFocus,
    this.disableAndKeepIcon,
    this.onTap,
  });

  final bool? enable;
  final bool autofocus;
  final String label;
  final String hint;
  final dynamic icon;
  final Widget? iconWidget;
  final Widget? iconWidgetLift;
  final Color color;
  final Color? textColor;
  final int maxLines;
  final bool? disableAndKeepIcon;
  final int maxLength;
  final bool obscureText;
  final TextAlign textAlign;
  final Function(String)? onChanged;
  final Function(bool)? onChangedFocus;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyBordType;
  final EdgeInsets? innerPadding;
  final String? initialValue;
  final TextDirection? textDirection;

  @override
  State<MyTextFormWidget> createState() => _MyTextFormWidgetState();
}

class _MyTextFormWidgetState extends State<MyTextFormWidget> {
  FocusNode? focusNode;

  @override
  void initState() {
    if (widget.onChangedFocus != null) {
      focusNode = FocusNode()
        ..addListener(() {
          widget.onChangedFocus!.call(focusNode!.hasFocus);
        });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final padding = widget.innerPadding ?? const EdgeInsets.symmetric(horizontal: 10.0).w;

    var obscureText = widget.obscureText;
    Widget? suffixIcon;
    VoidCallback? onChangeObscure;

    if (widget.iconWidget != null) {
      suffixIcon = widget.iconWidget!;
    } else if (widget.icon != null) {
      suffixIcon = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
        child: ImageMultiType(url: widget.icon!, height: 23.0.h, width: 40.0.w),
      );
    }

    if (obscureText) {
      suffixIcon = StatefulBuilder(builder: (context, state) {
        return IconButton(
            splashRadius: 0.01,
            onPressed: () {
              state(() => obscureText = !obscureText);
              if (onChangeObscure != null) onChangeObscure!();
            },
            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off));
      });
    }

    final border = UnderlineInputBorder(
      borderSide: BorderSide(
        color: widget.color,
        width: 1.0.sp,
      ),
    );

    final focusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: widget.color,
        width: 1.0.sp,
      ),
    );

    final errorBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColorManager.red,
        width: 1.0.sp,
      ),
    );

    final inputDecoration = InputDecoration(
      contentPadding: padding,
      errorBorder: errorBorder,
      border: border,
      focusedBorder: focusedBorder,
      enabledBorder: border,
      fillColor: AppColorManager.lightGray,
      label: DrawableText(
        text: widget.label,
        color: AppColorManager.gray,
        size: 14.0.sp,
      ),
      counter: const SizedBox(),
      alignLabelWithHint: true,
      hintText: widget.hint,
      hintTextDirection: widget.textDirection,
      hintStyle: TextStyle(

        fontFamily: FontManager.cairoSemiBold.name,
        color: widget.textColor ?? AppColorManager.gray,
      ),
      hintMaxLines: 1,
      labelStyle: TextStyle(color: widget.color),
      suffixIcon: widget.obscureText ? suffixIcon : widget.iconWidgetLift,
      prefixIcon: widget.obscureText ? null : suffixIcon,
    );

    final textStyle = TextStyle(
      fontFamily: FontManager.cairoSemiBold.name,
      fontSize: 16.0.sp,
      color: widget.textColor ?? AppColorManager.black,
    );

    return StatefulBuilder(builder: (context, state) {
      onChangeObscure = () => state(() {});
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0).h,
        child: TextFormField(
          autofocus: widget.autofocus,
          validator: widget.validator,
          decoration: inputDecoration,
          maxLines: widget.maxLines,
          readOnly: !(widget.enable ?? true),
          initialValue: widget.initialValue,
          obscureText: obscureText,
          textAlign: widget.textAlign,
          onChanged: widget.onChanged,
          style: textStyle,
          onTap: () => widget.onTap?.call(),
          textDirection: widget.textDirection,
          maxLength: widget.maxLength,
          controller: widget.controller,
          keyboardType: widget.keyBordType,
        ),
      );
    });
  }
}

class MyEditTextWidget extends StatelessWidget {
  const MyEditTextWidget({
    super.key,
    this.hint = '',
    this.maxLines = 1,
    this.textAlign,
    this.maxLength = 1000,
    this.onChanged,
    this.color,
    this.controller,
    this.keyBordType,
    this.innerPadding,
    this.backgroundColor,
    this.focusNode,
    this.obscureText = false,
    this.icon,
    this.enable,
    this.radios,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  final String hint;
  final int maxLines;
  final int maxLength;
  final bool obscureText;
  final bool? enable;
  final TextAlign? textAlign;
  final Function(String val)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyBordType;
  final EdgeInsets? innerPadding;
  final Color? backgroundColor;
  final Color? color;
  final Widget? icon;
  final FocusNode? focusNode;
  final double? radios;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    bool obscureText = this.obscureText;
    Widget? suffixIcon;
    late VoidCallback onChangeObscure;

    if (icon != null) suffixIcon = icon;

    if (obscureText) {
      suffixIcon = StatefulBuilder(builder: (context, state) {
        return InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              state(() => obscureText = !obscureText);
              onChangeObscure();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
              child: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                size: 20.0.sp,
              ),
            ));
      });
    }

    final border = OutlineInputBorder(
        borderSide: BorderSide(
          color: backgroundColor ?? AppColorManager.offWhit.withOpacity(0.27),
        ),
        borderRadius: BorderRadius.circular(radios ?? 10.0.r));

    final inputDecoration = InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontFamily: FontManager.cairoSemiBold.name,
        fontSize: 18.0.sp,
        color: color?.withOpacity(0.6) ?? AppColorManager.gray.withOpacity(0.6),
      ),
      contentPadding: EdgeInsets.zero,
      counter: const SizedBox(),
      enabledBorder: border,
      focusedErrorBorder: border,
      disabledBorder: border,
      focusedBorder: border,
      errorMaxLines: 0,
      constraints: BoxConstraints(maxWidth: .9.sw, minWidth: .3.sw),
      border: border,
      fillColor: backgroundColor ?? AppColorManager.offWhit.withOpacity(0.27),
      filled: true,
      enabled: enable ?? true,
      prefixIcon: suffixIcon ?? 0.0.verticalSpace,
      prefixIconConstraints: BoxConstraints(maxWidth: 80.0.sp, minHeight: 50.0.sp),
    );

    return StatefulBuilder(
      builder: (context, state) {
        onChangeObscure = () => state(() {});
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radios ?? 10.0.r),
          ),
          padding: innerPadding ?? const EdgeInsets.all(10.0).r,
          child: TextFormField(
            // onTap: () {
            //   if (controller != null) {
            //     if (controller!.selection ==
            //         TextSelection.fromPosition(
            //             TextPosition(offset: controller!.text.length - 1))) {
            //       state(() {
            //         controller!.selection = TextSelection.fromPosition(
            //             TextPosition(offset: controller!.text.length));
            //       });
            //     }
            //   }
            // },
            obscureText: obscureText,
            decoration: inputDecoration,
            maxLines: maxLines,
            textAlign: textAlign ?? TextAlign.start,
            onChanged: onChanged,
            style: TextStyle(
              fontFamily: FontManager.cairoBold.name,
              fontSize: 18.0.sp,
              color: color ?? Colors.black87,
            ),
            focusNode: focusNode,
            maxLength: maxLength,
            controller: controller,
            keyboardType: keyBordType,
            textInputAction: textInputAction,
            onFieldSubmitted: onFieldSubmitted,
          ),
        );
      },
    );
  }
}

class MyTextFormNoLabelWidget extends StatelessWidget {
  const MyTextFormNoLabelWidget({
    super.key,
    this.label = '',
    this.autofocus = false,
    this.hint = '',
    this.maxLines = 1,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.maxLength = 1000,
    this.onChanged,
    this.controller,
    this.keyBordType,
    this.innerPadding,
    this.enable,
    this.icon,
    this.color = Colors.black,
    this.initialValue,
    this.textDirection,
  });

  final bool? enable;
  final bool autofocus;
  final String label;
  final String hint;
  final dynamic icon;
  final Color color;
  final int maxLines;
  final int maxLength;
  final bool obscureText;
  final TextAlign textAlign;
  final Function(String val)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyBordType;
  final EdgeInsets? innerPadding;
  final String? initialValue;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawableText(
          text: label,
          matchParent: true,
          color: AppColorManager.black,
          padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
          size: 18.0.sp,
        ),
        3.0.verticalSpace,
        MyTextFormWidget(
          maxLines: maxLines,
          autofocus: autofocus,
          initialValue: initialValue,
          obscureText: obscureText,
          textAlign: textAlign,
          onChanged: onChanged,
          textDirection: textDirection,
          maxLength: maxLength,
          controller: controller,
          color: color,
          enable: enable,
          hint: hint,
          keyBordType: keyBordType,
          icon: icon,
          innerPadding: innerPadding,
          key: key,
        ),
        5.0.verticalSpace,
      ],
    );
  }
}

class RectCustomClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) => Rect.fromLTWH(3.w, 0, size.width - 6.w, size.height);

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => oldClipper != this;
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class MyTextFormOutLineWidget extends StatefulWidget {
  const MyTextFormOutLineWidget({
    super.key,
    this.label = '',
    this.hint = '',
    this.helperText = '',
    this.maxLines = 1,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.maxLength = 1000,
    this.onChanged,
    this.controller,
    this.keyBordType,
    this.innerPadding,
    this.enable,
    this.icon,
    this.color = Colors.black,
    this.initialValue,
    this.textDirection,
    this.validator,
    this.iconWidget,
    this.iconWidgetLift,
    this.onChangedFocus,
    this.onTap,
    this.autofillHints,
  });

  final bool? enable;
  final String label;
  final String hint;
  final String? helperText;
  final dynamic icon;
  final Widget? iconWidget;
  final Widget? iconWidgetLift;
  final Color color;
  final int maxLines;
  final int maxLength;
  final bool obscureText;
  final TextAlign textAlign;
  final Function(String)? onChanged;
  final Function(bool)? onChangedFocus;
  final Function()? onTap;

  final List<String>? autofillHints;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyBordType;
  final EdgeInsets? innerPadding;
  final String? initialValue;
  final TextDirection? textDirection;

  @override
  State<MyTextFormOutLineWidget> createState() => _MyTextFormOutLineWidgetState();
}

class _MyTextFormOutLineWidgetState extends State<MyTextFormOutLineWidget> {
  FocusNode? focusNode;

  @override
  void initState() {
    if (widget.onChangedFocus != null) {
      focusNode = FocusNode()
        ..addListener(() {
          widget.onChangedFocus!.call(focusNode!.hasFocus);
        });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final padding = widget.innerPadding ?? const EdgeInsets.symmetric(horizontal: 20.0).w;

    bool obscureText = widget.obscureText;
    Widget? suffixIcon;
    VoidCallback? onChangeObscure;

    if (widget.iconWidget != null) {
      suffixIcon = widget.iconWidget!;
    } else if (widget.icon != null) {
      suffixIcon = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
        child: ImageMultiType(url: widget.icon!, height: 23.0.h, width: 40.0.w),
      );
    }

    if (obscureText) {
      suffixIcon = StatefulBuilder(builder: (context, state) {
        return IconButton(
          splashRadius: 0.01,
          onPressed: () {
            state(() => obscureText = !obscureText);
            if (onChangeObscure != null) onChangeObscure!();
          },
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
        );
      });
    }

    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColorManager.offWhit,
        width: 0.0,
      ),
    );
    final errorBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColorManager.red,
        width: 2.0.sp,
      ),
    );

    final inputDecoration = InputDecoration(
      contentPadding: padding,
      errorBorder: errorBorder,
      border: border,
      errorStyle: TextStyle(
        fontSize: 14.0.sp,
        fontFamily: FontFamily.robotoBold.name,
      ),
      focusedBorder: border,
      enabledBorder: border,
      helperText: widget.helperText?.toUpperCase(),
      helperStyle: const TextStyle(color: Colors.grey),
      fillColor: AppColorManager.offWhit,
      counter: const SizedBox(),
      hintText: widget.hint,
      hintStyle: TextStyle(
        fontFamily: FontFamily.roboto.name,
        fontSize: 12.0.sp,
        color: const Color(0xffA0A0A0),
      ),
      alignLabelWithHint: true,
      filled: true,
      labelStyle: TextStyle(color: widget.color),
      suffixIcon: widget.obscureText ? suffixIcon : widget.iconWidgetLift,
      prefixIcon: widget.obscureText ? null : suffixIcon,
    );

    final textStyle = TextStyle(
      fontFamily: FontManager.cairoSemiBold.name,
      fontSize: 16.0.sp,
      color: AppColorManager.whit,
    );

    return StatefulBuilder(builder: (context, state) {
      onChangeObscure = () => state(() {});
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawableText(
            text: widget.label,
            padding: const EdgeInsets.symmetric(horizontal: 3.0).w,
            color: AppColorManager.whit,
            size: 14.0.sp,
          ),
          3.0.verticalSpace,
          TextFormField(
            autofillHints: widget.autofillHints,
            onTap: () => widget.onTap?.call(),
            validator: widget.validator,
            decoration: inputDecoration,
            cursorColor: Colors.white,
            maxLines: widget.maxLines,
            readOnly: !(widget.enable ?? true),
            initialValue: widget.initialValue,
            obscureText: obscureText,
            textAlign: widget.textAlign,
            onChanged: widget.onChanged,
            style: textStyle,
            focusNode: focusNode,
            textDirection: widget.textDirection,
            maxLength: widget.maxLength,
            controller: widget.controller,
            keyboardType: widget.keyBordType,
          ),
        ],
      );
    });
  }
}

class MyTextFormWhiteWidget extends StatelessWidget {
  const MyTextFormWhiteWidget({
        super.key,
    this.label = '',
    this.hint = '',
    this.maxLines = 1,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.maxLength = 1000,
    this.onChanged,
    this.controller,
    this.keyBordType,
    this.innerPadding,
    this.enable,
    this.icon,
    this.color,
    this.labelColor,
    this.initialValue,
    this.textDirection,
  }) ;
  final bool? enable;
  final String label;
  final String hint;
  final String? icon;
  final Color? color;
  final Color? labelColor;
  final int maxLines;
  final int maxLength;
  final bool obscureText;
  final TextAlign textAlign;
  final Function(String val)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyBordType;
  final EdgeInsets? innerPadding;
  final String? initialValue;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    final padding = innerPadding ?? const EdgeInsets.symmetric(horizontal: 10.0);

    bool obscureText = this.obscureText;
    Widget? suffixIcon;
    VoidCallback? onChangeObscure;

    if (icon != null) {
      suffixIcon = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ImageMultiType(url: icon!, height: 23.0, width: 40.0),
      );
    }

    if (obscureText) {
      suffixIcon = StatefulBuilder(builder: (context, state) {
        return IconButton(
            splashRadius: 0.01,
            onPressed: () {
              state(() => obscureText = !obscureText);
              if (onChangeObscure != null) onChangeObscure!();
            },
            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off));
      });
    }
    final border = OutlineInputBorder(
        borderSide: BorderSide(
          color: color ?? Colors.white,
        ),
        borderRadius: BorderRadius.circular(10.0));

    final inputDecoration = InputDecoration(
      contentPadding: padding,
      errorBorder: InputBorder.none,
      border: border,
      focusedErrorBorder: border,
      focusedBorder: border,
      enabledBorder: border,
      counter: const SizedBox(),
      alignLabelWithHint: true,
      labelStyle: TextStyle(color: color ?? Colors.white),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      enabled: enable ?? true,
    );

    final textStyle = TextStyle(
      fontFamily: FontManager.cairoBold.name,
      fontSize: 18.0,
      color: color ?? Colors.black,
    );

    return StatefulBuilder(builder: (context, state) {
      onChangeObscure = () => state(() {});
      return Column(
        children: [
          DrawableText(
            text: label,
            matchParent: true,
            color: labelColor ?? Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            size: 16.0,
          ),
          const SizedBox(height: 3.0),
          TextFormField(
            decoration: inputDecoration,
            maxLines: maxLines,
            initialValue: initialValue,
            obscureText: obscureText,
            textAlign: textAlign,
            onChanged: onChanged,
            style: textStyle,
            textDirection: textDirection,
            maxLength: maxLength,
            controller: controller,
            keyboardType: keyBordType,
          ),
          const SizedBox(height: 3.0),
        ],
      );
    });
  }
}
