class EpubMetadataMeta {
  EpubMetadataMeta({
    this.name,
    this.content,
    this.id,
    this.refines,
    this.property,
    this.scheme,
    this.attributes,
  });

  String? name;
  String? content;
  String? id;
  String? refines;
  String? property;
  String? scheme;
  Map<String, String>? attributes;
}