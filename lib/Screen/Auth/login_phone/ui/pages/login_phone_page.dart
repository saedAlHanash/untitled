import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';


class MyPhoneForm extends StatelessWidget {
  const MyPhoneForm({
    Key? key,
    this.controller,
    this.onChange,
    this.enable,
    this.showNoChangeIcon,
    this.initialValue,
  }) : super(key: key);

  final TextEditingController? controller;
  final Function(PhoneNumber)? onChange;
  final bool? enable;
  final String? initialValue;
  final bool? showNoChangeIcon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              // border: Border.all(color: Get.theme.primaryColor),
              color: const Color(0xFF777988).withOpacity(0.39),
              borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: InternationalPhoneNumberInput(
            onInputChanged: onChange,
            autoFocus: true,
            spaceBetweenSelectorAndTextField: 0.0,
            autoValidateMode: AutovalidateMode.disabled,
            cursorColor: Colors.white,
            textStyle: const TextStyle(color: Colors.white),
            isEnabled: enable ?? true,
            inputDecoration: InputDecoration(
              hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF818D98)),
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
            selectorTextStyle: TextStyle(color: Colors.white),
            formatInput: false,
            initialValue: PhoneNumber(isoCode: 'SA', phoneNumber: initialValue),
          ),
        ),
      ],
    );
  }
}
