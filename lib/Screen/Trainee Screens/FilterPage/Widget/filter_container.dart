import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterContainer extends StatelessWidget {
  const FilterContainer({
    Key? key,
    required this.widget,
    required this.width,
    required this.height,
    required this.check,
  }) : super(key: key);

  final bool check;
  final double height;
  final Widget widget;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: check ? Get.theme.primaryColor : Colors.transparent),
              color: check ? Colors.grey[700] : Colors.grey[900]),
          child: widget,
        ),
        check
            ? Positioned(
                top: 3,
                right: 3,
                child: Icon(
                  Icons.check,
                  color: Colors.green,
                  size: Get.width / 30,
                ))
            : Container(),
      ],
    );
  }
}
