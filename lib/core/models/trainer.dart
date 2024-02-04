// class TrainerModel {
//   TrainerModel({
//     required this.id,
//     required this.image,
//     required this.name,
//     required this.bio,
//     required this.introductionVideo,
//     required this.numberOfPlans,
//     required this.numberOfPrivateHours,
//     required this.numberOfSubscribers,
//     required this.specialties,
//     required this.privateSessionPrice,
//     required this.appointment,
//   });
//
//   final String id;
//   final String image;
//   final String name;
//   final String bio;
//   final String introductionVideo;
//   final String numberOfPlans;
//   final num numberOfPrivateHours;
//   final num numberOfSubscribers;
//   final List<Specialty> specialties;
//   final num privateSessionPrice;
//   final Appointment? appointment;
//
//   factory TrainerModel.fromJson(Map<String, dynamic> json){
//     return TrainerModel(
//       id: json["id"] ?? "",
//       image: json["image"] ?? "",
//       name: json["name"] ?? "",
//       bio: json["bio"] ?? "",
//       introductionVideo: json["introduction_video"] ?? "",
//       numberOfPlans: json["number_of_plans"] ?? "",
//       numberOfPrivateHours: json["number_of_private_hours"] ?? 0,
//       numberOfSubscribers: json["number_of_subscribers"] ?? 0,
//       specialties: json["specialties"] == null ? [] : List<Specialty>.from(json["specialties"]!.map((x) => Specialty.fromJson(x))),
//       privateSessionPrice: json["private_session_price"] ?? 0,
//       appointment: json["appointment"] == null ? null : Appointment.fromJson(json["appointment"]),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "image": image,
//     "name": name,
//     "bio": bio,
//     "introduction_video": introductionVideo,
//     "number_of_plans": numberOfPlans,
//     "number_of_private_hours": numberOfPrivateHours,
//     "number_of_subscribers": numberOfSubscribers,
//     "specialties": specialties.map((x) => x.toJson()).toList(),
//     "private_session_price": privateSessionPrice,
//     "appointment": appointment?.toJson(),
//   };
//
// }
//
// class Appointment {
//   Appointment({
//     required this.id,
//     required this.status,
//     required this.videoCallToken,
//     required this.time,
//   });
//
//   final int id;
//   final String status;
//   final String videoCallToken;
//   final dynamic time;
//
//   factory Appointment.fromJson(Map<String, dynamic> json){
//     return Appointment(
//       id: json["id"] ?? 0,
//       status: json["status"] ?? "",
//       videoCallToken: json["video_call_token"] ?? "",
//       time: json["time"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "status": status,
//     "video_call_token": videoCallToken,
//     "time": time,
//   };
//
// }
//
// class Specialty {
//   Specialty({
//     required this.id,
//     required this.type,
//     required this.typeId,
//     required this.planId,
//   });
//
//   final String id;
//   final String type;
//   final String typeId;
//   final String planId;
//
//   factory Specialty.fromJson(Map<String, dynamic> json){
//     return Specialty(
//       id: json["id"] ?? "",
//       type: json["type"] ?? "",
//       typeId: json["type_id"] ?? "",
//       planId: json["plan_id"] ?? "",
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "type": type,
//     "type_id": typeId,
//     "plan_id": planId,
//   };
//
// }
