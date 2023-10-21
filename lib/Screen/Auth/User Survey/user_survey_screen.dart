import 'package:fitness_storm/Screen/Auth/User%20Survey/Widget/survey_text_field.dart';
import 'package:fitness_storm/Screen/Auth/User%20Survey/user_survey_controller.dart';
import 'package:fitness_storm/Widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserSurveyScreen extends GetView<UserSurveyController> {
  const UserSurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'asset/Images/auth1.png',
          height: Get.height,
          fit: BoxFit.cover,
        ),
        Container(
          height: Get.height,
          color: Colors.black.withOpacity(0.6),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 20),
              width: Get.width,
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: Get.height / 40),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Get.height / 40),
                      child: Image.asset('asset/Images/white_logo.png',
                          width: Get.width / 4),
                    ),
                    // SizedBox(height: Get.height / 50),
                    Text(
                      'fitness_survey'.tr,
                      style: const TextStyle(fontSize: 26, color: Colors.white),
                    ),
                    SizedBox(height: Get.height / 50),
                    Text(
                      'take_this_survey'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    SizedBox(height: Get.height / 20),
                    Row(
                      children: [
                        Expanded(
                            child: SurveyTextField(
                                title: 'Weight',
                                hint: 'in_kg'.tr,
                                suffix: 'Kg',
                                textEditingController:
                                    controller.weightController.value)),
                        SizedBox(width: Get.width / 18.75),
                        Expanded(
                            child: SurveyTextField(
                                title: 'hight'.tr,
                                hint: 'in_cm'.tr,
                                suffix: 'Cm',
                                textEditingController:
                                    controller.hightController)),
                      ],
                    ),
                    SizedBox(height: Get.height / 40.6),
                    Text('how_often_do_you_exercise?'.tr,
                        style: const TextStyle(fontSize: 14, color: Colors.white)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: SurveyTextField(
                                title: '',
                                hint: 'days/week'.tr,
                                suffix: 'days/week'.tr,
                                textEditingController:
                                    controller.daysPerWeekController)),
                        SizedBox(width: Get.width / 18.75),
                        Expanded(
                            child: SurveyTextField(
                                title: '',
                                hint: 'Hours/Day'.tr,
                                suffix: 'Hours/Day'.tr,
                                textEditingController:
                                    controller.hoursPerDayController)),
                      ],
                    ),
                    SizedBox(height: Get.height / 20.3),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${'you_Prefer_to_workout_in'.tr}:',
                            style:
                                const TextStyle(fontSize: 14, color: Colors.white)),
                        Row(
                          children: [
                            Checkbox(
                              value: controller.isGym,
                              onChanged: (value) {
                                if (value!) {
                                  controller.workoutLocation = 'gym';
                                } else {
                                  controller.workoutLocation = '';
                                }
                                controller.isGym = value;
                                controller.isHome = false;
                              },
                              fillColor: MaterialStateProperty.all(
                                Get.theme.colorScheme.secondary,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              checkColor: Get.theme.colorScheme.secondary,
                            ),
                            Text(
                              'gym'.tr,
                              style:
                                  const TextStyle(color: Colors.white, fontSize: 12),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                               value: controller.isHome,
                               onChanged: (value) {
                                 if (value!) {
                                   controller.workoutLocation = 'home';
                                 } else {
                                   controller.workoutLocation = '';
                                 }
                                 controller.isHome = value;
                                 controller.isGym = false;
                               },
                               fillColor: MaterialStateProperty.all(
                                 Get.theme.colorScheme.secondary,
                               ),
                               shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(5)),
                               checkColor: Get.theme.colorScheme.secondary,
                             ),
                            Text(
                              'home'.tr,
                              style:
                                  const TextStyle(color: Colors.white, fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: Get.height / 20.3),
                    SizedBox(
                      width: Get.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('What\'s_your_training_level?'.tr,
                              style: const TextStyle(color: Colors.white)),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                     value: controller.isBeginner,
                                     onChanged: (value) {
                                       if (value!) {
                                         controller.trainingLevel = 'Beginner';
                                       } else {
                                         controller.trainingLevel = '';
                                       }
                                       controller.isBeginner = value;
                                       controller.isIntermediate = false;
                                       controller.isProfessional = false;
                                     },
                                     fillColor: MaterialStateProperty.all(
                                       Get.theme.colorScheme.secondary,
                                     ),
                                     shape: RoundedRectangleBorder(
                                         borderRadius:
                                             BorderRadius.circular(5)),
                                     checkColor:
                                         Get.theme.colorScheme.secondary,
                                   ),
                                  Text(
                                    'beginner'.tr,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: controller.isIntermediate,
                                    onChanged: (value) {
                                      if (value!) {
                                        controller.trainingLevel =
                                            'Intermediate';
                                      } else {
                                        controller.trainingLevel = '';
                                      }
                                      controller.isBeginner = false;
                                      controller.isIntermediate = value;
                                      controller.isProfessional = false;
                                    },
                                    fillColor: MaterialStateProperty.all(
                                      Get.theme.colorScheme.secondary,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5)),
                                    checkColor:
                                        Get.theme.colorScheme.secondary,
                                  ),
                                  const Text(
                                    'Intermediate',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: controller.isProfessional,
                                    onChanged: (value) {
                                      if (value!) {
                                        controller.trainingLevel = 'Advanced';
                                      } else {
                                        controller.trainingLevel = '';
                                      }
                                      controller.isBeginner = false;
                                      controller.isIntermediate = false;
                                      controller.isProfessional = value;
                                    },
                                    fillColor: MaterialStateProperty.all(
                                      Get.theme.colorScheme.secondary,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5)),
                                    checkColor:
                                        Get.theme.colorScheme.secondary,
                                  ),
                                  Text(
                                    'professional'.tr,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: Get.height / 20.3),
                    SizedBox(
                      width: Get.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('what_is_your_training_goal?'.tr,
                              style: const TextStyle(color: Colors.white)),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: controller.isLoseweight,
                                    onChanged: (value) {
                                      if (value!) {
                                        controller.trainingGoal =
                                            'Lose weight';
                                      } else {
                                        controller.trainingGoal = '';
                                      }
                                      controller.isLoseweight = value;
                                      controller.isBuildMuscle = false;
                                      controller.isStayFit = false;
                                    },
                                    fillColor: MaterialStateProperty.all(
                                      Get.theme.colorScheme.secondary,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5)),
                                    checkColor:
                                        Get.theme.colorScheme.secondary,
                                  ),
                                  Text(
                                    'lose_weight'.tr,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: controller.isBuildMuscle,
                                    onChanged: (value) {
                                      if (value!) {
                                        controller.trainingGoal =
                                            'Build muscle';
                                      } else {
                                        controller.trainingGoal = '';
                                      }
                                      controller.isLoseweight = false;
                                      controller.isBuildMuscle = value;
                                      controller.isStayFit = false;
                                    },
                                    fillColor: MaterialStateProperty.all(
                                      Get.theme.colorScheme.secondary,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5)),
                                    checkColor:
                                        Get.theme.colorScheme.secondary,
                                  ),
                                  Text(
                                    'build_muscle'.tr,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: controller.isStayFit,
                                    onChanged: (value) {
                                      if (value!) {
                                        controller.trainingGoal = 'Stay fit';
                                      } else {
                                        controller.trainingGoal = '';
                                      }
                                      controller.isLoseweight = false;
                                      controller.isBuildMuscle = false;
                                      controller.isStayFit = value;
                                    },
                                    activeColor:
                                        Get.theme.colorScheme.secondary,
                                    fillColor: MaterialStateProperty.all(
                                      Get.theme.colorScheme.secondary,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5)),
                                    checkColor:
                                        Get.theme.colorScheme.secondary,
                                  ),
                                  Text(
                                    'stay_fit'.tr,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: controller.isMale,
                                    onChanged: (value) {
                                      controller.isMale = value;
                                      controller.isFemale = false;
                                    },
                                    fillColor: MaterialStateProperty.all(
                                      Get.theme.colorScheme.secondary,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    checkColor: Get.theme.colorScheme.secondary,
                                  ),
                                  Text(
                                    'male'.tr,
                                    style: const TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: controller.isFemale,
                                    onChanged: (value) {
                                      controller.isFemale = value;
                                      controller.isMale = false;
                                    },
                                    fillColor: MaterialStateProperty.all(
                                      Get.theme.colorScheme.secondary,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    checkColor: Get.theme.colorScheme.secondary,
                                  ),
                                  Text(
                                    'female'.tr,
                                    style: const TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CustomButton(
                                  onTapFunction: () => controller.onSubmit(),
                                  text: 'continue'.tr,
                                  fontSize: 16,
                                  textColor: Colors.white,
                                  padding: 0,
                                ),
                              ),
                              // Expanded(
                              //   child: CustomButton(
                              //     onTapFunction: () => controller.onSkip(),
                              //     buttonColor: const Color(0xFFA0A0A0),
                              //     text: 'Skip for now',
                              //     fontSize: 16,
                              //     textColor: Colors.white,
                              //     padding: 0,
                              //   ),
                              // )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
