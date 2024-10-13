
import 'package:fitness_storm/features/trainer/data/response/trainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../generated/l10n.dart';
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

          ],
        ),
      ),
    );
  }
}
