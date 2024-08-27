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
import 'package:image_multi_type/image_multi_type.dart';
import 'package:image_multi_type/round_image_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/create_trainer_file_cubit/create_trainer_file_cubit.dart';
import '../../bloc/trainer_files_cubit/trainer_files_cubit.dart';
import '../widget/create_dialog.dart';

//TrainerFilesPage
class TrainerFilesPage extends StatelessWidget {
  const TrainerFilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).files),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NoteMessage.showMyDialog(
            context,
            child: BlocProvider.value(
              value: context.read<CreateTrainerFileCubit>()..reInit(),
              child: const CreateDialog(),
            ),
          );
        },
        child: const ImageMultiType(
          url: Icons.file_present_rounded,
          color: AppColorManager.whit,
        ),
      ),
      body: BlocBuilder<TrainerFilesCubit, TrainerFilesInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          return ListView.separated(
            padding: const EdgeInsets.all(20.0).r,
            itemCount: state.result.length,
            separatorBuilder: (context, i) =>
                i == state.result.length ? 0.0.verticalSpace : Divider(),
            itemBuilder: (context, i) {
              final item = state.result[i];
              return MyCardWidget(
                cardColor: AppColorManager.lightGray,
                padding: EdgeInsets.zero,
                child: ListTile(
                  onTap: () {
                    loggerObject.e(item.file);
                    switch (item.mediaType) {
                      case MediaType.pdf:
                        startPdf(item.file, item.content);
                        break;

                      case MediaType.image:
                        NoteMessage.showMyDialog(
                          context,
                          child: ImageMultiType(
                            height: .5.sh,
                            width: 1.0.sw,
                            url: item.file,
                          ),
                        );
                    }
                  },
                  title: DrawableText(text: item.content),
                  leading: RoundImageWidget(
                    url: item.mediaType == MediaType.pdf
                        ? Assets.imagesPdf
                        : Assets.imagesImageFile,
                    width: 50.0.r,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlocBuilder<DeleteTrainerFileCubit, DeleteTrainerFileInitial>(
                        buildWhen: (p, c) => c.request == item.id.toString(),
                        builder: (context, state) {
                          if (state.statuses.loading) {
                            return MyStyle.loadingWidget();
                          }
                          return IconButton(
                              onPressed: () {
                                NoteMessage.showCheckDialog(
                                  context,
                                  text: S.of(context).deleteFile,
                                  textButton: S.of(context).delete,
                                  image: Icons.delete,
                                  color: Colors.red,
                                  onConfirm: (b) {
                                    if (!b) return;
                                    context
                                        .read<DeleteTrainerFileCubit>()
                                        .deleteTrainerFile(id: item.id.toString());
                                  },
                                );
                              },
                              icon: ImageMultiType(
                                height: 24.0.r,
                                width: 24.0.r,
                                color: Colors.red,
                                url: Icons.delete,
                              ));
                        },
                      ),
                      ImageMultiType(
                        height: 17.0.r,
                        width: 17.0.r,
                        url: Icons.arrow_forward_ios,
                      ),
                    ],
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
