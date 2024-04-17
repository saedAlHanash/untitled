import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/util/snack_bar_message.dart';
import 'package:fitness_storm/core/widgets/my_button.dart';
import 'package:fitness_storm/core/widgets/my_text_form_widget.dart';
import 'package:fitness_storm/features/auth/ui/widget/auth_header.dart';
import 'package:fitness_storm/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/item_image_create.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/apply_cubit/apply_cubit.dart';

class ApplyPage extends StatefulWidget {
  const ApplyPage({super.key});

  @override
  State<ApplyPage> createState() => _ApplyPageState();
}

class _ApplyPageState extends State<ApplyPage> {
  final _formKey = GlobalKey<FormState>();

  late final ApplyCubit applyCubit;

  @override
  void initState() {
    applyCubit = context.read<ApplyCubit>();
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
            BlocListener<ApplyCubit, ApplyInitial>(
              listenWhen: (p, c) => c.statuses.done,
              listener: (context, state) {
                NoteMessage.showAwesomeDoneDialog(
                  context,
                  message: '${S.of(context).done} ${S.of(context).send} '
                      '${S.of(context).applyAsTrainer} ${S.of(context).request} ',
                  onCancel: () => Get.back(),
                );
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
                    AuthHeader(name: S.of(context).applyAsTrainer),
                    MyTextFormOutLineWidget(
                      validator: (p0) => applyCubit.validateName,
                      label: S.of(context).name,
                      hint: S.of(context).name,
                      initialValue: applyCubit.state.request.name,
                      keyBordType: TextInputType.name,
                      onChanged: (val) => applyCubit.setName = val,
                    ),
                    10.0.verticalSpace,
                    MyPhoneForm(
                      validator: (p0) => applyCubit.validatePhone,
                      label: S.of(context).phoneNumber,
                      hint: S.of(context).phoneNumber,
                      initialValue: applyCubit.state.request.phone,
                      onChange: (val) => applyCubit.setPhone = val.phoneNumber,
                    ),
                    20.0.verticalSpace,
                    BlocBuilder<ApplyCubit, ApplyInitial>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: ItemImageCreate(
                                size: 75.0.r,
                                name: S.of(context).cv,
                                image: state.request.cv.fileBytes ?? Assets.imagesCv,
                                onLoad: (bytes) {
                                  applyCubit.setCv = bytes;
                                },
                              ),
                            ),
                            15.0.horizontalSpace,
                            Expanded(
                              child: ItemImageCreate(
                                size: 75.0.r,
                                name: S.of(context).certificateOfGraduation,
                                image: state.request.certificateOfGraduation.fileBytes ??
                                    Assets.imagesCertificateO,
                                onLoad: (bytes) {
                                  applyCubit.setCertificateOfGraduation = bytes;
                                },
                              ),
                            ),
                            15.0.horizontalSpace,
                            Expanded(
                              child: ItemImageCreate(
                                size: 75.0.r,
                                name: S.of(context).certificateOfCourseAttended,
                                image:
                                    state.request.certificateOfCourseAttended.fileBytes ??
                                        Assets.imagesCertificateO,
                                onLoad: (bytes) {
                                  applyCubit.setCertificateOfCourseAttended = bytes;
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    50.0.verticalSpace,
                    BlocBuilder<ApplyCubit, ApplyInitial>(
                      builder: (_, state) {
                        if (state.statuses.loading) {
                          return MyStyle.loadingWidget(color: Colors.white);
                        }
                        return MyButtonRound(
                          color: AppColorManager.mainColorLight,
                          text: S.of(context).apply,
                          onTap: () {
                            if (!_formKey.currentState!.validate()) return;
                            if (!applyCubit.validateImages()) return;

                            applyCubit.sendRequest();
                          },
                        );
                      },
                    ),
                    10.0.verticalSpace,
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
