import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Utils/Routes/app_pages.dart';
import '../../../chat/chat.dart';
import '../../../chat/util.dart';

class TermAndConditionWidget extends StatelessWidget {
  const TermAndConditionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width / 10, vertical: Get.height / 21),
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
                    height: 25,
                    child: TextButton(
                      onPressed: () async{
                        final room = await getRoomByUser('0');
                        if (context.mounted) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ChatPage(
                                room: room!,
                                name: 'CUSTOMER SERVICE' ?? '',
                              );
                            },
                          ));
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
