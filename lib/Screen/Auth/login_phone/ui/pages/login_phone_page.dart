import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../../Widgets/language_board_widget.dart';
import '../../../../../common/assets.gen.dart';
import '../../../../../common/bottom_sheets.dart';

class LoginPhonePage extends StatelessWidget {
  const LoginPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        image: const DecorationImage(
          image: AssetImage('asset/Images/auth1.png'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      BottomSheets.languageBottomSheet(
                        const LanguageBoardWidget(fromAuthPage: true),
                      );
                    },
                    child: ImageMultiType(
                      url: Assets.images.language,
                      width: Get.width / 15,
                    ),
                  ),
                  Image.asset(
                    'asset/Images/white_logo.png',
                    width: Get.width / 4,
                  ),
                  const SizedBox(),
                ],
              ),
              SizedBox(height: Get.height / 20),
              Center(
                child: Text('sign_in'.tr,
                    style: const TextStyle(color: Colors.white, fontSize: 26)),
              ),
              SizedBox(height: Get.height / 50),
            ],
          ),
        ),
      ),
    );
  }
}

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
            initialValue: PhoneNumber(isoCode: 'EG', phoneNumber: initialValue),
          ),
        ),
      ],
    );
  }
}
