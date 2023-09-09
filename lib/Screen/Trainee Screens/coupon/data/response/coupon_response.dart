class CheckCouponResult {
  CheckCouponResult({
    required this.success,
    required this.percentage,
  });

  final bool success;
  final num percentage;

  factory CheckCouponResult.fromJson(Map<String, dynamic> json){
    return CheckCouponResult(
      success: json["success"] ?? false,
      percentage: json["percentage"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "percentage": percentage,
  };

}
