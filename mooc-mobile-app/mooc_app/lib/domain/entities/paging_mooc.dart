class PagingMooc {
  PagingMooc({
  required this.total,
  required this.per_page,
  required this.current_page,
  required this.last_page,
  required this.from,
  required this.to,
  });

  int total;
  int per_page;
  int current_page;
  int last_page ;
  int from;
  int to;

  factory PagingMooc.fromJson(Map<String, dynamic>? json) {
    return PagingMooc(
      total: json?['total'] as int,
      per_page: json?['per_page'] as int,
      current_page: json?['current_page'] as int,
      last_page: json?['last_page'] as int,
      from: json?['from'] as int,
      to: json?['to'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    "total": total,
    "per_page": per_page,
    "current_page": current_page,
    "last_page": last_page,
    "from": from,
    "to": to
  };
}