import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/Chat/Widget/chat_card_widget.dart';
import 'package:fitness_storm/Screen/Trainee%20Screens/coupon/coupon_cubit/coupon_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../Utils/dependency_injection.dart';
import '../Trainee Screens/Chat/Widget/customer_service_card_widget.dart';
import 'get_chats_rooms_bloc/get_rooms_cubit.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  bool loading = false;

  @override
  void initState() {
    final getRoomCubitState = Get.context?.read<GetRoomsCubit>().state.statuses;
    if (getRoomCubitState != CubitStatuses.done &&
        getRoomCubitState != CubitStatuses.loading) {
      Get.context?.read<GetRoomsCubit>().getChatRooms();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('chat'.tr),
        titleTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: BlocBuilder<GetRoomsCubit, GetRoomsInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return const CircularProgressIndicator.adaptive();
          }
          return ListView.separated(
            separatorBuilder: (context, i) {
              return Divider(
                color: Colors.grey[100],
              );
            },
            itemCount: state.allRooms.length + 1,
            itemBuilder: (context, i) {
              if (i == 0) {
                return CustomerServiceCardWidget(room: state.getCostumerRoom());
              }
              final openRoom = state.allRooms[i - 1];
              // loggerObject.w(openRoom.toJson());
              return ChatCardWidget(
                room: openRoom,
              );
            },
          );
        },
      ),
    );
  }
}
