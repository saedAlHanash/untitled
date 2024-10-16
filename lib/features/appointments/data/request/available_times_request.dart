import 'package:fitness_storm/core/extensions/extensions.dart';

class AvailableTimesRequest {
  DateTime? from;
  DateTime? to;
  int? isBooked;

  AvailableTimesRequest({
    this.from,
    this.to,
    this.isBooked = 1,
  });

  Map<String, dynamic> toJson() {
    final now = DateTime.now()
        .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
    return {
      'from': (to ?? now.addFromNow(day: -1)).toIso8601String(),
      'to': (from ?? now.addFromNow(year: 1)).toIso8601String(),
      'is_booked': isBooked,
    };
  }
}
