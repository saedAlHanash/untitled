import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'image_multi_type.dart';

class CircleImageWidget extends StatelessWidget {
  const CircleImageWidget({
    Key? key,
    this.size,
    required this.url,
    this.color,
    this.margin,
    this.padding,

  }) : super(key: key);

  final double? size;
  final String? url;

  final Color? color;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final imageRadios = size ?? 150.0;
    return Container(
      height: imageRadios,
      width: imageRadios,
      margin: margin,
      clipBehavior: Clip.hardEdge,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        shape: BoxShape.circle,
      ),
      child: ImageMultiType(
        url: url ?? '',

        fit: BoxFit.cover,
      ),
    );
  }
}
