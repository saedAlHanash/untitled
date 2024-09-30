import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:fitness_storm/core/util/shared_preferences.dart';
import 'package:fitness_storm/core/widgets/my_button.dart';
import 'package:fitness_storm/core/widgets/my_text_form_widget.dart';
import 'package:fitness_storm/features/auth/ui/widget/auth_header.dart';
import 'package:fitness_storm/features/auth/ui/widget/login_social_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/login_cubit/login_cubit.dart';
import '../../bloc/login_social_cubit/login_social_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginCubit get loginCubit => context.read<LoginCubit>();

  final _formKey = GlobalKey<FormState>();

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
            BlocListener<LoginCubit, LoginInitial>(
              listenWhen: (p, c) => c.statuses.done,
              listener: (context, state) {
                if (AppProvider.isConfirmed || AppProvider.isTrainer) {
                  startHome();
                } else {
                  startConfirmCodeAccount(context);
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
                    AuthHeader(name: S.of(context).login),
                    AutofillGroup(
                      child: Column(
                        children: [
                          MyTextFormOutLineWidget(
                            autofillHints: const [
                              AutofillHints.username,
                              AutofillHints.email,
                            ],
                            validator: (p0) => loginCubit.validatePhoneOrEmail,
                            label: S.of(context).email,
                            hint: S.of(context).enterEmailAddress,
                            initialValue: loginCubit.state.request.phoneOrEmail,
                            keyBordType: TextInputType.emailAddress,
                            onChanged: (val) => loginCubit.setPhoneOrEmail = val,
                          ),
                          10.0.verticalSpace,
                          MyTextFormOutLineWidget(
                            autofillHints: const [AutofillHints.password],
                            validator: (p0) => loginCubit.validatePassword,
                            label: S.of(context).password,
                            hint: S.of(context).enterPassword,
                            obscureText: true,
                            initialValue: loginCubit.state.request.password,
                            onChanged: (val) => loginCubit.setPassword = val,
                          ),
                        ],
                      ),
                    ),
                    const _ForgetAndRememberWidget(),
                    if (AppSharedPreference.getRestPassEmail.isNotEmpty)
                      MyButtonRound(
                        width: 1.0.sw,
                        onTap: () => startRestPass(),
                        text: S.of(context).continueRestPassword,
                      ),
                    if (AppSharedPreference.getRestPassEmail.isNotEmpty)
                      20.0.verticalSpace,
                    BlocBuilder<LoginCubit, LoginInitial>(
                      builder: (_, state) {
                        if (state.statuses.loading) {
                          return MyStyle.loadingWidget(color: Colors.white);
                        }
                        return MyButtonRound(
                          color: AppColorManager.mainColorLight,
                          text: S.of(context).signIn,
                          onTap: () {
                            if (!_formKey.currentState!.validate()) return;
                            TextInput.finishAutofillContext();
                            loginCubit.login();
                          },
                        );
                      },
                    ),
                    30.0.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: MyButton(
                            padding: EdgeInsets.zero,
                            height: 45.0.h,
                            radios: 12.0.r,
                            color: AppColorManager.priceColor,
                            text: S.of(context).guest,
                            onTap: () {
                              loginCubit.changeUserType = UserType.guest;
                              loginCubit.login();
                            },
                          ),
                        ),
                        30.0.horizontalSpace,
                        Expanded(
                          child: MyButton(
                            padding: EdgeInsets.zero,
                            height: 45.0.h,
                            radios: 12.0.r,
                            color: AppColorManager.mainColorDark,
                            text: S.of(context).applyAsTrainer,
                            onTap: () => startApply(),
                          ),
                        ),
                      ],
                    ),
                    30.0.verticalSpace,
                    SizedBox(
                      height: 50.0.r,
                      width: 50.0.r,
                      child: const LoginSocialWidget(),
                    ),
                    10.0.verticalSpace,
                    DrawableText(
                      text: S.of(context).notMember,
                      drawableAlin: DrawableAlin.between,
                      color: Colors.white,
                      drawableEnd: TextButton(
                        onPressed: () => startSignup(),
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
  LoginCubit get loginCubit => context.read<LoginCubit>();

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
                fillColor: WidgetStateProperty.all(Colors.white),
                checkColor: AppColorManager.mainColor,
                value: loginCubit.isTrainer,
                onChanged: (value) {
                  loginCubit.changeUserType =
                      (value == true) ? UserType.trainer : UserType.user;
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
          onPressed: () => startForgetPass(context),
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
