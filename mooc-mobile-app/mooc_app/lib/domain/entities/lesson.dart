import 'package:mooc_app/domain/entities/document_file.dart';

class Lesson {
  Lesson({
    required this.id,
    required this.label,
    this.type,
    this.data,
    this.children,
    this.isTrial,
    this.documentFiles,
  });

  int id;
  String label;
  String? type;
  String? data;
  List<Lesson>? children;
  bool? isTrial;
  List<DocumentFile>? documentFiles;

  factory Lesson.fromJson(Map<String, dynamic>? json) {
    return Lesson(
      id: json?['id'] as int,
      label: json?['label'] as String,
      type: json?["type"] == null ? null : json?['type'] as String,
      data: json?["data"] == null ? null : json?['data'] as String,
      children: json?["children"] == null ? null : List<Lesson>.from(json?["children"].map((x) => Lesson.fromJson(x))),
      isTrial: json?["isTrial"] == null ? null : json?['isTrial'] as bool,
      documentFiles: json?["documentFiles"] == null ? null : List<DocumentFile>.from(json?["documentFiles"].map((x) => DocumentFile.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'type': type,
    'data': data,
    'children': List<dynamic>.from(children!.map((x) => x.toJson())),
    'isTrial': isTrial,
    'documentFiles': List<dynamic>.from(children!.map((x) => x.toJson())),
  };
}