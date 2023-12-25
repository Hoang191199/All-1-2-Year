class DataInDatAssign{
  DataInDatAssign({
    this.assign_day,
    this.assign_time,
    this.class_name
  });

  String? assign_day;
  String? assign_time;
  String? class_name;


  factory DataInDatAssign.fromJson(Map<String, dynamic>? json) {
    return DataInDatAssign(
      assign_day: json?["assign_day"] == null ? null : json?['assign_day'] as String,
      assign_time: json?["assign_time"] == null ? null : json?['assign_time'] as String,
      class_name: json?["class_name"] == null ? null : json?['class_name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'assign_day': assign_day,
    'assign_time': assign_time,
    'class_name': class_name,
  };
}