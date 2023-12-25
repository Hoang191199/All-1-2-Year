import 'package:mobiedu_kids/domain/entities/rendered.dart';

class ContentMedia {
  ContentMedia(
      {this.id,
      this.date,
      this.date_gmt,
      this.guid,
      this.modified,
      this.modified_gmt,
      this.slug,
      this.status,
      this.type,
      this.link,
      this.title,
      this.content,
      this.excerpt});

  int? id;
  String? date;
  String? date_gmt;
  Rendered? guid;
  String? modified;
  String? modified_gmt;
  String? slug;
  String? status;
  String? type;
  String? link;
  Rendered? title;
  Rendered? content;
  Rendered? excerpt;

  factory ContentMedia.fromJson(Map<String, dynamic>? json) {
    return ContentMedia(
      id: json?["id"] == null ? null : json?['id'] as int,
      date: json?["date"] == null ? null : json?['date'] as String,
      date_gmt: json?["date_gmt"] == null ? null : json?['date_gmt'] as String,
      guid: json?["guid"] == null ? null : Rendered.fromJson(json?['guid']),
      modified: json?["modified"] == null ? null : json?['modified'] as String,
      modified_gmt: json?["modified_gmt"] == null
          ? null
          : json?['modified_gmt'] as String,
      slug: json?["slug"] == null ? null : json?['slug'] as String,
      status: json?["status"] == null ? null : json?['status'] as String,
      type: json?["type"] == null ? null : json?['type'] as String,
      link: json?["link"] == null ? null : json?['link'] as String,
      title: json?["title"] == null ? null : Rendered.fromJson(json?['title']),
      content:
          json?["content"] == null ? null : Rendered.fromJson(json?['content']),
      excerpt:
          json?["excerpt"] == null ? null : Rendered.fromJson(json?['excerpt']),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "date_gmt": date_gmt,
        "guid": guid,
        "modified": modified,
        "modified_gmt": modified_gmt,
        "slug": slug,
        "status": status,
        "type": type,
        "link": link,
        "title": title,
        "content": content,
        "excerpt": excerpt
      };
}
