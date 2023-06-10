import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BioCheckWidget extends StatelessWidget {
  final String title;
  final String value;

  const BioCheckWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    // Check if the current locale is English
    bool isEnglish = Get.locale?.languageCode == 'en';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: isEnglish
              ? EdgeInsets.only(left: 0)
              : EdgeInsets.only(right: Get.width / 30.5),
          child: const Icon(
            FontAwesomeIcons.checkCircle,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:
                  TextStyle(color: Colors.white, fontSize: isEnglish ? 12 : 13),
            ),
            Text(
              value,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: isEnglish ? 24 : 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }
}
