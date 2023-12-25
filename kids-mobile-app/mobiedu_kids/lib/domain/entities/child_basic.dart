import 'package:mobiedu_kids/domain/entities/children_data.dart';
import 'package:mobiedu_kids/domain/entities/parent_details.dart';

class ChildBasic {
  ChildBasic({
    this.child,
    this.parent,
  });

  ChildrenData? child;
  List<ParentDetails>? parent;

  factory ChildBasic.fromJson(Map<String, dynamic>? json) {
    return ChildBasic(
      child:
          json?["child"] == null ? null : ChildrenData.fromJson(json?['child']),
      parent: json?["parent"] == null
          ? null
          : List<ParentDetails>.from(
              json?["parent"].map((x) => ParentDetails.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "child": child,
        "parent": parent,
      };
}
