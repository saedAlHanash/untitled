import 'package:fitness_storm/Screen/Trainee%20Screens/Chat/Widget/chat_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../Utils/Routes/app_pages.dart';
import '../../../chat/get_chats_rooms_bloc/get_rooms_cubit.dart';
import '../../../chat/util.dart';

class TermAndConditionWidget extends StatefulWidget {
  const TermAndConditionWidget({super.key});

  @override
  State<TermAndConditionWidget> createState() => _TermAndConditionWidgetState();
}

class _TermAndConditionWidgetState extends State<TermAndConditionWidget> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Get.width / 10, vertical: Get.height / 21),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'do_you_have_any_question_in_your_mind?'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'check_our'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(
                    width: 80,
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.FAQs);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textStyle: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                      child: Text(
                        'FAQ'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'or_contact_our'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(
                    height: 25,
                    child: TextButton(
                      onPressed: () async {
                        if (loading) return;
                        loading = true;
                        final room = await context.read<GetRoomsCubit>().getRoomByUser('0');
                        loading = false;
                        if (context.mounted) {
                          openRoomFunction(context, room!);
                        }
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textStyle: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                      child: Text(
                        'customer_services'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
