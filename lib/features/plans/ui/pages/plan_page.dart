import 'dart:io';

import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/Widget/day_bar.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/Widget/trainer_bio.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/Widget/video_tail_widget.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/PlanOverView/plan_overview_controller.dart';
import 'package:fitness_storm/Widgets/custom_button.dart';
import 'package:fitness_storm/Widgets/read_more_text_widget.dart';
import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/util/my_style.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_multi_type/circle_image_widget.dart';

import '../../../../Widgets/Exercise/day_widget.dart';
import '../../../../Widgets/vimeo_player.dart';
import '../../../../core/app/app_provider.dart';
import '../../bloc/plan_cubit/plan_cubit.dart';
import '../../bloc/plan_workout_cubit/plan_workout_cubit.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  PlanCubit get cubit => context.read<PlanCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              fontFamily: FontManager.cairoBold.name,
            );
          },
        ),
      ),
      body: BlocBuilder<PlanCubit, PlanInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          loggerObject.w(state.result.introductionVideo);
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                VimeoPlayer(
                  videoId: state.result.introductionVideo,
                  onInitController: (videoController) {
                    cubit.setVideoController(videoController);
                  },
                ),
                const VideoTailWidget(),
                Column(
                  children: [
                    30.0.verticalSpace,
                    Text(
                      state.result.name,
                      style: const TextStyle(
                          color: Color(0xFF565C63), fontSize: 26),
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
                            cubit.state.videoController?.pause();
                            if (cubit.state.videoController?.isVideoPlaying ==
                                false) {
                              Future.delayed(
                                const Duration(seconds: 3),
                                () => cubit.state.videoController?.pause(),
                              );
                            }
                            item.name.toLowerCase() != 'Rest day'.toLowerCase()
                                ? cubit.startTraining(state.result[i],i)
                                : () {};
                          },
                          child: DayWidget(
                            key: state.result[i].key,
                            imageUrl: item.image,
                            dayNumber: item.name,
                            totalMinutes: item.totalMinutes.toInt(),
                            exercises: item.exercises,
                            type: item.type,

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
      floatingActionButtonLocation: Platform.isIOS
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.centerFloat,
      floatingActionButton: (AppProvider.isTrainer)
          ? null
          : cubit.state.result.isActive ||
                  GetStorage().read('currentPlan') == cubit.state.result.name
              ? null
              : CustomButton(
                  onTapFunction: cubit.subscribeToPlan,
                  buttonColor: Get.theme.primaryColor,
                  textColor: Colors.white,
                  padding: 0,
                  radius: 10,
                  fontSize: 16.0.sp,
                  height: Get.height / 15,
                  width: Get.width,
                  text: GetStorage().read('currentPlan') == null
                      ? 'subscribe'.tr
                      : 'start_within_plan'.tr),
    );
  }
}
