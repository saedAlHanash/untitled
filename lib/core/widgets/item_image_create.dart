import 'dart:typed_data';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/util/pick_image_helper.dart';

class ItemImageCreate extends StatelessWidget {
  const ItemImageCreate({
    super.key,
    required this.image,
    required this.onLoad,
    this.name,
    this.size,
  });

  final dynamic image;
  final String? name;
  final double? size;
  final Function(Uint8List bytes) onLoad;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0).w,
      child: InkWell(
        onTap: () async {
          final image = await PickImageHelper().pickImageBytes();
          if (image == null) return;
          onLoad.call(image);
        },
        child: Column(
          children: [
            SizedBox(
              height: size ?? 100.0.r,
              width: size ?? 100.0.r,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleImageWidget(
                    url: image,
                    size: size ?? 100.0.r,
                  ),
                  if (name == null)
                    const ImageMultiType(url: Icons.edit, color: Colors.white)
                ],
              ),
            ),
            10.0.verticalSpace,
            if (name != null)
              DrawableText(
                text: name!,
                matchParent: true,
                maxLines: 2,
                textAlign: TextAlign.center,
                size: 10.0.sp,
                color: Colors.white54,
                fontWeight: FontWeight.bold,
              )
          ],
        ),
      ),
    );
  }
}
