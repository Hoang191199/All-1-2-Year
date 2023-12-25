import 'metadata.dart';

class PageSection {
  PageSection({
    this.id,
    this.site_id,
    this.page_id,
    this.template_type,
    this.metadata,
  });

  int? id;
  int? site_id;
  int? page_id;
  String? template_type;
  Metadata? metadata;

  factory PageSection.fromJson(Map<String, dynamic>? json) {
    return PageSection(
      id: json?["id"] == null ? null : json?['id'] as int,
      site_id: json?["site_id"] == null ? null : json?['site_id'] as int,
      page_id: json?["page_id"] == null ? null : json?['page_id'] as int,
      template_type: json?["template_type"] == null ? null : json?['template_type'] as String,
      metadata: json?['metadata'] == null ? null : Metadata.fromJson(json?['metadata']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'site_id': site_id,
    'page_id': page_id,
    'template_type': template_type,
    'metadata': metadata,
  };
}