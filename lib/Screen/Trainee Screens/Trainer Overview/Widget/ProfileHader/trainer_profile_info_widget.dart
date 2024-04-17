// import 'package:drawable_text/drawable_text.dart';
// import 'package:fitness_storm/core/strings/enum_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../Model/trainer.dart';
// import '../../../../../features/appointments/ui/widget/appointments_button.dart';
// import '../../../../Trainer Screens/Trainer Overview/Widget/ProfileHader/chat_and_video_button_widget.dart';
//
// class TrainerProfileInfowidget extends StatelessWidget {
//   const TrainerProfileInfowidget({super.key, required this.trainer});
//
//   final TrainerModel trainer;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               const SizedBox(width: 7),
//               FittedBox(
//                 child: Text(
//                   trainer.name??'',
//                   style: const TextStyle(
//                     color: Color(0xFF565C63),
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 15),
//           Row(
//             children: [
//               const SizedBox(width: 7),
//               ChatAndVideoButtonWidget(trainer: trainer),
//             ],
//           ),
//           // SizedBox(height: Get.height / 6)
//         ],
//       ),
//     );
//   }
// }
