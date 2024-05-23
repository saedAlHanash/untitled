import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:image_multi_type/round_image_widget.dart';

import '../../../../features/trainer/data/response/trainer.dart';
import '../../../../generated/l10n.dart';

class TrainerWidget extends StatelessWidget {
  const TrainerWidget({
    super.key,
    required this.trainer,
  });

  final TrainerModel trainer;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0).r,
      child: Row(
        children: [
          RoundImageWidget(
            url: trainer.image,
            height: 100.0.r,
            width: 100.0.r,
            radios: 15.0.r,
          ),
          10.0.horizontalSpace,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawableText(
                  matchParent: true,
                  text: trainer.name,
                  fontWeight: FontWeight.bold,
                ),
                5.0.verticalSpace,
                RatingBarIndicator(
                  itemCount: 5,
                  rating: trainer.rating.toDouble(),
                  itemSize: 20.0.r,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20.0.r,
                  ),
                ),
                5.0.verticalSpace,
                if (trainer.numberOfPrivateHours > 0)
                  DrawableText(
                    text: '+${trainer.numberOfPrivateHours} ${S.of(context).privateSessions}',
                  ),
              ],
            ),
          ),
          ImageMultiType(
            url: Icons.arrow_forward_ios,
            color: AppColorManager.gray,
            height: 15.0.r,
            width: 15.0.r,
          )
        ],
      ),
    );
  }
}
