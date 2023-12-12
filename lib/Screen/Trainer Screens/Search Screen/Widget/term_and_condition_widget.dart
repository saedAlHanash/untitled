import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Utils/Routes/app_pages.dart';
import '../../../Trainee Screens/Chat/Widget/chat_card_widget.dart';
import '../../../chat/util.dart';

class TrainerTermAndConditionWidget extends StatefulWidget {
  const TrainerTermAndConditionWidget({super.key});

  @override
  State<TrainerTermAndConditionWidget> createState() => _TrainerTermAndConditionWidgetState();
}

class _TrainerTermAndConditionWidgetState extends State<TrainerTermAndConditionWidget> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width / 6.75, vertical: Get.height / 20.3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'do_you_have_any_question_in_your_mind?'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14),
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
                    width: 40,
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.FAQs);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.normal),
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
                    width: 24,
                  ),
                  SizedBox(
                    height: 25,
                    child: TextButton(
                      onPressed: () async{
                                if (loading) return;
                        loading = true;
                        final room = await getRoomByUser('0');
                         loading = false;
                        if (context.mounted) {
                          openRoomFunction(context, room!);
                        }
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.normal),
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
