import 'package:mobiedu_kids/domain/entities/service/student_in_service.dart';

class ListUsage {
  ListUsage({
    this.list_usage,
  });
  
  List<StudentInService>? list_usage;

  factory ListUsage.fromJson(Map<String, dynamic>? json) {
    return ListUsage(
      list_usage:json?['list_usage'] == null ? null : List<StudentInService>.from(json?["list_usage"].map((x) => StudentInService.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
      'list_usage': list_usage,
  };
}