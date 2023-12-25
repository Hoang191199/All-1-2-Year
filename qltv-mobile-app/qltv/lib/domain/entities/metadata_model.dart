import 'package:qltv/domain/entities/publication.dart';

class MetadataModel {
  MetadataModel({
    this.name,
    this.publication,
  });

  String? name;
  List<Publication>? publication;

  factory MetadataModel.fromJson(Map<String, dynamic>? json) {
    return MetadataModel(
      name: json?["name"] == null ? null : json?['name'] as String,
      publication: json?["publication"] == null ? null : List<Publication>.from(json?["publication"].map((x) => Publication.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'publication': publication,
  };
}