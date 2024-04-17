import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTextFieldController extends GetxController {
  AppTextFieldController(bool isScure) {
    _obscureText.value = isScure;
  }

  final RxBool _obscureText = true.obs;

  final RxBool _valid = true.obs;

  get obscureText => _obscureText.value;

  get valid => _valid.value;

  get toggleObscureText => _obscureText.toggle();

  set valid(val) => _valid.value = val;
}

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextInputType keyboardType;
  final double height;
  final bool required;
  final bool withValidation;
  final bool readOnly;
  final double? width;
  final TextEditingController? textController;
  final String? invalidText;
  final int maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hint;
  final TextStyle? style;
  final BoxDecoration? decoration;
  final AppTextFieldController controller;
  final Function(String)? onChanged;
  final String? suffixText;
  final bool? isUnderline;
  final Function()? onTap;

  const CustomTextField(
    this.labelText, {
    Key? key,
    this.keyboardType = TextInputType.text,
    this.height = 60,
    this.required = false,
    this.withValidation = false,
    this.readOnly = false,
    this.isUnderline = false,
    this.textController,
    this.invalidText,
    this.maxLines = 1,
    this.prefixIcon,
    this.style,
    this.hint,
    this.decoration,
    this.suffixIcon,
    this.width,
    this.onChanged,
    this.suffixText,
    this.onTap,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      decoration: decoration ??
          BoxDecoration(
              // border: Border.all(color: Get.theme.primaryColor),
              color: const Color(0xFF777988).withOpacity(0.39),
              borderRadius: BorderRadius.circular(5)),
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      child: TextField(
        onChanged: onChanged,
        maxLines: maxLines,
        controller: textController,
        onSubmitted: (value) {
          if (!withValidation) return;
          if (value.isEmpty) return;
          if (keyboardType == TextInputType.visiblePassword) {
            if (GetUtils.isLengthLessThan(value, 8)) {
              controller.valid = false;
            } else {
              controller.valid = true;
            }
          } else if (keyboardType == TextInputType.emailAddress) {
            if (value.isEmail) {
              controller.valid = true;
            } else {
              controller.valid = false;
            }
          }
        },
        textInputAction: TextInputAction.next,
        style: style,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        obscureText: keyboardType == TextInputType.visiblePassword
            ? controller.obscureText
            : false,
        decoration: InputDecoration(
          floatingLabelStyle: style,
          hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF818D98)),
          // errorStyle: AppTextStyle.small_red,
          labelStyle: style,

          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          suffixText: suffixText,
          hintText: hint,

          contentPadding: const EdgeInsetsDirectional.only(
              start: 15, end: 12, top: 20, bottom: 10),
          enabledBorder: isUnderline!
              ? const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF5F5F5)))
              : OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
