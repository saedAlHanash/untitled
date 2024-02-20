class AvailableTimesRequest {
  DateTime? from;
  DateTime? to;

  AvailableTimesRequest({
    this.from,
    this.to,
  });

  Map<String, dynamic> toJson() {
    final now = DateTime.now();
    return {
      'from': (from ?? now).toLocal().toIso8601String(),
      'to': (to ?? now.copyWith(year: now.year + 1)).toLocal().toIso8601String(),
    };
  }
}
