import 'package:fitness_storm/core/app/app_provider.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../bloc/login_social_cubit/login_social_cubit.dart';

class LoginSocialWidget extends StatelessWidget {
  const LoginSocialWidget({super.key});

  @override
  Widget build(BuildContext context) {

    if (AppControl.hideGoogleBtn) return 0.0.verticalSpace;

    return BlocBuilder<LoginSocialCubit, LoginSocialInitial>(
      builder: (context, state) {
        if (state.statuses.loading) {
          return MyStyle.loadingWidget();
        }
        return InkWell(
          onTap: () => context.read<LoginSocialCubit>().loginGoogle(),
          child: ImageMultiType(
            url: Assets.imagesGoogleSVG,
            width: 40.0.r,
          ),
        );
      },
    );
  }
}
