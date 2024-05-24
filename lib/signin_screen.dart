
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'core/strings/app_color_manager.dart';
import 'core/strings/enum_manager.dart';

class MyPhoneForm extends StatelessWidget {
  const MyPhoneForm({
    super.key,
    this.controller,
    this.onChange,
    this.enable,
    this.showNoChangeIcon,
    this.initialValue,
    required this.label,
    required this.hint,
    this.validator,
  });

  final TextEditingController? controller;
  final Function(PhoneNumber)? onChange;
  final bool? enable;
  final String? initialValue;
  final bool? showNoChangeIcon;
  final String label;
  final String hint;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawableText(
          text: label,
          matchParent: true,
          padding: const EdgeInsets.symmetric(horizontal: 3.0).w,
          color: AppColorManager.whit,
          size: 14.0.sp,
        ),
        3.0.verticalSpace,
        Container(
          decoration: BoxDecoration(
            // border: Border.all(color: Get.theme.primaryColor),
            color: const Color(0xFF777988).withOpacity(0.39),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: InternationalPhoneNumberInput(
            onInputChanged: onChange,
            validator: validator,
            hintText: hint,
            spaceBetweenSelectorAndTextField: 0.0,
            cursorColor: Colors.white,
            textStyle: const TextStyle(color: Colors.white),
            isEnabled: enable ?? true,
            inputDecoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColorManager.red,
                  width: 2.0.sp,
                ),
              ),
              errorStyle: TextStyle(
                fontSize: 14.0.sp,
                fontFamily: FontFamily.robotoBold.name,
              ),
              hintStyle: TextStyle(
                fontFamily: FontFamily.roboto.name,
                fontSize: 12.0.sp,
                color: const Color(0xffA0A0A0),
              ),
              contentPadding: const EdgeInsetsDirectional.only(
                  start: 15, end: 12, top: 20, bottom: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
            ),
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.DIALOG,
            ),
            textFieldController: controller,
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
            selectorTextStyle: const TextStyle(color: Colors.white),
            formatInput: false,
            initialValue: PhoneNumber(isoCode: 'SA', phoneNumber: initialValue),
          ),
        ),
      ],
    );
  }
}
