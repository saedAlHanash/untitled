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
      'from': (from ?? now).toLocal().toIso8601String(),
      'to': (to ?? now.copyWith(year: now.year + 1)).toLocal().toIso8601String(),
      'is_booked': isBooked,
    };
  }
}
