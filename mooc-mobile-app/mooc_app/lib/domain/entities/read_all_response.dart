class ReadAll {
  ReadAll({
    this.message,
    this.status,
    this.error,
    this.row_affected,
  });

  String? message;
  bool? status;
  bool? error;
  int? row_affected;

  factory ReadAll.fromJson(Map<String, dynamic>? json) {
    return ReadAll(
      message: json?['message'] == null ? null : json?['message'] as String,
      status: json?['status'] == null ? null : json?['status'] as bool,
      error: json?['error'] == null ? null : json?['error'] as bool,
      row_affected: json?['row_affected'] == null ? null : json?['row_affected'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'status': status,
    'error': error,
    'row_affected': row_affected,
  };
}