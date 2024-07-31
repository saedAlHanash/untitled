import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:image_multi_type/image_multi_type.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/l10n.dart';

import '../../../../generated/assets.dart';
import '../../bloc/create_trainer_file_cubit/create_trainer_file_cubit.dart';

class CreateDialog extends StatefulWidget {
  const CreateDialog({super.key});

  @override
  State<CreateDialog> createState() => _CreateDialogState();
}

class _CreateDialogState extends State<CreateDialog> {
  CreateTrainerFileCubit get cubit => context.read<CreateTrainerFileCubit>();

  void getFile() async {
    final pdfFile = await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf'],
      type: FileType.custom,
    );

    if (pdfFile != null && pdfFile.files.isNotEmpty) {
      File file = File(pdfFile.files.single.path!);

      var bytes = file.readAsBytesSync();
      cubit.setFile(bytes);
      setState(() {});
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateTrainerFileCubit, CreateTrainerFileInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) => Navigator.pop(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0).r,
        child: Column(
          children: [
            InkWell(
              onTap: () async => getFile(),
              child: ImageMultiType(
                url: cubit.state.mRequest.file == null
                    ? Assets.imagesCreateFile
                    : Assets.imagesPdfUploadsvg,
                height: 70.0.r,
                width: 70.0.r,
              ),
            ),
            5.0.verticalSpace,
            DrawableText(
              text: S.of(context).sendNewFile,
              fontFamily: FontManager.cairoBold.name,
              size: 20.0.sp,
            ),
            5.0.verticalSpace,
            DrawableText(
              text: S.of(context).pleaseFillInformation,
              maxLines: 3,
              textAlign: TextAlign.center,
              color: Colors.grey,
            ),
            20.0.verticalSpace,
            Form(
              child: MyEditTextWidget(
                innerPadding: const EdgeInsets.all(10.0).r,
                hint: S.of(context).description,
                maxLines: 3,
                color: AppColorManager.lightGray,
                controller: cubit.textController,
                onChanged: (p0) => setState(() {}),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: DrawableText(
                    text: S.of(context).dismiss,
                    color: Colors.grey,
                    fontFamily: FontManager.cairoBold.name,
                    size: 14.0.sp,
                  ),
                ),
                10.0.horizontalSpace,
                BlocBuilder<CreateTrainerFileCubit, CreateTrainerFileInitial>(
                  builder: (context, state) {
                    if (state.statuses.loading) {
                      return MyStyle.loadingWidget();
                    }
                    return TextButton(
                      onPressed: cubit.state.mRequest.file?.fileBytes == null
                          ? getFile
                          : cubit.onCreate,
                      child: DrawableText(
                        text: S.of(context).saveChange,
                        color: cubit.state.mRequest.file?.fileBytes == null
                            ? Colors.grey
                            : AppColorManager.mainColor,
                        fontFamily: FontManager.cairoBold.name,
                        size: 14.0.sp,
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
