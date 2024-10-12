// import 'dart:async';
//
// import 'package:drawable_text/drawable_text.dart';import 'package:fitness_storm/core/strings/enum_manager.dart';
// import 'package:fitness_storm/Screen/video/video_call_widget.dart';
// import 'package:fitness_storm/core/strings/app_color_manager.dart';
// import 'package:fitness_storm/core/util/firebase_analytics_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:wakelock_plus/wakelock_plus.dart';
//
// import '../../Utils/protact_screen_service.dart';
// import '../../core/injection/injection_container.dart';
// import '../../core/models/booked_appointments.dart';
// import '../../generated/l10n.dart';
//
// class Video1 extends StatefulWidget {
//   const Video1({super.key, required this.appointment});
//
//   final Appointment appointment;
//
//   @override
//   State<Video1> createState() => _Video1State();
// }
//
// class _Video1State extends State<Video1> {
//     Timer? timer;
//   var showWarning = false;
//   var timeLift = 0;
//
//   void calculateTimeLeft(bool firstTime) {
//     final d = widget.appointment.endTime
//         .toUtc()
//         .difference(DateTime.now().toUtc()1);
//
//     if (d.inMinutes <= 10) {
//       setState(() {
//         timeLift = d.inMinutes;
//         showWarning = true;
//       });
//     }
//
//     if (d.inMinutes <= 0) {
//       if (firstTime) {
//         Navigator.pop(context);
//       } else {
//         Navigator.pop(context);
//       }
//     }
//   }
//
//   @override
//   void initState() {
//     // calculateTimeLeft(true);
//     //
//     // timer = Timer.periodic(
//     //     const Duration(minutes: 1), (v) => calculateTimeLeft(false));
//
//     WakelockPlus.enable();
//     ProtectScreenService().startProtect(Get.context);
//
//     sl<FirebaseAnalyticService>().contactTrainerOrUser(
//         name: widget.appointment.user.name, method: 'video_call');
//
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     WakelockPlus.disable();
//     timer?.cancel();
//     ProtectScreenService().stopProtect();
//     super.dispose();
//   }
//
//   // Create UI with local view and remote view
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Get.theme.primaryColor,
//         title: Text('private_sessions'.tr),
//         centerTitle: true,
//       ),
//       bottomNavigationBar: showWarning
//           ? Container(
//               height: 33.0.h,
//               width: 1.0.sw,
//               color: AppColorManager.ampere,
//               alignment: Alignment.center,
//               child: DrawableText(
//                 text: '${S.of(context).timeLeftToEndCall}'
//                     ' $timeLift ${S.of(context).minutes}',
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black,
//               ),
//             )
//           : null,
//       body: const VideoCallWidget(
//         token: '007eJxTYDA7Fzw1uP3a3aMT1LM0tWfe2Siw4SbPVE3eksal2XZc+2wVGFKMU40TUyyT0owSLUzMklKTTE0NkwwMjC3NLRONDE2MUt6FpjUEMjI8WbiViZEBAkF8FobixNQUBgYAJJQfGg==',
//         channel: 'saed',
//       ),
//     );
//   }
// }
//
//
// /*
//
// import 'package:flutter/material.dart';
//
// import '../../core/models/booked_appointments.dart';
//
// class Video1 extends StatelessWidget {
//   const Video1({super.key, required this.appointment});
//
//   final Appointment appointment;
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
// */
