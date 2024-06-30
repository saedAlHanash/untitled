import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../data/response/notifications_response.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
    required this.item,
  });

  final NotificationModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          horizontalTitleGap: 10.0.w,
          title: DrawableText(
            matchParent: true,
            text: item.body,
            color: Colors.black87,
            fontFamily: FontManager.cairoBold.name,
          ),
          leading: ImageMultiType(
            url: Icons.notifications,
            width: 25.0.r,
            color: AppColorManager.mainColor,
          ),
          subtitle: item.data != null
              ? Container(
                  decoration: BoxDecoration(
                      color: AppColorManager.mainColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.0.r)),
                  padding: const EdgeInsets.all(5.0).r,
                  child: DrawableText(
                    text: item.data!.date?.fixTimeZone.formatDateTime ?? '',
                    fontFamily: FontManager.cairoBold.name,
                    textAlign: TextAlign.center,
                    size: 14.0.sp,
                    color: AppColorManager.mainColor,
                  ),
                )
              : null,
          trailing: DrawableText(
            text: item.getCreatedAt,
            fontFamily: FontManager.cairoBold.name,
            color: Colors.grey,
            size: 11.0.sp,
          ),
        ),
        Divider(color: AppColorManager.cardColor, endIndent: 20.0.w, indent: 20.0.w),
      ],
    );
  }
}
