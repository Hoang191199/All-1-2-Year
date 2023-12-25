class ServiceShuttle {
  ServiceShuttle({
    this.service_id,
    this.price,
    this.service_name,
    this.service_usage_id
    });

  String? service_id;
  String? price;
  String? service_name;
  String? service_usage_id;

  factory ServiceShuttle.fromJson(Map<String, dynamic>? json) {
    return ServiceShuttle(
      service_id: json?["service_id"] == null ? null : json?['service_id'] as String,
      price: json?["price"] == null ? null : json?['price'] as String,
      service_name: json?["service_name"] == null ? null : json?['service_name'] as String,
      service_usage_id: json?["service_usage_id"] == null ? null : json?['service_usage_id'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
      'service_id': service_id,
      'price': price,
      'service_name': service_name,
      'service_usage_id': service_usage_id
  };
}
