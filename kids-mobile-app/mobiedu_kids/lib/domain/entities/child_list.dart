import 'package:mobiedu_kids/domain/entities/child_info.dart';

class ChildList {
  ChildList({
    this.child_list,
  });

  List<ChildInfo>? child_list;

  factory ChildList.fromJson(Map<String, dynamic>? json) {
    return ChildList(
      child_list: json?["child_list"] == null
          ? null
          : List<ChildInfo>.from(
              json?["child_list"].map((x) => ChildInfo.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'child_list': child_list,
      };
}
