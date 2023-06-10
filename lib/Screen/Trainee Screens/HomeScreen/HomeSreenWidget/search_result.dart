import 'package:fitness_storm/Utils/Constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchResult extends StatelessWidget {
  const SearchResult(
      {Key? key,
      required this.imageUrl,
      required this.planName,
      required this.trainerName})
      : super(key: key);

  final String imageUrl;
  final String planName;
  final String trainerName;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(Constants.imageUrl + imageUrl),
        Positioned(
            bottom: Get.height / 35,
            left: Get.width / 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(trainerName),
                Text(
                  planName,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            )),
      ],
    );
  }
}
