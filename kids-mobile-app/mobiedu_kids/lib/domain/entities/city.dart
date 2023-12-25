class City {
  City({this.city_id, this.city_name});

  String? city_id;
  String? city_name;

  factory City.fromJson(Map<String, dynamic>? json) {
    return City(
      city_id: json?["city_id"] == null ? null : json?["city_name"] as String,
      city_name:
          json?["city_name"] == null ? null : json?["city_name"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'city_id': city_id,
        'city_name': city_name,
      };
}
