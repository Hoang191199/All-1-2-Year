class MetadataItem {
  MetadataItem({
    this.order,
    this.image_url,
  });

  int? order;
  String? image_url;

  factory MetadataItem.fromJson(Map<String, dynamic>? json) {
    return MetadataItem(
      order: json?["order"] == null ? null : json?['order'] as int,
      image_url: json?["image_url"] == null ? null : json?['image_url'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'order': order,
    'image_url': image_url,
  };
}