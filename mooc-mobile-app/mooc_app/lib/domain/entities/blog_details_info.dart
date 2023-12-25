import 'package:mooc_app/domain/entities/avatar.dart';

class BlogDetailInfo {

  BlogDetailInfo({
    required this.id,
    required this.title,
    required this.slug,
    this.category,
    required this.description,
    this.thumbnailFile,
    this.htmlContent,
    this.content,
    this.tags,
    required this.status,
    this.idCategory,
    this.creatorName,
    this.idCreator,
  });

  int id;
  String title;
  String slug;
  List<String>? category;
  String description;
  Avatar? thumbnailFile;
  String? htmlContent;
  String? content;
  List<String>? tags;
  int status;
  int? idCategory;
  String? creatorName;
  int? idCreator;

  factory BlogDetailInfo.fromJson(Map<String, dynamic>? json) {
    return BlogDetailInfo(
      id: json?['id'] as int,
      title: json?['title'] as String,
      slug: json?['slug'] as String,
      category: json?["category"] == null ? null : List<String>.from(json?["category"]),
      description: json?['description'] as String,
      thumbnailFile: json?["thumbnailFile"] == null ? null : Avatar.fromJson(json?['thumbnailFile']),
      htmlContent: json?['htmlContent'] == null ? null : json?['htmlContent'] as String,
      content: json?['content'] == null ? null : json?['content'] as String,
      tags: json?["tags"] == null ? null : List<String>.from(json?["tags"]),
      status: json?['status'] as int,
      idCategory:json?['idCategory'] == null ? null : json?['idCategory'] as int,
      creatorName: json?['creatorName'] == null ? null : json?['creatorName'] as String,
      idCreator: json?['idCreator'] == null ? null : json?['idCreator'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
  "id": id,
  "title": title,
  "slug":slug,
  "category": category,
  "description": description,
  "thumbnailFile": thumbnailFile,
  "htmlContent": htmlContent,
  "content": content,
  "tags": tags,
  "status":status,
  "idCategory":idCategory,
  "creatorName": creatorName,
  "idCreator": idCreator,
  };
}