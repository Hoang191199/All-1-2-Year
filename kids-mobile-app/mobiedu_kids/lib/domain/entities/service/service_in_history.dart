import 'package:mobiedu_kids/domain/entities/service/children_in_history.dart';

class ServiceInHistory{
  ServiceInHistory({
    this.service_name,
    this.usage_count,
    this.children
  });

  String? service_name;
  int? usage_count;
  List<ChildrenInHistory>? children;

  factory ServiceInHistory.fromJson(Map<String, dynamic>? json) {
    return ServiceInHistory(
      service_name: json?["service_name"] == null ? null : json?['service_name'] as String,
      usage_count: json?["usage_count"] == null ? null : json?['usage_count'] as int,
      children:json?['children'] == null ? null : List<ChildrenInHistory>.from(json?["children"].map((x) => ChildrenInHistory.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
      'service_name': service_name,
  };
}