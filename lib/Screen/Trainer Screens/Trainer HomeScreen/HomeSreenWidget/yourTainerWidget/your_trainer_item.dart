// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_multi_type/image_multi_type.dart';
//
// class YourTrainersItem extends GetWidget {
//   final String trainerImageUrl;
//   final String trainerName;
//   final String numberOfPlans;
//
//   const YourTrainersItem({
//         super.key,
//     required this.trainerImageUrl,
//     required this.trainerName,
//     required this.numberOfPlans,
//   }) ;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(left: 10),
//       child: Column(
//         children: [
//           SizedBox(
//             height: MediaQuery.of(Get.context!).size.height / 4.5,
//             child: Stack(
//               children: [
//                 _buildTrainerImage(planImageUrl: trainerImageUrl),
//                 Positioned(
//                   bottom: Get.height / 150,
//                   child: _buildTrainerInfo(
//                       numberOfPlans: numberOfPlans, trainerName: trainerName),
//                 )
//               ],
//             ),
//           ),
//           Center(
//             child: Container(
//                 width: Get.width / 3.2,
//                 height: Get.height / 40,
//                 color: Get.theme.colorScheme.secondary,
//                 child: Center(
//                   child: Text(
//                     'private_coatching'.tr,
//                     style: const TextStyle(
//                         fontSize: 11,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                   ),
//                 )),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTrainerInfo(
//       {required String trainerName, required String numberOfPlans}) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             trainerName,
//             style: const TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 15,
//             ),
//           ),
//           Text('$numberOfPlans Workout plan',
//               style: TextStyle(color: Get.theme.colorScheme.secondary))
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTrainerImage({required String planImageUrl}) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(15),
//       child: SizedBox(
//         height: MediaQuery.of(Get.context!).size.height / 3,
//         width: MediaQuery.of(Get.context!).size.width / 2.6,
//         child:
//             ImageMultiType(url: planImageUrl, fit: BoxFit.cover),
//       ),
//     );
//   }
// }
