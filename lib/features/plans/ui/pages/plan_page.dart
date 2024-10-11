import 'dart:io';

import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/Widget/day_bar.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/Widget/trainer_bio.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/Widget/video_tail_widget.dart';
import 'package:fitness_storm/Widgets/custom_button.dart';
import 'package:fitness_storm/Widgets/read_more_text_widget.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:fitness_storm/core/util/my_style.dart';
import 'package:fitness_storm/core/util/shared_preferences.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:fitness_storm/features/vimeo/bloc/vimeo_cubit/vimeo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/circle_image_widget.dart';

import '../../../../Widgets/Exercise/day_widget.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/app/app_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../vimeo/ui/pages/vimeo_player.dart';
import '../../bloc/active_plans_cubit/active_plans_cubit.dart';
import '../../bloc/plan_cubit/plan_cubit.dart';
import '../../bloc/plan_workout_cubit/plan_workout_cubit.dart';
import '../../bloc/subscribe_plan_cubit/subscribe_plan_cubit.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  PlanCubit get cubit => context.read<PlanCubit>();

  var showIntro = true;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SubscribePlanCubit, SubscribePlanInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            ctx?.readOrNull<ActivePlansCubit>()?.getActivePlans(newData: true);
            setState(() {});
          },
        ),
        BlocListener<PlanCubit, PlanInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<VimeoCubit>().initial(vimeoId: state.result.introductionVideo);
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBarWidget(
          title: BlocBuilder<PlanCubit, PlanInitial>(
            builder: (context, state) {
              if (state.statuses.loading) {
                return 0.0.verticalSpace;
              }
              return DrawableText(
                text: state.result.name,
                size: 24.0.spMin,
                color: Colors.white,
                fontFamily: FontManager.bold.name,
              );
            },
          ),
        ),
        floatingActionButtonLocation: Platform.isIOS
            ? FloatingActionButtonLocation.centerDocked
            : FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BlocBuilder<SubscribePlanCubit, SubscribePlanInitial>(
          builder: (context, state) {
            if (state.statuses.loading) {
              return SizedBox(
                height: 30.0.r,
                width: 30.0.r,
                child: MyStyle.loadingWidget(color: AppColorManager.secondColor),
              );
            }
            return BlocBuilder<PlanCubit, PlanInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return SizedBox(
                    height: 30.0.r,
                    width: 30.0.r,
                    child: MyStyle.loadingWidget(color: AppColorManager.secondColor),
                  );
                }
                return (state.result.isActive ||
                        AppSharedPreference.getCurrentPlanId ==
                            state.result.id.toString() ||
                        AppProvider.isTrainer)
                    ? 0.0.verticalSpace
                    : CustomButton(
                        onTapFunction: () {
                          setState(() {
                            showIntro = false;
                            context.read<VimeoCubit>().state.controller?.dispose();
                          });

                          return context
                              .read<SubscribePlanCubit>()
                              .subscribe(planId: state.result.id);
                        },
                        buttonColor: AppColorManager.secondColor,
                        textColor: Colors.white,
                        padding: 0,
                        radius: 10,
                        fontSize: 16.0.sp,
                        height: Get.height / 15,
                        width: Get.width,
                        text: AppSharedPreference.getCurrentPlanId.isEmpty
                            ? 'subscribe'.tr
                            : 'start_within_plan'.tr);
              },
            );
          },
        ),
        body: BlocBuilder<PlanCubit, PlanInitial>(
          builder: (context, state) {
            if (state.statuses.loading) {
              return MyStyle.loadingWidget();
            }
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (showIntro) const VimeoPlayer(),
                  const VideoTailWidget(),
                  Column(
                    children: [
                      30.0.verticalSpace,
                      Text(
                        state.result.name,
                        style: const TextStyle(color: Color(0xFF565C63), fontSize: 26),
                      ),
                      30.0.verticalSpace,
                      ReadMoreTextWidget(text: state.result.description),
                      30.0.verticalSpace,
                      ListTile(
                        leading: CircleImageWidget(
                          url: state.result.trainer.image,
                          size: 70.0.r,
                        ),
                        title: DrawableText(text: state.result.trainer.name),
                      ),
                      30.0.verticalSpace,
                      TrainerBio(state.result.trainer.bio),
                    ],
                  ),
                  const DayBar(),
                  30.0.verticalSpace,
                  BlocBuilder<PlanWorkoutsCubit, PlanWorkoutsInitial>(
                    builder: (context, state) {
                      if (state.statuses.loading) {
                        return MyStyle.loadingWidget();
                      }
                      return ListView.builder(
                        key: UniqueKey(),
                        controller: ScrollController(),
                        shrinkWrap: true,
                        itemCount: state.result.length,
                        itemBuilder: (_, i) {
                          final item = state.result[i];
                          return GestureDetector(
                            onTap: () {
                              if (item.isRestDay) return;

                              if (!cubit.state.result.isCurrent) {
                                Fluttertoast.showToast(
                                  msg: S.of(context).needSubscribeToThisPlan,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  fontSize: 16.0.sp,
                                );
                                return;
                              }

                              setState(() {
                                showIntro = false;
                                context.read<VimeoCubit>().state.controller?.dispose();
                              });

                              cubit.startTraining(state.result[i], i);
                            },
                            child: DayWidget(
                              key: state.result[i].key,
                              item: item,
                              // type:item.type!
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
