class User {
  User({
    this.user_id,
    this.user_group,
    this.user_name,
    this.user_fullname,
    this.user_firstname,
    this.user_lastname,
    this.user_gender,
    this.user_picture,
    this.user_cover,
    this.connection,
    this.user_email,
    this.user_phone,
    this.is_admin,
    this.we_friends,
    this.i_follow,
    this.i_request,
    this.allow_user_post_on_wall,
    this.user_birthdate,
    this.user_work_title,
    this.user_work_place,
    this.user_current_city,
    this.user_hometown,
    this.user_edu_major,
    this.user_edu_school,
    this.user_edu_class,
  });

  String? user_id;
  String? user_group;
  String? user_name;
  String? user_fullname;
  String? user_firstname;
  String? user_lastname;
  String? user_gender;
  String? user_picture;
  String? user_cover;
  String? connection;
  String? user_email;
  String? user_phone;
  bool? is_admin;
  bool? we_friends;
  bool? i_follow;
  bool? i_request;
  bool? allow_user_post_on_wall;
  String? user_birthdate;
  String? user_work_title;
  String? user_work_place;
  String? user_current_city;
  String? user_hometown;
  String? user_edu_major;
  String? user_edu_school;
  String? user_edu_class;

  factory User.fromJson(Map<String, dynamic>? json) {
    return User(
      user_id: json?["user_id"] == null ? null : json?['user_id'] as String,
      user_group: json?["user_group"] == null ? null : json?['user_group'] as String,
      user_name: json?["user_name"] == null ? null : json?['user_name'] as String,
      user_fullname: json?["user_fullname"] == null ? null : json?['user_fullname'] as String,
      user_firstname: json?["user_firstname"] == null ? null : json?['user_firstname'] as String,
      user_lastname: json?["user_lastname"] == null ? null : json?['user_lastname'] as String,
      user_gender: json?["user_gender"] == null ? null : json?['user_gender'] as String,
      user_picture: json?["user_picture"] == null ? null : json?['user_picture'] as String,
      user_cover: json?["user_cover"] == null ? null : json?['user_cover'] as String,
      connection: json?["connection"] == null ? null : json?['connection'] as String,
      user_email: json?["user_email"] == null ? null : json?['user_email'] as String,
      user_phone: json?["user_phone"] == null ? null : json?['user_phone'] as String,
      is_admin: json?["is_admin"] == null ? false : json?['is_admin'] as bool,
      we_friends: json?["we_friends"] == null ? false : json?['we_friends'] as bool,
      i_follow: json?["i_follow"] == null ? false : json?['i_follow'] as bool,
      i_request: json?["i_request"] == null ? false : json?['i_request'] as bool,
      allow_user_post_on_wall: json?["allow_user_post_on_wall"] == null ? false : json?['allow_user_post_on_wall'] as bool,
      user_birthdate: json?["user_birthdate"] == null ? null : json?['user_birthdate'] as String,
      user_work_title: json?["user_work_title"] == null ? null : json?['user_work_title'] as String,
      user_work_place: json?["user_work_place"] == null ? null : json?['user_work_place'] as String,
      user_current_city: json?["user_current_city"] == null ? null : json?['user_current_city'] as String,
      user_hometown: json?["user_hometown"] == null ? null : json?['user_hometown'] as String,
      user_edu_major: json?["user_edu_major"] == null ? null : json?['user_edu_major'] as String,
      user_edu_school: json?["user_edu_school"] == null ? null : json?['user_edu_school'] as String,
      user_edu_class: json?["user_edu_class"] == null ? null : json?['user_edu_class'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'user_id': user_id,
    'user_group': user_group,
    'user_name': user_name,
    'user_fullname': user_fullname,
    'user_firstname': user_firstname,
    'user_lastname': user_lastname,
    'user_gender': user_gender,
    'user_picture': user_picture,
    'user_cover': user_cover,
    'connection': connection,
    'user_email': user_email,
    'user_phone': user_phone,
    'is_admin': is_admin,
    'we_friends': we_friends,
    'i_follow': i_follow,
    'i_request': i_request,
    'allow_user_post_on_wall': allow_user_post_on_wall,
    'user_birthdate': user_birthdate,
    'user_work_title': user_work_title,
    'user_work_place': user_work_place,
    'user_current_city': user_current_city,
    'user_hometown': user_hometown,
    'user_edu_major': user_edu_major,
    'user_edu_school': user_edu_school,
    'user_edu_class': user_edu_class,
  };
}