import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainerProfileOverviewInfo extends StatelessWidget {
  final String trainerName;

  const TrainerProfileOverviewInfo({super.key, required this.trainerName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 1.8,
      padding: EdgeInsets.only(top: Get.height / 41.5, left: Get.width / 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            trainerName,
            style: const TextStyle(
              color: Color(0xFF565C63),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      'SET_MY_AVAILABILITY'.tr,
                    ),
                    const Icon(Icons.arrow_circle_right)
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text(
                        'PLANS_BY_ME'.tr,
                      ),
                      const Icon(Icons.arrow_circle_right)
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
