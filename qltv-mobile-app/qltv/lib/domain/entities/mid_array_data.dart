class MidArrayData<T> {
  MidArrayData({
    this.data,
    required this.total,
  });

  List<T>? data;
  int total;

  factory MidArrayData.fromJson(Map<String, dynamic>? json, Function(Map<String, dynamic>) create) {
    return MidArrayData<T>(
      data: json?["data"] == null ? null : List<T>.from(json?["data"].map((x) => create(x))),
      total: json?["total"] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
    "total": total,
  };
}