import 'package:mobiedu_kids/domain/entities/shuttle/class_history.dart';

class History {
  History({
    this.class_history
  });
  List<ClassHistory>? class_history;

   factory History.fromJson(Map<String, dynamic>? json) {
    return History(
      class_history:json?['class_history'] == null ? null : List<ClassHistory>.from(json?["class_history"].map((x) => ClassHistory.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
      'class_history': class_history,
  };
}