class Owner {
  Owner({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Owner.fromJson(Map<String, dynamic>? json) {
    return Owner(
      id: json?['id'] as int,
      name: json?['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
