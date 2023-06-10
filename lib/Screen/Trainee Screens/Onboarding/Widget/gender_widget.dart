import 'package:flutter/material.dart';

class GenderWidget extends StatefulWidget {
  final String coloredImagePath;
  final String grayedImagePath;
  final String gender;
  final bool isTapped;

  const GenderWidget({
    Key? key,
    required this.coloredImagePath,
    required this.grayedImagePath,
    required this.gender,
    required this.isTapped,
  }) : super(key: key);

  @override
  State<GenderWidget> createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: Theme.of(context).primaryColor,
          backgroundImage: AssetImage(widget.isTapped
              ? widget.coloredImagePath
              : widget.grayedImagePath),
        ),
        const SizedBox(height: 20),
        Text(
          widget.gender,
          style: TextStyle(
              fontSize: 12,
              color: widget.isTapped ? Colors.white : Colors.grey),
        )
      ],
    );
  }
}
