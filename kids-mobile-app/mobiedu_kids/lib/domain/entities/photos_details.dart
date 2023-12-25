class PhotosDetails {
  PhotosDetails({
    this.photo_id,
    this.source,
  });

  String? photo_id;
  String? source;

  factory PhotosDetails.fromJson(Map<String, dynamic>? json) {
    return PhotosDetails(
      photo_id: json?["photo_id"] == null ? null : json?['photo_id'] as String,
      source: json?["source"] == null ? null : json?['source'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "photo_id": photo_id,
        "source": source,
      };
}
