class InfoAttendance {
  InfoAttendance({
    this.source_file, 
    this.updated_at,
    this.came_back_time
  }
);

String? source_file;
String? updated_at;
String? came_back_time;

factory InfoAttendance.fromJson(Map<String, dynamic>? json) {
    return InfoAttendance(
      source_file: json?["source_file"] == null ? null : json?['source_file'] as String,
      updated_at: json?["updated_at"] == null ? null : json?['updated_at'] as String,
      came_back_time: json?["came_back_time"] == null ? null : json?['came_back_time'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'source_file': source_file,
    'updated_at': updated_at,
    'came_back_time': came_back_time
  };
}
