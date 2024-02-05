import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:fitness_storm/core/widgets/my_button.dart';
import 'package:fitness_storm/core/widgets/my_text_form_widget.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../Utils/Routes/app_pages.dart';
import '../../../../Widgets/language_board_widget.dart';
import '../../../../common/bottom_sheets.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/login_cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginCubit loginCubit;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    loginCubit = context.read<LoginCubit>();

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
        BlocListener<LoginCubit, LoginInitial>(
          listenWhen: (p, c) => c.statuses == CubitStatuses.done,
          listener: (context, state) {
            Navigator.pushNamedAndRemoveUntil(context, RouteName.home, (route) => false);
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(30.0).r,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    50.verticalSpace,
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
                    50.0.verticalSpace,
                    DrawableText(
                      text: S.of(context).signIn,
                      size: 26.0.sp,
                      color: Colors.white,
                      fontFamily: FontFamily.robotoBold.name,
                    ),
                    40.0.verticalSpace,
                    MyTextFormOutLineWidget(
                      validator: (p0) => loginCubit.validatePhoneOrEmail,
                      label: S.of(context).email,
                      hint: S.of(context).enterEmailAddress,
                      initialValue: loginCubit.state.request.phoneOrEmail,
                      keyBordType: TextInputType.emailAddress,
                      onChanged: (val) => loginCubit.setPhoneOrEmail = val,
                    ),
                    10.0.verticalSpace,
                    MyTextFormOutLineWidget(
                      validator: (p0) => loginCubit.validatePassword,
                      label: S.of(context).password,
                      hint: S.of(context).enterPassword,
                      obscureText: true,
                      initialValue: loginCubit.state.request.password,
                      onChanged: (val) => loginCubit.setPassword = val,
                    ),
                    const _ForgetAndRememberWidget(),
                    60.0.verticalSpace,
                    BlocBuilder<LoginCubit, LoginInitial>(
                      builder: (_, state) {
                        if (state.statuses.loading) {
                          return MyStyle.loadingWidget(color: Colors.white);
                        }
                        return Column(
                          children: [
                            MyButtonRound(
                              color: AppColorManager.mainColorLight,
                              text: S.of(context).signIn,
                              onTap: () {
                                if (!_formKey.currentState!.validate()) return;
                                loginCubit.login();
                              },
                            ),
                            30.0.verticalSpace,
                            if (DateTime.now().isAfter(DateTime(2024, 1, 18)))
                              GestureDetector(
                                onTap: () {
                                  loginCubit.loginGoogle();
                                },
                                child: ImageMultiType(
                                  url: Assets.imagesGoogleSVG,
                                  width: 40.0.r,
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    10.0.verticalSpace,
                    DrawableText(
                      text: S.of(context).notMember,
                      drawableAlin: DrawableAlin.between,
                      color: Colors.white,
                      drawableEnd: TextButton(
                        onPressed: () => startSignup(context),
                        child: DrawableText(
                          fontFamily: FontManager.cairoBold.name,
                          color: Colors.white,
                          text: '${S.of(context).signUp}.',
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

class _ForgetAndRememberWidget extends StatefulWidget {
  const _ForgetAndRememberWidget();

  @override
  State<_ForgetAndRememberWidget> createState() => _ForgetAndRememberWidgetState();
}

class _ForgetAndRememberWidgetState extends State<_ForgetAndRememberWidget> {
  late final LoginCubit loginCubit;

  @override
  void initState() {
    loginCubit = context.read<LoginCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<LoginCubit, LoginInitial>(
            builder: (context, state) {
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                fillColor: MaterialStateProperty.all(Colors.white),
                checkColor: AppColorManager.mainColor,
                value: loginCubit.isTrainer,
                onChanged: (value) {
                  loginCubit.changeIsTrainer = value;
                },
                title: DrawableText(
                  text: S.of(context).signInTrainer,
                  color: Colors.white,
                  size: 12.0.sp,
                ),
              );
            },
          ),
        ),
        30.0.verticalSpace,
        TextButton(
          onPressed: () => Get.toNamed(AppRoutes.forgetPassword),
          child: DrawableText(
            text: S.of(context).forgetPassword,
            size: 12.0.sp,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
