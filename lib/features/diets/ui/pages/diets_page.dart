import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/api_manager/api_service.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/strings/enum_manager.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:fitness_storm/core/widgets/my_card_widget.dart';
import 'package:fitness_storm/features/trainer_files/bloc/delete_trainer_file_cubit/delete_trainer_file_cubit.dart';
import 'package:fitness_storm/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:image_multi_type/round_image_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/diets_cubit/diets_cubit.dart';

//DietsPage
class DietsPage extends StatelessWidget {
  const DietsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).files),
      body: BlocBuilder<DietsCubit, DietsInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          return ListView.separated(
            padding: const EdgeInsets.all(20.0).r,
            itemCount: state.result.length,
            separatorBuilder: (context, i) =>
                i == state.result.length ? 0.0.verticalSpace : const Divider(),
            itemBuilder: (context, i) {
              final item = state.result[i];
              return MyCardWidget(
                cardColor: AppColorManager.cardColor,
                elevation: 3.0,
                padding: EdgeInsets.zero,
                child: ListTile(
                  onTap: () {
                    if (!item.isActive) return;
                    startPdf(item.file, item.title);
                  },
                  title: DrawableText(text: item.title),
                  subtitle: DrawableText(
                    text: item.content,
                    color: Colors.grey,
                    size: 12.0.sp,
                  ),
                  leading: RoundImageWidget(
                    url: item.image,
                    width: 50.0.r,
                  ),
                  trailing: ImageMultiType(
                    height: 17.0.r,
                    width: 17.0.r,
                    url: item.isFree ? Icons.arrow_forward_ios : Icons.lock,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
