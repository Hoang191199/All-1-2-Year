class ListAttendance {
  ListAttendance({
    this.attendance_date,
    this.is_checked,
    this.status,
    this.feedback
  });
  String? attendance_date;
  String? is_checked;
  String? status;
  String? feedback;

  factory ListAttendance.fromJson(Map<String, dynamic>? json) {
  return ListAttendance(
    attendance_date: json?["attendance_date"] == null ? null : json?['attendance_date'] as String,
    is_checked: json?["is_checked"] == null ? null : json?['is_checked'] as String,
    status: json?["status"] == null ? null : json?['status'] as String,
    feedback: json?["feedback"] == null ? null : json?['feedback'] as String,
  );
  }

  Map<String, dynamic> toJson() => {
    'attendance_date': attendance_date,
    'is_checked': is_checked,
    'status': status,
    'feedback': feedback
  };

}