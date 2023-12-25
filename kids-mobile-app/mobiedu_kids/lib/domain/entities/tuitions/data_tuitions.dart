class DataTuitions {
  DataTuitions({
    this.tuition_id,
    this.paid_amount,
    this.total_amount,
    this.paid_count,
    this.month,
    this.count_child,
    this.tuition_child_id
  });

  String? tuition_id;
  String? paid_amount;
  String? total_amount;
  String? paid_count;
  String? month;
  String? count_child;
  String? tuition_child_id;

  factory DataTuitions.fromJson(Map<String, dynamic>? json) {
    return DataTuitions(
      tuition_id: json?["tuition_id"] == null ? null : json?['tuition_id'] as String,
      paid_amount: json?["paid_amount"] == null ? null : json?['paid_amount'] as String,
      total_amount: json?["total_amount"] == null ? null : json?['total_amount'] as String,
      paid_count: json?["paid_count"] == null ? null : json?['paid_count'] as String,
      month: json?["month"] == null ? null : json?['month'] as String,
      count_child: json?["count_child"] == null ? null : json?['count_child'] as String,
      tuition_child_id: json?["tuition_child_id"] == null ? null : json?['tuition_child_id'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
      'tuition_id': tuition_id,
      'paid_amount': paid_amount,
      'total_amount': total_amount,
      'paid_count': paid_count,
      'month': month,
      'count_child': count_child,
      'tuition_child_id': tuition_child_id
  };
}
