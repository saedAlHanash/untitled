import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/widgets/my_button.dart';
import 'package:fitness_storm/core/widgets/my_text_form_widget.dart';
import 'package:fitness_storm/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../Widgets/language_board_widget.dart';
import '../../../../core/util/bottom_sheets.dart';
import '../../../../core/strings/enum_manager.dart';
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
          url: Assets.imagesAuth1,
          height: 1.0.sh,
          fit: BoxFit.cover,
        ),
        Container(
          height: 1.0.sh,
          color: Colors.black.withOpacity(0.6),
        ),
        BlocListener<ForgetPasswordCubit, ForgetPasswordInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            //loggerObject.w('message');
            startRestPass();
          },
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: MyStyle.pagePadding,
                child: Column(
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
                      text: S.of(context).forgetPassword,
                      size: 26.0.sp,
                      color: Colors.white,
                      fontFamily: FontFamily.robotoBold.name,
                    ),
                    40.0.verticalSpace,
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
                          color: AppColorManager.mainColorLight,
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
