class DataTuitionChilds {
  DataTuitionChilds({
    this.tuition_child_id,
    this.total_amount,
    this.status,
    this.child_name,
  });

  String? tuition_child_id;
  String? total_amount;
  String? status;
  String? child_name;

  factory DataTuitionChilds.fromJson(Map<String, dynamic>? json) {
    return DataTuitionChilds(
      tuition_child_id: json?["tuition_child_id"] == null ? null : json?['tuition_child_id'] as String,
      total_amount: json?["total_amount"] == null ? null : json?['total_amount'] as String,
      status: json?["status"] == null ? null : json?['status'] as String,
      child_name: json?["child_name"] == null ? null : json?['child_name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
      'tuition_child_id': tuition_child_id,
      'total_amount': total_amount,
      'status': status,
      'child_name': child_name,
  };
}
