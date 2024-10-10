import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:fitness_storm/features/appointments/ui/widget/appointment_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../Screen/Trainee Screens/Subscription/subscription_controller.dart';
import '../../../../core/models/booked_appointments.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../custome_web_page_view.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/available_times_cubit/available_times_cubit.dart';
import '../../bloc/create_session_cubit/create_session_cubit.dart';

class BookPrivateSessionScreen extends StatefulWidget {
  const BookPrivateSessionScreen({super.key});

  @override
  State<BookPrivateSessionScreen> createState() => _BookPrivateSessionScreenState();
}

class _BookPrivateSessionScreenState extends State<BookPrivateSessionScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateSessionCubit, CreateSessionInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        if (state.result.isEmpty) return;

        if (!Get.isRegistered<SubscruptionController>()) {
          Get.lazyPut(() => SubscruptionController());
        }

        Get.back();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyCustomWebPage(
              urlWebPage: state.result,

            ),
          ),
        );
      },
      child: Scaffold(
        appBar: AppBarWidget(
          titleText: S.of(context).availableSessions,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100.0).h,
          child: BlocBuilder<AvailableTimesCubit, AvailableTimesInitial>(
            builder: (context, state) {
              return Column(
                children: [
                  10.0.verticalSpace,
                  CircleImageWidget(
                    url: state.trainer.image,
                    size: 80.0.r,
                  ),
                  DrawableText(
                    text: state.trainer.name,
                    fontFamily: FontManager.bold.name,
                    size: 18.0.sp,
                  ),
                  10.0.verticalSpace,
                  Text(
                    'CHOOSE_TIME'.tr,
                    style: const TextStyle(color: Color(0xFF565C63), fontSize: 14),
                  ),
                  AvailableTimesWidget(
                    builder: (_, value, __) => _AvailableTimeItem(value: value),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _AvailableTimeItem extends StatelessWidget {
  const _AvailableTimeItem({required this.value});

  final List<Appointment> value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0).w,
      child: Column(
        children: [
          DrawableText(
            text: S.of(context).availableSessions,
          ),
          for (var e in value)
            MyCardWidget(
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
                            color: AppColorManager.secondColor,
                            width: 18.0.r,
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<CreateSessionCubit, CreateSessionInitial>(
                    buildWhen: (p, c) => c.id == e.id,
                    builder: (context, state) {
                      if (state.statuses.loading) {
                        return MyStyle.loadingWidget();
                      }
                      return MyButton(
                        onTap: () {
                          context.read<CreateSessionCubit>().createSession(id: e.id);
                        },
                        width: 120.0.w,
                        height: 35.0.h,
                        child: DrawableText(
                          text: S.of(context).book,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
