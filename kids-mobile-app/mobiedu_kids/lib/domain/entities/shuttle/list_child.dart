import 'package:mobiedu_kids/domain/entities/shuttle/late_pickup.dart';

class ListChild {
  ListChild({
    this.list_child,
  });
  List<LatePickup>? list_child;

  factory ListChild.fromJson(Map<String, dynamic>? json) {
    return ListChild(
      list_child:json?['list_child'] == null ? null : List<LatePickup>.from(json?["list_child"].map((x) => LatePickup.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'list_child': list_child,
    // 'registered_child': registered_child
  };
}