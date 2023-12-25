class MetadataDataModel {
  MetadataDataModel({
    this.name,
    this.count
  });

  String? name;
  int? count;

  factory MetadataDataModel.fromJson(Map<String, dynamic>? json) {
    return MetadataDataModel(
      name: json?["name"] == null ? null : json?['name'] as String,
      count: json?["count"] == null ? null : json?['count'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'count': count,
  };
}