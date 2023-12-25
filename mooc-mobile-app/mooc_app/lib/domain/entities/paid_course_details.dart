class PaidCourseDetails {
  PaidCourseDetails({
    required this.id,
    this.name,
    this.categoryName,
    this.teacherName,
    this.completePercent,
    this.thumbnailFileUrl,
    this.isComplete,
    this.status,
    this.time,
    this.totalCompleteLessons,
    this.totalLessons,
    this.slug,
  });

  int id;
  String? name;
  String? categoryName;
  String? teacherName;
  String? completePercent;
  String? thumbnailFileUrl;
  int? isComplete;
  int? status;
  String? time;
  int? totalCompleteLessons;
  int? totalLessons;
  String? slug;

  factory PaidCourseDetails.fromJson(Map<String, dynamic>? json) {
    return PaidCourseDetails(
      id : json?['id'] as int,
      name : json?['name'] == null ? null : json?['name'] as String,
      categoryName : json?['categoryName'] == null ? null : json?['categoryName'] as String,
      teacherName : json?['teacherName'] == null ? null : json?['teacherName'] as String,
      completePercent : json?['completePercent'] == null ? null : json?['completePercent'] as String,
      thumbnailFileUrl : json?['thumbnailFileUrl'] == null ? null : json?['thumbnailFileUrl'] as String,
      isComplete : json?["isComplete"] == null ? null : json?['isComplete'] as int,
      status : json?["status"] == null ? null : json?['status'] as int,
      time : json?['time'] == null ? null : json?['time'] as String,
      totalCompleteLessons : json?['totalCompleteLessons'] == null ? null : json?['totalCompleteLessons'] as int,
      totalLessons : json?['totalLessons'] == null ? null : json?['totalLessons'] as int,
      slug : json?['slug'] == null ? null : json?['slug'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "categoryName": categoryName,
    "teacherName": teacherName,
    "completePercent": completePercent,
    "thumbnailFileUrl": thumbnailFileUrl,
    "isComplete": isComplete,
    "status": status,
    "time": time,
    "totalCompleteLessons": totalCompleteLessons,
    "totalLessons": totalLessons,
    "slug": slug,
  };
}