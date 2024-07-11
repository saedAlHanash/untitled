import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlanTimeFrequency extends StatelessWidget {
  const PlanTimeFrequency({
        super.key,
    required this.totalWeeks,
    required this.workoutFrequency,
    required this.trainingType,
    required this.color,
  }) ;

  final Color? color;
  final int totalWeeks;
  final String trainingType;
  final int workoutFrequency;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$totalWeeks ${'weeks'.tr}',
            style: TextStyle(color: color, fontSize: 20),
          ),
          Text('•', style: TextStyle(color: color, fontSize: 30)),
          Text(
            ' $workoutFrequency ${'times/week'.tr}',
            style: TextStyle(color: color, fontSize: 20),
          ),
          Text('•', style: TextStyle(color: color, fontSize: 30)),
          Text(' $trainingType', style: TextStyle(color: color, fontSize: 20)),
        ],
      ),
    );
  }
}
