class MetadataPublication {
  MetadataPublication({
    this.dimension,
    this.intro_pub,
    this.cover_type,
    this.print_length,
    this.image_url,
    this.keywords,
  });

  String? dimension;
  String? intro_pub;
  String? cover_type;
  int? print_length;
  String? image_url;
  String? keywords;

  factory MetadataPublication.fromJson(Map<String, dynamic>? json) {
    return MetadataPublication(
      print_length: json?["print_length"] == null ? null : json?['print_length'] as int,
      intro_pub: json?["intro_pub"] == null ? null : json?['intro_pub'] as String,
      cover_type: json?["cover_type"] == null ? null : json?['cover_type'] as String,
      dimension: json?["dimension"] == null ? null : json?['dimension'] as String,
      image_url: json?["image_url"] == null ? null : json?['image_url'] as String,
      keywords: json?["keywords"] == null ? null : json?['keywords'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'dimension': dimension,
    'intro_pub': intro_pub,
    'cover_type': cover_type,
    'print_length': print_length,
    'image_url': image_url,
    'keywords': keywords
  };
}