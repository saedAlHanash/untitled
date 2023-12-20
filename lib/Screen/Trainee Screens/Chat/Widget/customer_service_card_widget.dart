import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/helper/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../main.dart';
import '../../../chat/chat.dart';
import '../../../chat/get_chats_rooms_bloc/get_rooms_cubit.dart';
import '../../../chat/room_messages_bloc/room_messages_cubit.dart';
import '../../../chat/util.dart';
import '../../../../generated/assets.dart';
import 'chat_card_widget.dart';

class CustomerServiceCardWidget extends StatelessWidget {
  const CustomerServiceCardWidget({
    super.key,
    this.room,
  });

  final Room? room;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final room = await context.read<GetRoomsCubit>().getRoomByUser('0');
        if (context.mounted) openRoomFunction(context, room!);
      },
      child: Container(
        height: Get.height / 9,
        width: Get.width,
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: Get.height / 162.4),
        child: Row(children: [
          Container(
            width: Get.width / 6,
            height: Get.width / 6,
            margin: EdgeInsets.only(left: Get.width / 12.5, right: Get.width / 18.75),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 2, color: Colors.white),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.1,
                  blurRadius: 8,
                  offset: const Offset(0, 10), // changes position of shadow
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const ImageMultiType(url: Assets.imagesCallCenter),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'customer_service'.tr,
                style: const TextStyle(
                    color: Color(0xFF565C63), fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              if (room != null)
                DrawableText(
                    color: Colors.grey,
                    size: 12.0,
                    text: DateTime.fromMillisecondsSinceEpoch(
                            room!.updatedAt ?? DateTime.now().millisecond)
                        .formatDuration()),
            ],
          ),
          if (room != null && room!.isNotReed) ...[
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                Icons.circle,
                color: Get.theme.primaryColor,
              ),
            )
          ]
        ]),
      ),
    );
  }
}
