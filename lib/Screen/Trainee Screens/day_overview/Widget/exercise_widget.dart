//  
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../Widgets/vimeo_player.dart';
//
// class ExerciseWidget extends StatelessWidget {
//   final String videoId;
//   final String title;
//   final String set;
//   final String repetition;
//
//   const ExerciseWidget({
//     Key? key,
//     required this.videoId,
//     required this.set,
//     required this.repetition,
//     required this.title,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       // height: MediaQuery.of(context).size.height / 2.7,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             // height: Get.height / 10,
//             child: GestureDetector(
//               onTap: () {
//                //log('sdsdsd');
//                 Get.bottomSheet(
//                     SizedBox(
//                         height: Get.height / 4,
//                         width: Get.width,
//                         child: Stack(
//                           children: [
//                             //todo
//                             // new VimeoVideoPlayer(
//                             //     url: 'https://vimeo.com/${videoId}'),
//                             VimoePlayer(videoId: videoId),
//                             IconButton(
//                               icon: const Icon(Icons.close),
//                               onPressed: () => Get.back(),
//                             ),
//                           ],
//                         )),
//                     elevation: 10,
//                     enableDrag: true,
//                     ignoreSafeArea: true,
//                     // useRootNavigator: true,
//                     backgroundColor: Get.theme.scaffoldBackgroundColor);
//               },
//               child: ListTile(
//                 contentPadding: const EdgeInsets.all(0),
//                 leading: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Container(
//                       height: Get.height / 9,
//                       width: Get.width / 5,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           border: Border.all(color: Get.theme.primaryColor)),
//                       child: Image.asset('asset/Images/logo2.png')),
//                 ),
//                 title: Text(title),
//                 subtitle: Row(children: [
//                   Text("Set : $set • " + 'reps'.tr + " : $repetition")
//                 ]),
//               ),
//             ),
//           ),
//           // Row(children: [
//           //   Icon(Icons.calendar_today, color: Theme.of(context).primaryColor),
//           //   const SizedBox(width: 10),
//           //   Text(set)
//           // ]),
//           // Padding(
//           //   padding: const EdgeInsets.only(bottom: 8.0),
//           //   child: Row(
//           //     children: [
//           //       Icon(Icons.calendar_today,
//           //           color: Theme.of(context).primaryColor),
//           //       const SizedBox(width: 10),
//           //       Text(repetition),
//           //     ],
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
