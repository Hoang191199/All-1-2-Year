class BorrowPaging<T> {
  BorrowPaging({
    required this.total,
    required this.data,
  });

  int? total;
  List<T>? data;

  factory BorrowPaging.fromJson(Map<String, dynamic>? json, Function(Map<String, dynamic>) create) {
    return BorrowPaging(
      total: json?['total'] == null ? null : json?['total'] as int,
      data: json?["data"] == null
          ? null
          : List<T>.from(json?["data"].map((x) => create(x))),
    );
  }

  Map<String, dynamic> toJson() => {'total': total, 'data': data};
}
