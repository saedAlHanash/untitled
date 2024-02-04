import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../Model/trainer.dart';
import '../../bloc/booked_appointments_cubit/booked_appointments_cubit.dart';

class AppointmentsButtons extends StatefulWidget {
  const AppointmentsButtons({super.key, required this.trainer});

  final TrainerModel trainer;

  @override
  State<AppointmentsButtons> createState() => _ChatAndVideoButtonWidgetState();
}

class _ChatAndVideoButtonWidgetState extends State<AppointmentsButtons> {
  late final BookedAppointmentsCubit controllerCubit;

  @override
  void initState() {
    controllerCubit = context.read<BookedAppointmentsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookedAppointmentsCubit, BookedAppointmentsInitial>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: MyButtonRound(
                color: AppColorManager.mainColor,
                child: DrawableText(text: ''),
                onTap: () {},
              ),
            ),
            15.0.horizontalSpace,
            Expanded(
              child: MyButtonRound(
                color: AppColorManager.mainColorLight,
                child: DrawableText(text: ''),
                onTap: () {},
              ),
            ),
          ],
        );
      },
    );
  }
}
