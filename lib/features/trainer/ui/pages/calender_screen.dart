import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/models/booked_appointments.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../appointments/bloc/available_times_cubit/available_times_cubit.dart';
import '../../../appointments/ui/widget/appointment_calendar.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAvailableTimePage(),
        shape: const CircleBorder(),
        tooltip: S.of(context).settings,
        child: const ImageMultiType(
          url: Icons.settings,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<AvailableTimesCubit>().getTrainerAvailableTimes();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              10.0.verticalSpace,
              AvailableTimesWidget(
                builder: (__, value, _) => _ItemAvailableTime(value: value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemAvailableTime extends StatefulWidget {
  const _ItemAvailableTime({required this.value});

  final List<Appointment> value;

  @override
  State<_ItemAvailableTime> createState() => _ItemAvailableTimeState();
}

class _ItemAvailableTimeState extends State<_ItemAvailableTime> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0).w,
      child: Column(
        children: [
          DrawableText(
            text: S.of(context).nextSession,
          ),
          for (var e in widget.value)
            Builder(builder: (context) {
              return MyCardWidget(
                margin: const EdgeInsets.all(10.0).r,
                elevation: 0,
                cardColor: e.isExpired
                    ? AppColorManager.red.withOpacity(0.1)
                    : e.isNow
                        ? Colors.green.withOpacity(0.2)
                        : AppColorManager.cardColor,
                padding: const EdgeInsets.all(10.0).r,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          DrawableText(
                            matchParent: true,
                            text: e.user.name,
                            drawablePadding: 10.0.w,
                            drawableStart: ImageMultiType(
                              url: Icons.person,
                              color: Colors.black54,
                              width: 18.0.r,
                            ),
                          ),
                          3.0.verticalSpace,
                          DrawableText(
                            matchParent: true,
                            text: e.startTimeFixed.formatDateTime,
                            drawablePadding: 10.0.w,
                            drawableStart: ImageMultiType(
                              url: Icons.timer_outlined,
                              color: AppColorManager.mainColor,
                              width: 18.0.r,
                            ),
                          ),
                          3.0.verticalSpace,
                          DrawableText(
                            matchParent: true,
                            text: e.endTimeFixed.formatDateTime,
                            drawablePadding: 10.0.w,
                            drawableStart: ImageMultiType(
                              url: Icons.timer_off_outlined,
                              color: AppColorManager.secondColor,
                              width: 18.0.r,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (e.isNow)
                      InkWell(
                        onTap: () {
                          if (e.videoCallToken.isEmpty) {
                            context
                                .read<AvailableTimesCubit>()
                                .getTrainerAvailableTimes();
                            return;
                          }
                          startVideoCall(e);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(15.0).r,
                          padding: const EdgeInsets.all(10.0).r,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color:
                                  AppColorManager.mainColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10.0.r)),
                          height: 60.0.r,
                          width: 60.0.r,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              const ImageMultiType(
                                url: Assets.imagesVCall,
                                color: AppColorManager.mainColor,
                              ),
                              Container(
                                height: 5.0.r,
                                width: 5.0.r,
                                decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle),
                              )
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}
