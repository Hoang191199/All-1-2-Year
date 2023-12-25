import 'package:mobiedu_kids/domain/entities/mutual_friend.dart';

class ProfileDetails {
  ProfileDetails(
      {this.user_id,
      this.user_group,
      this.user_name,
      this.user_email,
      this.user_email_activation,
      this.user_phone,
      this.user_phone_signin,
      this.user_id_card_number,
      this.date_of_issue,
      this.place_of_issue,
      this.city_id,
      this.user_fullname,
      this.user_firstname,
      this.user_lastname,
      this.user_gender,
      this.user_picture,
      this.user_picture_id,
      this.user_cover,
      this.user_cover_id,
      this.user_pinned_post,
      this.user_work_title,
      this.user_work_place,
      this.user_current_city,
      this.user_hometown,
      this.user_edu_major,
      this.user_edu_school,
      this.user_edu_class,
      this.user_birthdate,
      this.user_activated,
      this.user_privacy_wall,
      this.user_privacy_birthdate,
      this.user_privacy_work,
      this.user_privacy_location,
      this.user_privacy_education,
      this.user_privacy_friends,
      this.user_privacy_photos,
      this.user_privacy_pages,
      this.user_privacy_groups,
      this.allow_user_post_on_wall,
      this.user_picture_default,
      this.is_admin,
      this.we_friends,
      this.he_request,
      this.i_request,
      this.i_follow,
      this.mutual_friends_count,
      this.mutual_friends});

  String? user_id;
  String? user_group;
  String? user_name;
  String? user_email;
  String? user_email_activation;
  String? user_phone;
  String? user_phone_signin;
  String? user_id_card_number;
  String? date_of_issue;
  String? place_of_issue;
  String? city_id;
  String? user_fullname;
  String? user_firstname;
  String? user_lastname;
  String? user_gender;
  String? user_picture;
  String? user_picture_id;
  String? user_cover;
  String? user_cover_id;
  String? user_pinned_post;
  String? user_work_title;
  String? user_work_place;
  String? user_current_city;
  String? user_hometown;
  String? user_edu_major;
  String? user_edu_school;
  String? user_edu_class;
  String? user_birthdate;
  String? user_activated;
  String? user_privacy_wall;
  String? user_privacy_birthdate;
  String? user_privacy_work;
  String? user_privacy_location;
  String? user_privacy_education;
  String? user_privacy_friends;
  String? user_privacy_photos;
  String? user_privacy_pages;
  String? user_privacy_groups;
  bool? allow_user_post_on_wall;
  bool? user_picture_default;
  bool? is_admin;
  bool? we_friends;
  bool? he_request;
  bool? i_request;
  bool? i_follow;
  int? mutual_friends_count;
  List<MutualFriend>? mutual_friends;

