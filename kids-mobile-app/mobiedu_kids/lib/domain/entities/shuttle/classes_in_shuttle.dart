import 'package:mobiedu_kids/domain/entities/shuttle/list_class.dart';

class ClassesInShuttle{
  ClassesInShuttle({
    this.classes
  });
  List<ListClass>? classes;

  factory ClassesInShuttle.fromJson(Map<String, dynamic>? json) {
    return ClassesInShuttle(
      classes:json?['classes'] == null ? null : List<ListClass>.from(json?["classes"].map((x) => ListClass.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'classes': classes,
  };
} 
