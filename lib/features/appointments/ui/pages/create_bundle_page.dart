import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:fitness_storm/core/widgets/my_card_widget.dart';
import 'package:fitness_storm/features/appointments/ui/widget/appointment_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../Screen/Trainee Screens/Subscription/subscription_controller.dart';
import '../../../../core/models/booked_appointments.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../custome_web_page_view.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/create_bundle_cubit/create_bundle_cubit.dart';

class CreateBundlePage extends StatefulWidget {
  const CreateBundlePage({super.key});

  @override
  State<CreateBundlePage> createState() => _CreateBundlePageState();
}

class _CreateBundlePageState extends State<CreateBundlePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateBundleCubit, CreateBundleInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        if (state.result.isEmpty) return;

        if (!Get.isRegistered<SubscruptionController>()) {
          Get.lazyPut(() => SubscruptionController());
        }

        Get.back();
        Get.back();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyCustomeWebPage(
              urlWebPage: state.result,
              subscruptionController: Get.find<SubscruptionController>(),
            ),
          ),
        );
      },
      child: Scaffold(
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<CreateBundleCubit, CreateBundleInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }
                if (!context.read<CreateBundleCubit>().isFull) return 0.0.verticalSpace;

                return MyButton(
                  width: 0.9.sw,
                  onTap: () => context.read<CreateBundleCubit>().createBundle(),
                  text: S.of(context).book,
                );
              },
            ),
            10.0.verticalSpace,
          ],
        ),
        appBar: AppBarWidget(
          titleText: S.of(context).availableSessions,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              10.0.verticalSpace,
              const _BundleSelectWidget(),
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

class _BundleSelectWidget extends StatelessWidget {
  const _BundleSelectWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateBundleCubit, CreateBundleInitial>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: state.request.timeIds.isEmpty ? 0 : 110.0.h,
              width: 1.0.sw,
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
                scrollDirection: Axis.horizontal,
                itemCount: state.request.timeIds.length,
                itemBuilder: (_, i) {
                  Appointment? item;
                  if (state.request.timeIds.length > i) {
                    item = state.request.timeIds[i];
                  }
                  return MyCardWidget(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0).r,
                    padding: const EdgeInsets.all(5.0).r,
                    child: SizedBox(
                      width: 100.0.r,
                      child: item == null
                          ? 0.0.verticalSpace
                          : Column(
                              children: [
                                DrawableText(
                                  size: 12.0.sp,
                                  matchParent: true,
                                  textAlign: TextAlign.center,
                                  text: item.startTime.formatDate,
                                  drawablePadding: 10.0.w,
                                  drawableStart: ImageMultiType(
                                    url: Icons.calendar_month_sharp,
                                    color: AppColorManager.black,
                                    width: 18.0.r,
                                  ),
                                ),
                                3.0.verticalSpace,
                                DrawableText(
                                  size: 12.0.sp,
                                  matchParent: true,
                                  text: item.startTime.formatTime,
                                  drawablePadding: 10.0.w,
                                  drawableStart: ImageMultiType(
                                    url: Icons.timer_outlined,
                                    color: AppColorManager.mainColor,
                                    width: 18.0.r,
                                  ),
                                ),
                                3.0.verticalSpace,
                                DrawableText(
                                  size: 12.0.sp,
                                  matchParent: true,
                                  text: item.endTime.formatTime,
                                  drawablePadding: 10.0.w,
                                  drawableStart: ImageMultiType(
                                    url: Icons.timer_off_outlined,
                                    color: AppColorManager.mainColorLight,
                                    width: 18.0.r,
                                  ),
                                ),
                                3.0.verticalSpace,
                                InkWell(
                                  onTap: () {
                                    context.read<CreateBundleCubit>().removeTime(item!);
                                  },
                                  child: const ImageMultiType(
                                    url: Icons.cancel,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  );
                },
              ),
            ),
            DrawableText(
              text: '${state.request.timeIds.length}/${state.bundle.sessions}',
              size: 24.0.sp,
            ),
          ],
        );
      },
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
    final cubit = context.watch<CreateBundleCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0).w,
      child: Column(
        children: [
          DrawableText(
            text: S.of(context).availableSessions,
          ),
          for (var e in widget.value)
            Builder(builder: (context) {
              final selectedItems = cubit.state.request.timeIds;

              final isItemSelected =
                  selectedItems.firstWhereOrNull((e1) => e.id == e1.id) != null;

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
                    MyButton(
                      width: 120.0.w,
                      height: 35.0.h,
                      onTap: () {
                        if (isItemSelected) {
                          cubit.removeTime(e);
                        } else {
                          cubit.selectTime(e);
                        }
                        setState(() {});
                      },
                      color: isItemSelected
                          ? Colors.red
                          : cubit.isFull
                              ? Colors.grey
                              : null,
                      child: DrawableText(
                        text: isItemSelected ? S.of(context).remove : S.of(context).add,
                        color: Colors.white,
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