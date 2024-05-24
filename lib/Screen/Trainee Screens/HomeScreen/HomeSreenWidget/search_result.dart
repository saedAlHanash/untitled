import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_multi_type/image_multi_type.dart';

class SearchResult extends StatelessWidget {
  const SearchResult(
      {    super.key,
      required this.imageUrl,
      required this.planName,
      required this.trainerName})
      ;

  final String imageUrl;
  final String planName;
  final String trainerName;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageMultiType(url: imageUrl),
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
