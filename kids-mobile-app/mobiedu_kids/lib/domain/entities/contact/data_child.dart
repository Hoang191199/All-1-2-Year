import 'package:mobiedu_kids/domain/entities/contact/data_parent.dart';

class DataChild {
  DataChild({
    this. child_name,
    this.parent_email,
    this.parent
  });

  String? child_name;
  String? parent_email;
  List<DataParent>? parent;

  factory DataChild.fromJson(Map<String, dynamic>? json) {
    List<DataParent>? parent;
    if (json?['parent'] is Map<String, dynamic>) {
      var parentMap = json?['parent'] as Map<String, dynamic>;
      parent = parentMap.values.map((json) => DataParent.fromJson(json)).toList();
    } else if (json?['parent'] is List<dynamic>) {
      parent = (json?['parent'] as List<dynamic>).map((json) => DataParent.fromJson(json)).toList();
    }
    return DataChild(
      child_name: json?["child_name"] == null ? null : json?['child_name'] as String,
      parent_email: json?["parent_email"] == null ? null : json?['parent_email'] as String,
      parent: parent,
    );
  }

  Map<String, dynamic> toJson() => {
    'child_name': child_name,
    'parent_email': parent_email,
    'parent': parent,
  };
}