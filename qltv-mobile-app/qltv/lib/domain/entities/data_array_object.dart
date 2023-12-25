class DataArrayObject<T> {
  DataArrayObject({
    this.total,
    this.data,
  });

  int? total;
  List<T>? data;

  factory DataArrayObject.fromJson(Map<String, dynamic>? json, Function(Map<String, dynamic>) create) {
    return DataArrayObject<T>(
      total: json?['total'] == null ? 0 : json?['total'] as int,
      data: json?['data'] == null ? null : List<T>.from(json?["data"].map((x) => create(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'error': total,
    'data': data,
  };
}