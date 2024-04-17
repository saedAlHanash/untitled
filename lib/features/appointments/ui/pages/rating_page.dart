import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/Utils/dependency_injection.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/models/booked_appointments.dart';
import 'package:fitness_storm/core/util/snack_bar_message.dart';
import 'package:fitness_storm/features/appointments/data/request/reating_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/rating_cubit/rating_cubit.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({super.key, required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    final margin = EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 15.0.h);
    final request = RatingRequest();
    return BlocListener<RatingCubit, RatingInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        NoteMessage.showSuccessSnackBar(message: S.of(context).done, context: context);
        Navigator.pop(context, true);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Get.theme.primaryColor,
              Get.theme.colorScheme.secondary,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<RatingCubit, RatingInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    text: S.of(context).rating,
                    onTap: () {
                      request.rating ??= 1;
                      request.review ??= 'Empty Review';
                      request.appointmentId = appointment.appointmentId;

                      context.read<RatingCubit>().rate(request: request);
                    },
                  );
                },
              ),
              20.0.verticalSpace,
            ],
          ),
          appBar: AppBarWidget(
              titleText:
                  '${S.of(context).rating} ${S.of(context).and} ${S.of(context).review}'),
          body: Center(
            child: MyCardWidget(
              elevation: 10.0,
              margin: margin,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  10.0.verticalSpace,
                  CircleImageWidget(url: appointment.user.image),
                  5.0.verticalSpace,
                  DrawableText(
                    text: appointment.user.name,
                    fontWeight: FontWeight.bold,
                    size: 18.0.sp,
                  ),
                  DrawableText(
                    text: '${S.of(context).session} ${S.of(context).date}: ',
                    drawablePadding: 5.0.w,
                    drawableEnd: DrawableText(
                      text: appointment.startTime.formatDateTime,
                      fontWeight: FontWeight.bold,
                      color: AppColorManager.mainColor,
                    ),
                  ),
                  30.0.verticalSpace,
                  RatingBarWidget(
                    onRatingUpdate: (p0) => request.rating = p0,
                  ),
                  30.0.verticalSpace,
                  MyEditTextWidget(
                    backgroundColor: Colors.white,
                    maxLines: 5,
                    innerPadding: const EdgeInsets.all(10.0).r,
                    hint: S.of(context).review,
                    onChanged: (val) => request.review = val,
                  ),
                  20.0.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RatingBarWidget extends StatelessWidget {
  const RatingBarWidget({Key? key, required this.onRatingUpdate}) : super(key: key);
  final Function(double) onRatingUpdate;

  @override
  Widget build(BuildContext context) {
    //region listener

    //endregion
    final startSize = 27.0.spMin;

    final emptyStar = ImageMultiType(
      url: Assets.imagesEmptyStar,
      height: startSize,
      width: startSize,
    );
    final fullStar = ImageMultiType(
      url: Assets.imagesFullStar,
      height: startSize,
      width: startSize,
    );

    return RatingBar(
      ratingWidget: RatingWidget(full: fullStar, half: fullStar, empty: emptyStar),
      onRatingUpdate: onRatingUpdate,
      glow: false,
      initialRating: 1.0,
      allowHalfRating: false,
      itemPadding: EdgeInsets.symmetric(horizontal: 5.0.w),
      minRating: 1.0,
    );
  }
}
