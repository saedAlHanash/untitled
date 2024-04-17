class BundlesRequest {
  BundlesRequest({
     this.trainerId,
  });

  final int? trainerId;

  Map<String, dynamic> toJson() {
    return {
      'trainerId': trainerId,
    };
  }

  factory BundlesRequest.fromJson(Map<String, dynamic> map) {
    return BundlesRequest(
      trainerId: map['trainerId'],
    );
  }
}
