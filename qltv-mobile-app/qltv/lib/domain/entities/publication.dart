import 'package:qltv/domain/entities/metadata_publication.dart';

class Publication {
  Publication({
    this.id,
    this.title,
    this.authors,
    this.isbn,
    this.image_url,
    this.still,
    this.has_digital,
    this.publisher,
    this.publication_year,
    this.format,
    this.model,
    this.subject,
    this.metadata,
    this.remain,
    this.type,
    this.seen
  });

  int? id;
  String? title;
  String? authors;
  String? isbn;
  String? image_url;
  int? still;
  bool? has_digital;
  int? publication_year;
  String? publisher;
  String? format;
  String? model;
  String? subject;
  MetadataPublication? metadata;
  int? remain;
  String? type;
  int? seen;

  factory Publication.fromJson(Map<String, dynamic>? json) {
    return Publication(
      id: json?["id"] == null ? null : json?['id'] as int,
      title: json?["title"] == null ? null : json?['title'] as String,
      authors: json?["authors"] == null ? null : json?['authors'] as String,
      isbn: json?["isbn"] == null ? null : json?['isbn'] as String,
      image_url: json?["image_url"] == null ? null : json?['image_url'] as String,
      still: json?["still"] == null ? null : json?['still'] as int,
      has_digital: json?["has_digital"] == null ? false : json?['has_digital'] as bool,
      publication_year: json?["publication_year"] == null ? null : json?['publication_year'] as int,
      publisher: json?["publisher"] == null ? null : json?['publisher'] as String,
      format: json?["format"] == null ? null : json?['format'] as String,
      model: json?["model"] == null ? null : json?['model'] as String,
      subject: json?["subject"] == null ? null : json?['subject'] as String,
      metadata: json?["metadata"] == null ? null : MetadataPublication.fromJson(json?["metadata"]),
      remain: json?["remain"] == null ? null : json?['remain'] as int,
      type: json?["type"] == null ? null : json?['type'] as String,
      seen: json?["seen"] == null ? null : json?['seen'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'authors': authors,
    'isbn': isbn,
    'image_url': image_url,
    'still': still,
    'has_digital': has_digital,
    'publication_year': publication_year,
    'publisher': publisher,
    'format': format,
    'model': model,
    'subject': subject,
    'metadata': metadata,
    'remain': remain,
    'type': type,
    'seen': seen,
  };
}