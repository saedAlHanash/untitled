// import 'package:fitness_storm/Utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
//
// import '../../../../../Data/Repositories/Trainer Repository/trainer_appointments.dart';
// import '../../../../../Model/trainer.dart';
// import '../../../../../Utils/Routes/app_pages.dart';
// import '../../../../Trainee Screens/Chat/Widget/chat_card_widget.dart';
// import '../../../../Trainee Screens/Trainer Overview/trainer_overview_controller.dart';
// import '../../../../chat/get_chats_rooms_bloc/get_rooms_cubit.dart';
// import '../../../../video/video.dart';
// import '../../../Trainer Calender/trainer_calender_controller.dart';
//
// class ChatAndVideoButtonWidget extends StatefulWidget {
//   const ChatAndVideoButtonWidget({super.key, required this.trainer});
//
//   final TrainerModel trainer;
//
//   @override
//   State<ChatAndVideoButtonWidget> createState() => _ChatAndVideoButtonWidgetState();
// }
//
// class _ChatAndVideoButtonWidgetState extends State<ChatAndVideoButtonWidget> {
//   var isLoading = true;
//
//   var isHaveSession = false;
//   var data = AppointmentModel.fromJson({});
//
//   @override
//   void initState() {
//     Get.put(TrainerCalenderController()).traineeMakeVideoCall().then((value) {
//       if (value == null) return;
//
//       data = value;
//       isLoading = false;
//       isHaveSession = true;
//
//       setState(() {});
//     });
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         StatefulBuilder(builder: (context, myState) {
//           return InkWell(
//             onTap: isLoading
//                 ? null
//                 : () async {
//               if (!isHaveSession) {
//                 bookSession();
//                 return;
//               }
//               myState(() => isLoading = true);
//
//               final openRoom = await context
//                   .read<RoomsCubit>()
//                   .getRoomByUser(widget.trainer.id.toString());
//
//               myState(() => isLoading = false);
//               if (!mounted || openRoom == null) return;
//               openRoomFunction(context, openRoom);
//               return;
//             },
//             child: Container(
//               height: Get.height / 27,
//               width: Get.width / 12.5,
//               // padding: EdgeInsets.all(2),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(2),
//                 color: (isLoading || !isHaveSession)
//                     ? Colors.grey
//                     : Get.theme.colorScheme.secondary,
//               ),
//               child: Image.assets(
//                 'assets/images/chat3.png',
//               ),
//             ),
//           );
//         }),
//         const SizedBox(width: 10),
//         InkWell(
//           onTap: isLoading
//               ? null
//               : () async {
//             if (!isHaveSession) {
//               bookSession();
//             } else if (data.videoCallToken.isEmpty) {
//               Utils.openSnackBar(message: "Video Call Token not found ");
//             } else {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) =>
//                       Video1(
//                         tempToken: data.videoCallToken,
//                       ),
//                 ),
//               );
//             }
//           },
//           child: Container(
//             height: Get.height / 27,
//             padding: const EdgeInsets.all(5),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(2),
//               color: (isLoading || data.videoCallToken.isEmpty)
//                   ? Colors.grey
//                   : Get.theme.colorScheme.secondary,
//             ),
//             child: Row(
//               children: [
//                 const SizedBox(width: 3),
//                 Image.assets(
//                   'assets/images/video.png',
//                 ),
//                 const SizedBox(width: 5),
//                 Text(
//                   'private_session'.tr,
//                   style: const TextStyle(color: Colors.white, fontSize: 10),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
// }
