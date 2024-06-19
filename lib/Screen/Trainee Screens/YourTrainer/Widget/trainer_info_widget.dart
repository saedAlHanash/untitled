// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../../../features/trainer/data/response/trainer.dart';
//
// class TrainerInfoWidget extends StatelessWidget {
//   const TrainerInfoWidget({
//     super.key,
//     required this.trainer,
//   });
//
//   final TrainerModel trainer;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           width: Get.width / 1.6,
//           child: Text(
//             trainer.name,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 22,
//               color: Color(0xFF565C63),
//             ),
//           ),
//         ),
//         SizedBox(height: Get.height / 100.66),
//         RatingBarIndicator(
//           itemCount: 5,
//           rating: trainer.rating.toDouble(),
//           itemSize: 30.0.r,
//           itemBuilder: (context, _) => Icon(
//             Icons.star,
//             color: Colors.amber,
//             size: 25.0.r,
//           ),
//         ),
//         if (trainer.numberOfPrivateHours > 0)
//           Text(
//             '+${trainer.numberOfPrivateHours} ${'private_hours'.tr}',
//             style: const TextStyle(
//               fontSize: 14,
//               color: Color(0xFF565C63),
//             ),
//           ),
//       ],
//     );
//   }
// }
