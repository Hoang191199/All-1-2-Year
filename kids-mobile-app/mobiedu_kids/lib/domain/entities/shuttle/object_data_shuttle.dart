class ObjectDataShuttle {
  ObjectDataShuttle({
    this.index,
    this.description,
    this.check,
  });

  int? index;
  String? description;
  List<bool>? check;

  factory ObjectDataShuttle.fromJson(Map<String, dynamic>? json) {
    return ObjectDataShuttle(
      index: json?["index"] == null ? null : json?['index'] as int,
      description: json?["description"] == null ? null : json?['description'] as String,
      check: json?["check"] == null ? null : json?['check'] as List<bool>,
    );
  }

  Map<String, dynamic> toJson() => {
      'index': index,
      'description': description,
      'check': check,
  };
}