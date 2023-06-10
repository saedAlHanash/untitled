import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomContainer extends StatefulWidget {
  final double width;
  int status;

  CustomContainer({Key? key, required this.status, required this.width})
      : super(key: key);

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: 3,
      color: getColor,
    );
  }

  Color get getColor {
    Color color;
    if (widget.status == 0) {
      color = Colors.grey;
    } else if (widget.status == 1) {
      color = const Color(0xFF715CA0);
    } else {
      color = const Color.fromARGB(255, 171, 146, 224);
    }
    return color;
  }
}
