import 'dart:typed_data';

import 'package:flutter/material.dart';


import 'image_multi_type.dart';

class RoundImageWidget extends StatelessWidget {
  const RoundImageWidget({
    Key? key,
    required this.url,
    this.height,
    this.width,
    this.withFilter,
    this.fileBytes,
  }) : super(key: key);

  final String url;
  final double? height;
  final double? width;
  final bool? withFilter;
  final Uint8List? fileBytes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(12.0),
            child: ImageMultiType(
              url: url,
              height: height,
              fileBytes: fileBytes,
              width: width,
            ),
          ),

          // Container(
          //   height: height,
          //   width: width,
          //   clipBehavior: Clip.hardEdge,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(12.0.r),
          //     gradient: LinearGradient(
          //       begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //       colors: [
          //         Colors.black.withOpacity(0.01),
          //         Colors.black.withOpacity(0.01),
          //         Colors.black.withOpacity(0.1),
          //         Colors.black.withOpacity(0.2),
          //         Colors.black.withOpacity(0.4),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
