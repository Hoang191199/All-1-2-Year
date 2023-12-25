import 'package:mobiedu_kids/domain/entities/children_data.dart';

class ListChildren {
  ListChildren({
   this.child_list,
  });

List<ChildrenData>? child_list;

  factory ListChildren.fromJson(Map<String, dynamic>? json) {
    return ListChildren(
      child_list:json?['child_list'] == null ? null : List<ChildrenData>.from(json?["child_list"].map((x) => ChildrenData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'child_list': child_list,
  };
}