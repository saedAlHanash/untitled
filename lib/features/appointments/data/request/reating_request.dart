class RatingRequest {
  RatingRequest({
     this.appointmentId,
     this.rating,
     this.review,
  });

   int? appointmentId;
   num? rating;
   String? review;

  factory RatingRequest.fromJson(Map<String, dynamic> json){
    return RatingRequest(
      appointmentId: json["appointment_id"] ?? 0,
      rating: json["rating"] ?? 1,
      review: json["review"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "appointment_id": appointmentId,
    "rating": rating,
    "review": review,
  };

}
