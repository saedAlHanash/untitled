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
    final now = DateTime.now();
    return {
      'from': (from ?? now)
          .toLocal()
          .copyWith(
            hour: 0,
            minute: 0,
            second: 0,
            millisecond: 0,
            microsecond: 0,
          )
          .toIso8601String(),
      'to': (to ?? now.copyWith(year: now.year + 1))
          .toLocal()
          .copyWith(
            hour: 0,
            minute: 0,
            second: 0,
            millisecond: 0,
            microsecond: 0,
          )
          .toIso8601String(),
      'is_booked': isBooked,
    };
  }
}
