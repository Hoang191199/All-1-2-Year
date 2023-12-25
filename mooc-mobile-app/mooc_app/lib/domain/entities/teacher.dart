class Teacher {
  Teacher({
    required this.name,
    this.avatar,
    this.description,
    this.aliasName,
    this.totalCourses,
    this.totalStudents,
  });

  String name;
  String? avatar;
  String? description;
  String? aliasName;
  int? totalCourses;
  int? totalStudents;

  factory Teacher.fromJson(Map<String, dynamic>? json) {
    return Teacher(
      name: json?['name'] as String,
      avatar: json?["avatar"] == null ? null : json?['avatar'] as String,
      description: json?["description"] == null ? null : json?['description'] as String,
      aliasName: json?["aliasName"] == null ? null : json?['aliasName'] as String,
      totalCourses: json?["totalCourses"] == null ? null : json?['totalCourses'] as int,
      totalStudents: json?["totalStudents"] == null ? null : json?['totalStudents'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'avatar': avatar,
        'description': description,
        'aliasName': aliasName,
        'totalCourses': totalCourses,
        'totalStudents': totalStudents,
      };
}