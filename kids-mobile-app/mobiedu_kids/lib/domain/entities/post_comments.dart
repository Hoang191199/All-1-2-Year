class PostComments {
  PostComments(
      {this.comment_id,
      this.node_id,
      this.node_type,
      this.user_id,
      this.user_type,
      this.text,
      this.image,
      this.time,
      this.likes,
      this.replies,
      this.user_name,
      this.user_fullname,
      this.user_firstname,
      this.user_lastname,
      this.user_gender,
      this.user_picture,
      this.user_verified,
      this.page_id,
      this.page_admin,
      this.page_category,
      this.page_name,
      this.page_title,
      this.page_description,
      this.page_picture,
      this.page_picture_id,
      this.page_cover,
      this.page_cover_id,
      this.page_album_pictures,
      this.page_album_covers,
      this.page_album_timeline,
      this.page_pinned_post,
      this.page_verified,
      this.page_likes,
      this.views_in_thirty_days,
      this.city_id,
      this.telephone,
      this.website,
      this.email,
      this.address,
      this.page_date,
      this.page_boosted,
      this.page_boosted_by,
      this.page_company,
      this.page_phone,
      this.page_website,
      this.page_location,
      this.page_action_text,
      this.page_action_color,
      this.page_action_url,
      this.page_social_facebook,
      this.page_social_twitter,
      this.page_social_google,
      this.page_social_youtube,
      this.page_social_instagram,
      this.page_social_linkedin,
      this.page_social_vkontakte,
      this.text_plain,
      this.author_id,
      this.author_picture,
      this.author_url,
      this.author_name,
      this.author_verified,
      this.edit_comment,
      this.delete_comment});

  String? comment_id;
  String? node_id;
  String? node_type;
  String? user_id;
  String? user_type;
  String? text;
  String? image;
  String? time;
  String? likes;
  String? replies;
  String? user_name;
  String? user_fullname;
  String? user_firstname;
  String? user_lastname;
  String? user_gender;
  String? user_picture;
  String? user_verified;
  String? page_id;
  String? page_admin;
  String? page_category;
  String? page_name;
  String? page_title;
  String? page_description;
  String? page_picture;
  String? page_picture_id;
  String? page_cover;
  String? page_cover_id;
  String? page_album_pictures;
  String? page_album_covers;
  String? page_album_timeline;
  String? page_pinned_post;
  String? page_verified;
  String? page_likes;
  String? views_in_thirty_days;
  String? city_id;
  String? telephone;
  String? website;
  String? email;
  String? address;
  String? page_date;
  String? page_boosted;
  String? page_boosted_by;
  String? page_company;
  String? page_phone;
  String? page_website;
  String? page_location;
  String? page_action_text;
  String? page_action_color;
  String? page_action_url;
  String? page_social_facebook;
  String? page_social_twitter;
  String? page_social_google;
  String? page_social_youtube;
  String? page_social_instagram;
  String? page_social_linkedin;
  String? page_social_vkontakte;
  String? text_plain;
  String? author_id;
  String? author_picture;
  String? author_url;
  String? author_name;
  String? author_verified;
  bool? edit_comment;
  bool? delete_comment;

  factory PostComments.fromJson(Map<String, dynamic>? json) {
    return PostComments(
      comment_id:
          json?["comment_id"] == null ? null : json?['comment_id'] as String,
      node_id: json?["node_id"] == null ? null : json?['node_id'] as String,
      node_type:
          json?["node_type"] == null ? null : json?['node_type'] as String,
      user_id: json?["user_id"] == null ? null : json?['user_id'] as String,
      user_type:
          json?["user_type"] == null ? null : json?['user_type'] as String,
      text: json?["text"] == null ? null : json?['text'] as String,
      image: json?["image"] == null ? null : json?['image'] as String,
      time: json?["time"] == null ? null : json?['time'] as String,
      likes: json?["likes"] == null ? null : json?['likes'] as String,
      replies: json?["replies"] == null ? null : json?['replies'] as String,
      user_name:
          json?["user_name"] == null ? null : json?['user_name'] as String,
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
      user_verified: json?["child_journal_album_id"] == null
          ? null
          : json?['child_journal_album_id'] as String,
      page_id: json?["page_id"] == null ? null : json?['page_id'] as String,
      page_admin:
          json?["page_admin"] == null ? null : json?['page_admin'] as String,
      page_category: json?["page_category"] == null
          ? null
          : json?['page_category'] as String,
      page_name:
          json?["page_name"] == null ? null : json?['page_name'] as String,
      page_title:
          json?["page_title"] == null ? null : json?['page_title'] as String,
      page_description: json?["page_description"] == null
          ? null
          : json?['page_description'] as String,
      page_picture: json?["page_picture"] == null
          ? null
          : json?['page_picture'] as String,
      page_picture_id: json?["page_picture_id"] == null
          ? null
          : json?['page_picture_id'] as String,
      page_cover:
          json?["page_cover"] == null ? null : json?['page_cover'] as String,
      page_cover_id: json?["page_cover_id"] == null
          ? null
          : json?['page_cover_id'] as String,
      page_album_pictures: json?["page_album_pictures"] == null
          ? null
          : json?['page_album_pictures'] as String,
      page_album_covers: json?["page_album_covers"] == null
          ? null
          : json?['page_album_covers'] as String,
      page_album_timeline: json?["page_album_timeline"] == null
          ? null
          : json?['page_album_timeline'] as String,
      page_pinned_post: json?["page_pinned_post"] == null
          ? null
          : json?['page_pinned_post'] as String,
      page_verified: json?["page_verified"] == null
          ? null
          : json?['page_verified'] as String,
      page_likes:
          json?["page_likes"] == null ? null : json?['page_likes'] as String,
      views_in_thirty_days: json?["views_in_thirty_days"] == null
          ? null
          : json?['views_in_thirty_days'] as String,
      city_id: json?["city_id"] == null ? null : json?['city_id'] as String,
      telephone:
          json?["telephone"] == null ? null : json?['telephone'] as String,
      website: json?["website"] == null ? null : json?['website'] as String,
      email: json?["email"] == null ? null : json?['email'] as String,
      address: json?["address"] == null ? null : json?['address'] as String,
      page_date:
          json?["page_date"] == null ? null : json?['page_date'] as String,
      page_boosted: json?["page_boosted"] == null
          ? null
          : json?['page_boosted'] as String,
      page_boosted_by: json?["page_boosted_by"] == null
          ? null
          : json?['page_boosted_by'] as String,
      page_company: json?["page_company"] == null
          ? null
          : json?['page_company'] as String,
      page_phone:
          json?["page_phone"] == null ? null : json?['page_phone'] as String,
      page_website: json?["page_website"] == null
          ? null
          : json?['page_website'] as String,
      page_location: json?["page_location"] == null
          ? null
          : json?['page_location'] as String,
      page_action_text: json?["page_action_text"] == null
          ? null
          : json?['page_action_text'] as String,
      page_action_color: json?["page_action_color"] == null
          ? null
          : json?['page_action_color'] as String,
      page_action_url: json?["page_action_url"] == null
          ? null
          : json?['page_action_url'] as String,
      page_social_facebook: json?["page_social_facebook"] == null
          ? null
          : json?['page_social_facebook'] as String,
      page_social_twitter: json?["page_social_twitter"] == null
          ? null
          : json?['page_social_twitter'] as String,
      page_social_google: json?["page_social_google"] == null
          ? null
          : json?['page_social_google'] as String,
      page_social_youtube: json?["page_social_youtube"] == null
          ? null
          : json?['page_social_youtube'] as String,
      page_social_instagram: json?["page_social_instagram"] == null
          ? null
          : json?['page_social_instagram'] as String,
      page_social_linkedin: json?["page_social_linkedin"] == null
          ? null
          : json?['page_social_linkedin'] as String,
      page_social_vkontakte: json?["page_social_vkontakte"] == null
          ? null
          : json?['page_social_vkontakte'] as String,
      text_plain:
          json?["text_plain"] == null ? null : json?['text_plain'] as String,
      author_id:
          json?["author_id"] == null ? null : json?['author_id'] as String,
      author_picture: json?["author_picture"] == null
          ? null
          : json?['author_picture'] as String,
      author_url:
          json?["author_url"] == null ? null : json?['author_url'] as String,
      author_name:
          json?["author_name"] == null ? null : json?['author_name'] as String,
      author_verified: json?["author_verified"] == null
          ? null
          : json?['author_verified'] as String,
      edit_comment: json?["edit_comment"] == null
          ? null
          : json?['edit_comment'] as bool,
      delete_comment: json?["delete_comment"] == null
          ? null
          : json?['delete_comment'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        "comment_id": comment_id,
        "node_id": node_id,
        "node_type": node_type,
        "user_id": user_id,
        "user_type": user_type,
        "text": text,
        "image": image,
        "time": time,
        "likes": likes,
        "replies": replies,
        "user_name": user_name,
        "user_fullname": user_fullname,
        "user_firstname": user_firstname,
        "user_lastname": user_lastname,
        "user_gender": user_gender,
        "user_picture": user_picture,
        "user_verified": user_verified,
        "page_id": page_id,
        "page_admin": page_admin,
        "page_category": page_category,
        "page_name": page_name,
        "page_title": page_title,
        "page_description": page_description,
        "page_picture": page_picture,
        "page_picture_id": page_picture_id,
        "page_cover": page_cover,
        "page_cover_id": page_cover_id,
        "page_album_pictures": page_album_pictures,
        "page_album_covers": page_album_covers,
        "page_album_timeline": page_album_timeline,
        "page_pinned_post": page_pinned_post,
        "page_verified": page_verified,
        "page_likes": page_likes,
        "views_in_thirty_days": views_in_thirty_days,
        "city_id": city_id,
        "telephone": telephone,
        "website": website,
        "email": email,
        "address": address,
        "page_date": page_date,
        "page_boosted": page_boosted,
        "page_boosted_by": page_boosted_by,
        "page_company": page_company,
        "page_phone": page_phone,
        "page_website": page_website,
        "page_location": page_location,
        "page_action_text": page_action_text,
        "page_action_color": page_action_color,
        "page_action_url": page_action_url,
        "page_social_facebook": page_social_facebook,
        "page_social_twitter": page_social_twitter,
        "page_social_google": page_social_google,
        "page_social_youtube": page_social_youtube,
        "page_social_instagram": page_social_instagram,
        "page_social_linkedin": page_social_linkedin,
        "page_social_vkontakte": page_social_vkontakte,
        "text_plain": text_plain,
        "author_id": author_id,
        "author_picture": author_picture,
        "author_url": author_url,
        "author_name": author_name,
        "author_verified": author_verified,
        "edit_comment": edit_comment,
        "delete_comment": delete_comment
      };
}
