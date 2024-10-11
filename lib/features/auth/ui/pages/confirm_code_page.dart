import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:fitness_storm/core/util/snack_bar_message.dart';
import 'package:fitness_storm/core/widgets/my_button.dart';
import 'package:fitness_storm/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/verification_code_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/confirm_code_cubit/confirm_code_cubit.dart';
import '../../bloc/resend_code_cubit/resend_code_cubit.dart';
import '../widget/auth_header.dart';

class ConfirmCodePage extends StatefulWidget {
  const ConfirmCodePage({super.key});

  @override
  State<ConfirmCodePage> createState() => _ConfirmCodePageState();
}

class _ConfirmCodePageState extends State<ConfirmCodePage> {
  late final ConfirmCodeCubit confirmCodeCubit;
  late final ResendCodeCubit resendCodeCubit;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    confirmCodeCubit = context.read<ConfirmCodeCubit>();
    resendCodeCubit = context.read<ResendCodeCubit>();
    confirmCodeCubit.setPhoneOrEmail = AppSharedPreference.getRestPassEmail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ConfirmCodeCubit, ConfirmCodeInitial>(
          listenWhen: (p, current) => current.done,
          listener: (context, state) => startHome(true),
        ),
        BlocListener<ResendCodeCubit, ResendCodeInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            NoteMessage.showAwesomeDoneDialog(context,
                message: S.of(context).doneResendCode);
          },
        ),
      ],
      child: Stack(
        children: [
          ImageMultiType(
            url: Assets.imagesIntro2,
            height: 1.0.sh,
            width: 1.0.sw,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          ImageMultiType(
            url: Assets.imagesIntro1Back,
            height: 1.0.sh,
            width: 1.0.sw,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: MyStyle.authPagesPadding,
                child: Column(
                  children: [
                    AuthHeader(
                        name:  S.of(context).emailVerification),
                    DrawableText(
                      text: S.of(context).sent6Digit,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    Form(
                      key: _formKey,
                      child: PinCodeWidget(
                        onChange: (p0) => confirmCodeCubit.setCode = p0,
                        validator: (p0) => confirmCodeCubit.validateCode,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(12.0.r)),
                      child: TextButton(
                        onPressed: () {
                          resendCodeCubit.resendCode();
                        },
                        child: BlocBuilder<ResendCodeCubit, ResendCodeInitial>(
                          builder: (context, state) {
                            if (state.statuses == CubitStatuses.loading) {
                              return MyStyle.loadingWidget();
                            }
                            return DrawableText(
                              color: Colors.white,
                              text: S.of(context).resendCode,
                              fontFamily: FontManager.bold.name,
                            );
                          },
                        ),
                      ),
                    ),
                    const Spacer(),
                    BlocBuilder<ConfirmCodeCubit, ConfirmCodeInitial>(
                      builder: (context, state) {
                        if (state.statuses.loading) {
                          return MyStyle.loadingWidget();
                        }
                        return MyButtonRound(
                          width: 150.0.w,
                          text: S.of(context).verify,
                          color: AppColorManager.secondColor,
                          onTap: () {
                            if (!_formKey.currentState!.validate()) return;
                            confirmCodeCubit.confirmCode();
                          },
                        );
                      },
                    ),
                    15.0.verticalSpace,
                    MyButtonRound(
                      width: 150.0.w,
                      text: S.of(context).changeEmail,
                      color: Colors.grey,
                      onTap: () {
                        startLogin();
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
