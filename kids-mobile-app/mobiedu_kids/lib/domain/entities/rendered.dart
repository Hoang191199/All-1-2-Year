class Rendered {
  Rendered({
    this.rendered,
  });

  String? rendered;
  factory Rendered.fromJson(Map<String, dynamic>? json) {
    return Rendered(
      rendered: json?["rendered"] == null ? null : json?['rendered'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'rendered': rendered,
      };
}
