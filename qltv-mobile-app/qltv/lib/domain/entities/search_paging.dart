class SearchPaging<T> {
  SearchPaging({
    this.total,
    this.data,
  });

  int? total;
  List<T>? data;

  factory SearchPaging.fromJson(Map<String, dynamic>? json, Function(Map<String, dynamic>) create) {
    return SearchPaging(
      total: json?['total'] == null ? null : json?['total'] as int,
      data: json?["data"] == null ? null : List<T>.from(json?["data"].map((x) => create(x))),
    );
  }
  Map<String, dynamic> toJson() => {'total': total, 'data': data};
}
