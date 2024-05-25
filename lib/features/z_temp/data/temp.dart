class Temp {

  Temp();

  Map<String, dynamic> toJson() {
    return {};
  }

  factory Temp.fromJson(Map<String, dynamic> map) {
    return Temp();
  }

//</editor-fold>
}

class TempList {

  final List<Temp> data;

//<editor-fold desc="Data Methods">
  const TempList({
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      'data': this.data,
    };
  }

  factory TempList.fromJson(Map<String, dynamic> map) {
    return TempList(
      data: map['data'] as List<Temp>,
    );
  }


}