  factory ProfileDetails.fromJson(Map<String, dynamic>? json) {
    return ProfileDetails(
      user_id: json?["user_id"] == null ? null : json?['user_id'] as String,
      user_group:
          json?["user_group"] == null ? null : json?['user_group'] as String,
      user_name:
          json?["user_name"] == null ? null : json?['user_name'] as String,
      user_email:
          json?["user_email"] == null ? null : json?['user_email'] as String,
      user_email_activation: json?["user_email_activation"] == null
          ? null
          : json?['user_email_activation'] as String,
      user_phone:
          json?["user_phone"] == null ? null : json?['user_phone'] as String,
      user_phone_signin: json?["user_phone_signin"] == null
          ? null
          : json?['user_phone_signin'] as String,
      user_id_card_number: json?["user_id_card_number"] == null
          ? null
          : json?['user_id_card_number'] as String,
      date_of_issue: json?["date_of_issue"] == null
          ? null
          : json?['date_of_issue'] as String,
      place_of_issue: json?["place_of_issue"] == null
          ? null
          : json?['place_of_issue'] as String,
      city_id: json?["city_id"] == null ? null : json?['city_id'] as String,
      user_fullname: json?["user_fullname"] == null
          ? null
          : json?['user_fullname'] as String,
      user_firstname: json?["user_firstname"] == null
          ? null
          : json?['user_firstname'] as String,
      user_lastname: json?["user_lastname"] == null
          ? null
          : json?['user_lastname'] as String,
      user_gender:
          json?["user_gender"] == null ? null : json?['user_gender'] as String,
      user_picture: json?["user_picture"] == null
          ? null
          : json?['user_picture'] as String,
      user_picture_id: json?["user_picture_id"] == null
          ? null
          : json?['user_picture_id'] as String,
      user_cover:
          json?["user_cover"] == null ? null : json?['user_cover'] as String,
      user_cover_id: json?["user_cover_id"] == null
          ? null
          : json?['user_cover_id'] as String,
      user_pinned_post: json?["user_pinned_post"] == null
          ? null
          : json?['user_pinned_post'] as String,
      user_work_title: json?["user_work_title"] == null
          ? null
          : json?['user_work_title'] as String,
      user_work_place: json?["user_work_place"] == null
          ? null
          : json?['user_work_place'] as String,
      user_current_city: json?["user_current_city"] == null
          ? null
          : json?['user_current_city'] as String,
      user_hometown: json?["user_hometown"] == null
          ? null
          : json?['user_hometown'] as String,
      user_edu_major: json?["user_edu_major"] == null
          ? null
          : json?['user_edu_major'] as String,
      user_edu_school: json?["user_edu_school"] == null
          ? null
          : json?['user_edu_school'] as String,
      user_edu_class: json?["user_edu_class"] == null
          ? null
          : json?['user_edu_class'] as String,
      user_birthdate: json?["user_birthdate"] == null
          ? null
          : json?['user_birthdate'] as String,
      user_activated: json?["user_activated"] == null
          ? null
          : json?['user_activated'] as String,
      user_privacy_wall: json?["user_privacy_wall"] == null
          ? null
          : json?['user_privacy_wall'] as String,
      user_privacy_birthdate: json?["user_privacy_birthdate"] == null
          ? null
          : json?['user_privacy_birthdate'] as String,
      user_privacy_work: json?["user_privacy_work"] == null
          ? null
          : json?['user_privacy_work'] as String,
      user_privacy_location: json?["user_privacy_location"] == null
          ? null
          : json?['user_privacy_location'] as String,
      user_privacy_education: json?["user_privacy_education"] == null
          ? null
          : json?['user_privacy_education'] as String,
      user_privacy_friends: json?["user_privacy_friends"] == null
          ? null
          : json?['user_privacy_friends'] as String,
      user_privacy_photos: json?["user_privacy_photos"] == null
          ? null
          : json?['user_privacy_photos'] as String,
      user_privacy_pages: json?["user_privacy_pages"] == null
          ? null
          : json?['user_privacy_pages'] as String,
      user_privacy_groups: json?["user_privacy_groups"] == null
          ? null
          : json?['user_privacy_groups'] as String,
      allow_user_post_on_wall: json?["allow_user_post_on_wall"] == null
          ? null
          : json?['allow_user_post_on_wall'] as bool,
      user_picture_default: json?["user_picture_default"] == null
          ? null
          : json?['user_picture_default'] as bool,
      is_admin: json?["is_admin"] == null ? null : json?['is_admin'] as bool,
      we_friends:
          json?["we_friends"] == null ? null : json?['we_friends'] as bool,
      he_request:
          json?["he_request"] == null ? null : json?['he_request'] as bool,
      i_request: json?["i_request"] == null ? null : json?['i_request'] as bool,
      i_follow: json?["i_follow"] == null ? null : json?['i_follow'] as bool,
      mutual_friends_count: json?["mutual_friends_count"] == null
          ? null
          : json?['mutual_friends_count'] as int,
      mutual_friends: json?['mutual_friends'] == null
          ? null
          : List<MutualFriend>.from(
              json?["mutual_friends"].map((x) => MutualFriend.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "user_id": user_id,
        "user_group": user_group,
        "user_name": user_name,
        "user_email": user_email,
        "user_email_activation": user_email_activation,
        "user_phone": user_phone,
        "user_phone_signin": user_phone_signin,
        "user_id_card_number": user_id_card_number,
        "date_of_issue": date_of_issue,
        "place_of_issue": place_of_issue,
        "city_id": city_id,
        "user_fullname": user_fullname,
        "user_firstname": user_firstname,
        "user_lastname": user_lastname,
        "user_gender": user_gender,
        "user_picture": user_picture,
        "user_picture_id": user_picture_id,
        "user_cover": user_cover,
        "user_cover_id": user_cover_id,
        "user_pinned_post": user_pinned_post,
        "user_work_title": user_work_title,
        "user_work_place": user_work_place,
        "user_current_city": user_current_city,
        "user_hometown": user_hometown,
        "user_edu_major": user_edu_major,
        "user_edu_school": user_edu_school,
        "user_edu_class": user_edu_class,
        "user_birthdate": user_birthdate,
        "user_activated": user_activated,
        "user_privacy_wall": user_privacy_wall,
        "user_privacy_birthdate": user_privacy_birthdate,
        "user_privacy_work": user_privacy_work,
        "user_privacy_location": user_privacy_location,
        "user_privacy_education": user_privacy_education,
        "user_privacy_friends": user_privacy_friends,
        "user_privacy_photos": user_privacy_photos,
        "user_privacy_pages": user_privacy_pages,
        "user_privacy_groups": user_privacy_groups,
        "allow_user_post_on_wall": allow_user_post_on_wall,
        "user_picture_default": user_picture_default,
        "is_admin": is_admin,
        "we_friends": we_friends,
        "he_request": he_request,
        "i_request": i_request,
        "i_follow": i_follow,
        "mutual_friends_count": mutual_friends_count,
        "mutual_friends": mutual_friends
      };
}
