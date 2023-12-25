class AlbumsDetails {
  AlbumsDetails(
      {this.album_id,
      this.user_id,
      this.user_type,
      this.in_group,
      this.group_id,
      this.title,
      this.privacy,
      this.in_event,
      this.event_id,
      this.user_name,
      this.user_album_pictures,
      this.user_album_covers,
      this.user_album_timeline,
      this.page_id,
      this.page_name,
      this.page_admin,
      this.page_album_pictures,
      this.page_album_covers,
      this.page_album_timeline,
      this.group_name,
      this.group_admin,
      this.group_album_pictures,
      this.group_album_covers,
      this.group_album_timeline,
      this.author_id,
      this.path,
      this.can_delete,
      this.cover,
      this.photos_count,
      this.is_page_admin,
      this.is_group_admin,
      this.manage_album});

  String? album_id;
  String? user_id;
  String? user_type;
  String? in_group;
  String? group_id;
  String? title;
  String? privacy;
  String? in_event;
  String? event_id;
  String? user_name;
  String? user_album_pictures;
  String? user_album_covers;
  String? user_album_timeline;
  String? page_id;
  String? page_name;
  String? page_admin;
  String? page_album_pictures;
  String? page_album_covers;
  String? page_album_timeline;
  String? group_name;
  String? group_admin;
  String? group_album_pictures;
  String? group_album_covers;
  String? group_album_timeline;
  String? author_id;
  String? path;
  String? can_delete;
  String? cover;
  String? photos_count;
  String? is_page_admin;
  String? is_group_admin;
  String? manage_album;

  factory AlbumsDetails.fromJson(Map<String, dynamic>? json) {
    return AlbumsDetails(
      album_id: json?["album_id"] == null ? null : json?['album_id'] as String,
      user_id: json?["user_id"] == null ? null : json?['user_id'] as String,
      user_type:
          json?["user_type"] == null ? null : json?['user_type'] as String,
      in_group: json?["in_group"] == null ? null : json?['in_group'] as String,
      group_id: json?["group_id"] == null ? null : json?['group_id'] as String,
      title: json?["title"] == null ? null : json?['title'] as String,
      privacy: json?["privacy"] == null ? null : json?['privacy'] as String,
      in_event: json?["in_event"] == null ? null : json?['in_event'] as String,
      event_id: json?["event_id"] == null ? null : json?['event_id'] as String,
      user_name:
          json?["user_name"] == null ? null : json?['user_name'] as String,
      user_album_pictures: json?["user_album_pictures"] == null
          ? null
          : json?['user_album_pictures'] as String,
      user_album_covers: json?["user_album_covers"] == null
          ? null
          : json?['user_album_covers'] as String,
      user_album_timeline: json?["user_album_timeline"] == null
          ? null
          : json?['user_album_timeline'] as String,
      page_id: json?["page_id"] == null ? null : json?['page_id'] as String,
      page_name:
          json?["page_name"] == null ? null : json?['page_name'] as String,
      page_admin:
          json?["page_admin"] == null ? null : json?['page_admin'] as String,
      page_album_pictures: json?["page_album_pictures"] == null
          ? null
          : json?['page_album_pictures'] as String,
      page_album_covers: json?["page_album_covers"] == null
          ? null
          : json?['page_album_covers'] as String,
      page_album_timeline: json?["page_album_timeline"] == null
          ? null
          : json?['page_album_timeline'] as String,
      group_name:
          json?["group_name"] == null ? null : json?['group_name'] as String,
      group_admin:
          json?["group_admin"] == null ? null : json?['group_admin'] as String,
      group_album_pictures: json?["group_album_pictures"] == null
          ? null
          : json?['group_album_pictures'] as String,
      group_album_covers: json?["group_album_covers"] == null
          ? null
          : json?['group_album_covers'] as String,
      group_album_timeline: json?["group_album_timeline"] == null
          ? null
          : json?['group_album_timeline'] as String,
      author_id:
          json?["author_id"] == null ? null : json?['author_id'] as String,
      path: json?["path"] == null ? null : json?['path'] as String,
      can_delete:
          json?["can_delete"] == null ? null : json?['can_delete'] as String,
      cover: json?["cover"] == null ? null : json?['cover'] as String,
      photos_count: json?["photos_count"] == null
          ? null
          : json?['photos_count'] as String,
      is_page_admin: json?["is_page_admin"] == null
          ? null
          : json?['is_page_admin'] as String,
      is_group_admin: json?["is_group_admin"] == null
          ? null
          : json?['is_group_admin'] as String,
      manage_album: json?["manage_album"] == null
          ? null
          : json?['manage_album'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "album_id": album_id,
        "user_id": user_id,
        "user_type": user_type,
        "in_group": in_group,
        "group_id": group_id,
        "title": title,
        "privacy": privacy,
        "in_event": in_event,
        "event_id": event_id,
        "user_name": user_name,
        "user_album_pictures": user_album_pictures,
        "user_album_covers": user_album_covers,
        "user_album_timeline": user_album_timeline,
        "page_id": page_id,
        "page_name": page_name,
        "page_admin": page_admin,
        "page_album_pictures": page_album_pictures,
        "page_album_covers": page_album_covers,
        "page_album_timeline": page_album_timeline,
        "group_name": group_name,
        "group_admin": group_admin,
        "group_album_pictures": group_album_pictures,
        "group_album_covers": group_album_covers,
        "group_album_timeline": group_album_timeline,
        "author_id": author_id,
        "path": path,
        "can_delete": can_delete,
        "cover": cover,
        "photos_count": photos_count,
        "is_page_admin": is_page_admin,
        "is_group_admin": is_group_admin,
        "manage_album": manage_album
      };
}
