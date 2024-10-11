import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:fitness_storm/core/widgets/my_button.dart';
import 'package:fitness_storm/core/widgets/my_text_form_widget.dart';
import 'package:fitness_storm/features/auth/ui/widget/auth_header.dart';
import 'package:fitness_storm/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../Widgets/language_board_widget.dart';
import '../../../../core/util/bottom_sheets.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/forget_password_cubit/forget_password_cubit.dart';

var otp = '';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late final ForgetPasswordCubit forgetPassCubit;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    forgetPassCubit = context.read<ForgetPasswordCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageMultiType(
          url: Assets.imagesIntro1,
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
        BlocListener<ForgetPasswordCubit, ForgetPasswordInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            startRestPass();
          },
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: MyStyle.pagePadding,
                child: Column(
                  children: [
                    AuthHeader(name: S.of(context).forgetPassword),
                    DrawableText(
                      text: S.of(context).plsEnterEmail,
                      size: 14.0.sp,
                      color: Colors.white,
                      padding: const EdgeInsets.only(left: 30.0).w,
                    ),
                    const Spacer(),
                    Form(
                      key: _formKey,
                      child: MyTextFormOutLineWidget(
                        textDirection: TextDirection.ltr,
                        validator: (p0) => forgetPassCubit.validatePhoneOrEmail,
                        keyBordType: TextInputType.emailAddress,
                        initialValue: forgetPassCubit.state.request.phoneOrEmail,
                        label: S.of(context).enterEmailAddress,
                        onChanged: (val) => forgetPassCubit.setPhoneOrEmail = val,
                      ),
                    ),
                    const Spacer(),
                    BlocBuilder<ForgetPasswordCubit, ForgetPasswordInitial>(
                      builder: (_, state) {
                        if (state.statuses == CubitStatuses.loading) {
                          return MyStyle.loadingWidget();
                        }
                        return MyButtonRound(
                          width: 150.0.w,
                          color: AppColorManager.secondColor,
                          text: S.of(context).reset,
                          onTap: () {
                            if (!_formKey.currentState!.validate()) return;
                            forgetPassCubit.forgetPassword();
                          },
                        );
                      },
                    ),
                    15.0.verticalSpace,
                    MyButtonRound(
                      color: Colors.grey,
                      width: 150.0.w,
                      text: S.of(context).cancel,
                      onTap: () {
                        Navigator.pop(context);
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
    );
  }
}
