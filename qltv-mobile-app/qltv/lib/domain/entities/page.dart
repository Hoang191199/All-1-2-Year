import 'package:qltv/domain/entities/metadata.dart';
import 'package:qltv/domain/entities/page_section.dart';

class Page {
  Page({
    this.id,
    this.site_id,
    this.type,
    this.slug,
    this.status,
    this.is_default,
    this.is_home,
    this.display_order,
    this.metadata,
    this.created_at,
    this.page_sections,
  });

  int? id;
  int? site_id;
  String? type;
  String? slug;
  bool? status;
  bool? is_default;
  bool? is_home;
  int? display_order;
  Metadata? metadata;
  String? created_at;
  List<PageSection>? page_sections;

  factory Page.fromJson(Map<String, dynamic>? json) {
    return Page(
      id: json?["id"] == null ? null : json?['id'] as int,
      site_id: json?["site_id"] == null ? null : json?['site_id'] as int,
      type: json?["type"] == null ? null : json?['type'] as String,
      slug: json?["slug"] == null ? null : json?['slug'] as String,
      status: json?["status"] == null ? false : json?['status'] as bool,
      is_default: json?["is_default"] == null ? false : json?['is_default'] as bool,
      is_home: json?["is_home"] == null ? false : json?['is_home'] as bool,
      display_order: json?["display_order"] == null ? null : json?['display_order'] as int,
      metadata: json?['metadata'] == null ? null : Metadata.fromJson(json?['metadata']),
      created_at: json?["created_at"] == null ? null : json?['created_at'] as String,
      page_sections: json?["page_sections"] == null ? null : List<PageSection>.from(json?["page_sections"].map((x) => PageSection.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'site_id': site_id,
    'type': type,
    'slug': slug,
    'status': status,
    'is_default': is_default,
    'is_home': is_home,
    'display_order': display_order,
    'metadata': metadata,
    'created_at': created_at,
    'page_sections': page_sections,
  };
}