import 'package:fitness_storm/Screen/Trainer%20Screens/Trainer%20Profile%20Overview/Widget/trainer_profile_overview_bio.dart';
import 'package:fitness_storm/features/trainer/data/response/trainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../trainer_files/bloc/trainer_files_cubit/trainer_files_cubit.dart';
import '../widget/trainer_profile_header.dart';

class ProfileTrainerPage extends StatefulWidget {
  const ProfileTrainerPage({super.key});

  @override
  State<ProfileTrainerPage> createState() => _ProfileTrainerPageState();
}

class _ProfileTrainerPageState extends State<ProfileTrainerPage> {
  final trainer = TrainerModel.fromProfile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        titleText: S.of(context).myProfile,
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            10.0.verticalSpace,
            const TrainerProfileHeader(),
            10.0.verticalSpace,
            TrainerProfileOverviewBio(trainer: trainer),
          ],
        ),
      ),
    );
  }
}
