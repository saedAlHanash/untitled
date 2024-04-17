import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

class YourTrainersItem extends GetWidget {
  const YourTrainersItem({
    Key? key,
    required this.trainerImageUrl,
    required this.trainerName,
    required this.numberOfPlans,
  }) : super(key: key);

  final String numberOfPlans;
  final String trainerImageUrl;
  final String trainerName;

  Widget _buildTrainerInfo(
      {required String trainerName, required String numberOfPlans}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(
              trainerName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          FittedBox(
            child: Text('$numberOfPlans Workout plan . private',
                style: TextStyle(color: Get.theme.colorScheme.secondary)),
          ),
        ],
      ),
    );
  }

  Widget _buildTrainerImage({required String planImageUrl}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: ImageMultiType(url:
        planImageUrl,
        width: MediaQuery.of(Get.context!).size.width / 2,
        height: MediaQuery.of(Get.context!).size.width / 1.7,
        fit: BoxFit.fill,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          SizedBox(
            // height: MediaQuery.of(Get.context!).size.height / 4,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  _buildTrainerImage(planImageUrl: trainerImageUrl),
                  Container(
                    width: MediaQuery.of(Get.context!).size.width / 2,
                    // height: Get.height / 10,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black,
                          Colors.black54,
                          Colors.black26,
                          Colors.black12
                        ],
                      ),
                    ),
                    child: _buildTrainerInfo(
                        numberOfPlans: numberOfPlans, trainerName: trainerName),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
