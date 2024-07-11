import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final Function onTapFunction;
  final String text;
  final double? height;
  final double? width;
  final double? padding;
  final double? margin;
  final double? radius;
  final double? fontSize;
  final Color? buttonColor;
  final Color? textColor;

  const CustomButton({
        super.key,
    required this.onTapFunction,
    required this.text,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.radius,
    this.fontSize,
    this.buttonColor,
    this.textColor,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: padding ?? Get.height / 25),
      margin: EdgeInsets.all(margin ?? 10),
      child: ElevatedButton(
        onPressed: () => onTapFunction(),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
              buttonColor ?? Get.theme.colorScheme.secondary),
          elevation: WidgetStateProperty.all(10),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 18.0),
            ),
          ),
        ),
        child: Text(text,
            style: TextStyle(
                fontSize: fontSize ?? 25,
                color: textColor ?? Get.theme.colorScheme.secondary)),
      ),
    );
  }
}
