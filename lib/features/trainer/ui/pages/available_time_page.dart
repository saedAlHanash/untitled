import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:fitness_storm/features/appointments/bloc/available_times_cubit/available_times_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/models/booked_appointments.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../appointments/bloc/add_time_cubit/add_time_cubit.dart';
import '../../../appointments/bloc/remove_time_cubit/remove_time_cubit.dart';
import '../../../appointments/ui/widget/appointment_calendar.dart';

class AvailableTimePage extends StatefulWidget {
  const AvailableTimePage({super.key});

  @override
  State<AvailableTimePage> createState() => _AvailableTimePageState();
}

class _AvailableTimePageState extends State<AvailableTimePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddTimeCubit, AddTimeInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<AvailableTimesCubit>().getTrainerAvailableTimes();
          },
        ),
        BlocListener<RemoveTimeCubit, RemoveTimeInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<AvailableTimesCubit>().getTrainerAvailableTimes();
          },
        ),
      ],
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final request = context.read<AddTimeCubit>().state.request;
            final pick = await showDatePicker(
              context: context,
              initialDate: request,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().addFromNow(month: 10),
            );

            if (pick != null && context.mounted) {
              Navigator.of(context).push(
                showPicker(
                  context: context,
                  is24HrFormat: false,
                  themeData: ThemeData(backgroundColor: Colors.white),
                  cancelText: S.of(context).cancel,
                  okText: S.of(context).done,
                  value: Time(hour: request.hour, minute: request.minute),
                  onChange: (p0) {
                    final request = pick.copyWith(hour: p0.hour, minute: p0.minute);
                    context.read<AddTimeCubit>().addTime(request: request);
                  },
                ),
              );
            }
          },
          shape: const CircleBorder(),
          tooltip: S.of(context).add,
          child: BlocBuilder<AddTimeCubit, AddTimeInitial>(
            builder: (context, state) {
              if (state.statuses.loading) {
                return MyStyle.loadingWidget(color: Colors.white);
              }
              return const ImageMultiType(
                url: Icons.add,
              );
            },
          ),
        ),
        appBar: AppBarWidget(
          titleText: '${S.of(context).available} ${S.of(context).times}',
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              10.0.verticalSpace,
              AvailableTimesWidget(
                onSelectDate: (d) {
                  context.read<AddTimeCubit>().setDateTime(d);
                },
                doteColor: Colors.green,
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
            text: S.of(context).availableSession,
          ),
          for (var e in widget.value)
            Builder(builder: (context) {
              return MyCardWidget(
                margin: const EdgeInsets.all(10.0).r,
                elevation: 0,
                padding: const EdgeInsets.all(10.0).r,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          DrawableText(
                            matchParent: true,
                            text: e.startTime.formatTime,
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
                            text: e.endTime.formatTime,
                            drawablePadding: 10.0.w,
                            drawableStart: ImageMultiType(
                              url: Icons.timer_off_outlined,
                              color: AppColorManager.mainColorLight,
                              width: 18.0.r,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // BlocBuilder<RemoveTimeCubit, RemoveTimeInitial>(
                    //   buildWhen: (p, c) => c.id == e.id,
                    //   builder: (context, state) {
                    //     if (state.statuses.loading) {
                    //       return MyStyle.loadingWidget(color: Colors.white);
                    //     }
                    //     return InkWell(
                    //       onTap: () {
                    //         NoteMessage.showCheckDialog(
                    //           context,
                    //           text: '',
                    //           textButton: S.of(context).remove,
                    //           image: ImageMultiType(
                    //             url: Icons.delete,
                    //             color: Colors.red,
                    //             height: 60.0.r,
                    //             width: 60.0.r,
                    //           ),
                    //           onConfirm: () {
                    //             context.read<RemoveTimeCubit>().removeTime(id: e.id);
                    //           },
                    //         );
                    //       },
                    //       child: Container(
                    //         margin: const EdgeInsets.all(15.0).r,
                    //         padding: const EdgeInsets.all(3.0).r,
                    //         alignment: Alignment.center,
                    //         decoration: BoxDecoration(
                    //             color: AppColorManager.red.withOpacity(0.2),
                    //             borderRadius: BorderRadius.circular(10.0.r)),
                    //         height: 40.0.r,
                    //         width: 40.0.r,
                    //         child: Center(
                    //           child: ImageMultiType(
                    //             height: 25.0.r,
                    //             width: 25.0.r,
                    //             url: Icons.delete,
                    //             color: AppColorManager.red,
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}
