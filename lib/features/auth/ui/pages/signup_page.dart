import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/util/my_style.dart';
import 'package:fitness_storm/core/widgets/my_button.dart';
import 'package:fitness_storm/core/widgets/my_text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../Widgets/language_board_widget.dart';
import '../../../../core/helper/launcher_helper.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/bottom_sheets.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/login_social_cubit/login_social_cubit.dart';
import '../../bloc/signup_cubit/signup_cubit.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late final SignupCubit signupCubit;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    signupCubit = context.read<SignupCubit>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageMultiType(
          url: Assets.imagesAuth1,
          height: 1.0.sh,
          fit: BoxFit.cover,
        ),
        Container(
          height: 1.0.sh,
          color: Colors.black.withOpacity(0.6),
        ),
        MultiBlocListener(
          listeners: [
            BlocListener<SignupCubit, SignupInitial>(
              listenWhen: (p, c) => c.statuses.done,
              listener: (context, state) {
                if (AppProvider.isConfirmed) {
                  startHome();
                } else {
                  startConfirmCodeAccount();
                }
              },
            ),
            BlocListener<LoginSocialCubit, LoginSocialInitial>(
              listenWhen: (p, c) => c.statuses.done,
              listener: (context, state) {
                startHome();
              },
            ),
          ],
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(30.0).r,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    30.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            BottomSheets.languageBottomSheet(
                              const LanguageBoardWidget(fromAuthPage: true),
                            );
                          },
                          child: ImageMultiType(
                            url: Assets.imagesLanguage,
                            width: 25.0.r,
                          ),
                        ),
                        ImageMultiType(
                          url: Assets.imagesWhiteLogo,
                          width: 85.0.w,
                        ),
                        0.0.verticalSpace,
                      ],
                    ),
                    30.0.verticalSpace,
                    DrawableText(
                      text: S.of(context).signUp,
                      size: 26.0.sp,
                      color: Colors.white,
                      fontFamily: FontFamily.robotoBold.name,
                    ),
                    15.0.verticalSpace,
                    MyTextFormOutLineWidget(
                      validator: (p0) => signupCubit.validateName,
                      label: S.of(context).name,
                      hint: S.of(context).enterYourName,
                      initialValue: signupCubit.state.request.name,
                      onChanged: (val) => signupCubit.setName = val,
                    ),
                    7.0.verticalSpace,
                    MyTextFormOutLineWidget(
                      validator: (p0) => signupCubit.validatePhoneOrEmail,
                      label: S.of(context).email,
                      hint: S.of(context).enterEmailAddress,
                      initialValue: signupCubit.state.request.phoneOrEmail,
                      keyBordType: TextInputType.emailAddress,
                      onChanged: (val) => signupCubit.setPhoneOrEmail = val,
                    ),
                    7.0.verticalSpace,
                    MyTextFormOutLineWidget(
                      validator: (p0) => signupCubit.validatePassword,
                      label: S.of(context).password,
                      hint: S.of(context).enterPassword,
                      obscureText: true,
                      initialValue: signupCubit.state.request.password,
                      onChanged: (val) => signupCubit.setPassword = val,
                    ),
                    7.0.verticalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DrawableText(
                          text: S.of(context).bySingingUpYouAreAgreeingToOur,
                          color: Colors.grey,
                          size: 12.0.sp,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                LauncherHelper.openPage(
                                  'https://www.fitnessstorm.org/TermsAndConditions',
                                );
                              },
                              child: DrawableText(
                                size: 12.0.sp,
                                text: S.of(context).termsOfConditions,
                                color: Colors.white,

                              ),
                            ),
                            DrawableText(
                              size: 12.0.sp,
                              text: S.of(context).and,
                              color: Colors.grey,
                            ),
                            TextButton(
                              onPressed: () {
                                LauncherHelper.openPage(
                                  'https://www.fitnessstorm.org/PrivacyPolicy',
                                );
                              },
                              child: DrawableText(
                                size: 12.0.sp,
                                text: S.of(context).privacyPolicy,
                                color: Colors.white,

                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    15.0.verticalSpace,
                    BlocBuilder<SignupCubit, SignupInitial>(
                      builder: (_, state) {
                        if (state.statuses.loading) {
                          return MyStyle.loadingWidget(color: Colors.white);
                        }
                        return MyButtonRound(
                          text: S.of(context).signUp,
                          color: AppColorManager.mainColorLight,
                          onTap: () {
                            if (!_formKey.currentState!.validate()) return;
                            signupCubit.signup();
                          },
                        );
                      },
                    ),
                    30.0.verticalSpace,

                    DrawableText(
                      text: S.of(context).alreadyAMember,
                      drawableAlin: DrawableAlin.between,
                      color: Colors.white,
                      drawableEnd: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: DrawableText(
                          fontFamily: FontManager.cairoBold.name,
                          color: Colors.white,
                          text: '${S.of(context).signIn}.',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
