import 'package:qltv/domain/entities/metadata.dart';
import 'package:qltv/domain/entities/bookcase_progress.dart';

class Bookcase {
  Bookcase({
    this.id,
    this.title,
    this.authors,
    this.publication_year,
    this.metadata,
    this.progress,
  });

  int? id;
  String? title;
  String? authors;
  int? publication_year;
  Metadata? metadata;
  BookcaseProgress? progress;

  factory Bookcase.fromJson(Map<String, dynamic>? json) {
    return Bookcase(
      id: json?["id"] == null ? null : json?['id'] as int,
      title: json?["title"] == null ? null : json?['title'] as String,
      authors: json?["authors"] == null ? null : json?['authors'] as String,
      publication_year: json?["publication_year"] == null ? null : json?['publication_year'] as int,
      metadata: json?['metadata'] == null ? null : Metadata.fromJson(json?['metadata']),
      progress: json?['progress'] == null ? null : BookcaseProgress.fromJson(json?['progress']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'authors': authors,
    'publication_year': publication_year,
    'metadata': metadata,
    'progress': progress,
  };
}