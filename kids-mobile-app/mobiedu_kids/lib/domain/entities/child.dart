import 'package:mobiedu_kids/domain/entities/child_details.dart';

class Child {
  Child({
    this.child,
  });

  ChildDetails? child;

  factory Child.fromJson(Map<String, dynamic>? json) {
    return Child(
      child:
          json?["child"] == null ? null : ChildDetails.fromJson(json?["child"]),
    );
  }

  Map<String, dynamic> toJson() => {
        'child': child,
      };
}
