import 'package:mobiedu_kids/domain/entities/attendance/hygiene.dart';

class ListChild {
  ListChild({this.listChild});

  List<Hygiene>? listChild;

  factory ListChild.fromJson(Map<String, dynamic>? json) {
    return ListChild(
      listChild:json?['listChild'] == null ? null : List<Hygiene>.from(json?["listChild"].map((x) => Hygiene.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'listChild': listChild,
  };
}
