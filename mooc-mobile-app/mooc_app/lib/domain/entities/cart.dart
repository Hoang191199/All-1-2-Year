class Cart {

  Cart({
    this.id,
    required this.course_id,
    this.user_id,
  });
  
  int? id;
  int course_id;
  int? user_id;

  factory Cart.fromJson(Map<String, dynamic>? json) {
    return Cart(
      id: json?['id'] as int,
      course_id: json?['course_id'] as int,
      user_id: json?['user_id'] == null ? null : json?['user_id'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'course_id': course_id,
    'user_id': user_id,
  };
}