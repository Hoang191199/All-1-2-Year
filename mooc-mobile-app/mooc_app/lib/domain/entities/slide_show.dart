class SlideShow {
  SlideShow({
    required this.image_url,
    required this.target_url,
  });

  String image_url;
  String target_url;

  factory SlideShow.fromJson(Map<String, dynamic>? json) {
    return SlideShow(
      image_url: json?['image_url'] as String,
      target_url: json?['target_url'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'image_url': image_url,
        'target_url': target_url,
      };
}
