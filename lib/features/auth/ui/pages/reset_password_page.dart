import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/util/shared_preferences.dart';
import 'package:fitness_storm/core/widgets/my_button.dart';
import 'package:fitness_storm/core/widgets/my_text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../core/widgets/verification_code_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/reset_password_cubit/reset_password_cubit.dart';
import '../widget/auth_header.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late final ResetPasswordCubit resetPassCubit;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    resetPassCubit = context.read<ResetPasswordCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordInitial>(
      listenWhen: (p, c) => c.statuses == CubitStatuses.done,
      listener: (context, state) {
        NoteMessage.showSuccessSnackBar(message: S.of(context).done, context: context);
        startLogin();
      },
      child: Stack(
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
          SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: MyStyle.authPagesPadding,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AuthHeader(name: S.of(context).resetPassword),
                      40.0.verticalSpace,
                      PinCodeWidget(
                        onChange: (p0) => resetPassCubit.setCode = p0,
                        validator: (p0) => resetPassCubit.validateCode,
                      ),
                      30.0.verticalSpace,
                      MyTextFormOutLineWidget(
                        obscureText: true,
                        validator: (p0) => resetPassCubit.validatePassword,
                        label: S.of(context).newPassword,
                        initialValue: resetPassCubit.state.request.password,
                        keyBordType: TextInputType.emailAddress,
                        onChanged: (val) => resetPassCubit.setPassword = val,
                      ),
                      const Spacer(),
                      BlocBuilder<ResetPasswordCubit, ResetPasswordInitial>(
                        builder: (_, state) {
                          if (state.statuses.loading) {
                            return MyStyle.loadingWidget();
                          }
                          return MyButtonRound(
                            color: AppColorManager.mainColorLight,
                            text: S.of(context).reset,
                            onTap: () {
                              if (!_formKey.currentState!.validate()) return;
                              resetPassCubit.resetPassword();
                            },
                          );
                        },
                      ),
                      15.0.verticalSpace,
                      MyButtonRound(
                        color: AppColorManager.grey,
                        text: S.of(context).cancel,
                        onTap: () {
                          AppSharedPreference.cashRestPassEmail('');
                          startLogin();
                        },
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
