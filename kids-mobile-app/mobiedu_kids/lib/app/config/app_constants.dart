class UserRole {
  static const String owner = 'owner';
  static const String teacher = 'teacher';
  static const String student = 'student';
}

class DataType {
  static const String typeString = 'string';
  static const String typeInt = 'int';
  static const String typeDouble = 'double';
  static const String typeBool = 'bool';
  static const String typeObject = 'object';
}

class SnackbarType {
  static const String success = 'success';
  static const String notice = 'notice';
  static const String error = 'error';
}

class TemplateType {
  static const String carousel = 'carousel';
  static const String focus = 'focus';
}

class BookcaseType {
  static const String digital_publications = 'digital_publications';
  static const String publications = 'publications';
  static const String document = 'document';
}

class BookcaseViewType {
  static const String grid = 'grid';
  static const String list = 'list';
}

class BookcaseSortType {
  static const String title = 'title';
  static const String authors = 'authors';
  static const String created_at = 'created_at';
  static const String last_seen = 'last_seen';
}

class BookcaseFilterType {
  static const int notRead = 0;
  static const int reading = 1;
  static const int readCompleted = 2;
}

class MediaType {
  static const String application_xhtml_xml = 'application/xhtml+xml';
  static const String application_x_dtbook_xml = 'application/x-dtbook+xml';
  static const String application_x_dtbncx_xml = 'application/x-dtbncx+xml';
  static const String text_x_oeb1_document = 'text/x-oeb1-document';
  static const String application_xml = 'application/xml';
  static const String text_css = 'text/css';
  static const String text_x_oeb1_css = 'text/x-oeb1-css';
  static const String image_gif = 'image/gif';
  static const String image_jpeg = 'image/jpeg';
  static const String image_png = 'image/png';
  static const String image_svg_xml = 'image/svg+xml';
  static const String font_truetype = 'font/truetype';
  static const String font_opentype = 'font/opentype';
  static const String application_vnd_ms_opentype = 'application/vnd.ms-opentype';
}

class FileFormat {
  static const String application_epub_zip = 'application/epub+zip';
}

class HandleAudio {
  static const String playing = 'playing';
  static const String pause = 'pause';
  static const String stop = 'stop';
}

class ActionNotification {
  static const String like = 'like';
  static const String comment = 'comment';
  static const String friendAdd = 'friend_add';
  static const String notificationRemindAttendance = 'notification_remind_attendance';
  static const String notificationRemindSchedule = 'notification_remind_schedule';
  static const String notificationRemindMenu = 'notification_remind_menu';
  static const String notificationNewEventClassLevel = 'notification_new_event_class_level';
  static const String notificationNewEventClass = 'notification_new_event_class';
  static const String notificationAssignLatePickupClass = 'notification_assign_latepickup_class';
  static const String postInPage = 'post_in_page';
  static const String postInGroup = 'post_in_group';
  static const String notificationServiceRegisterUncountbased = 'notification_service_register_uncountbased';
  static const String notificationUpdateMedicine = 'notification_update_medicine';
  static const String notificationNewMedicine = 'notification_new_medicine';
  static const String notificationNewEventSchool = 'notification_new_event_school';
  static const String notificationNewSchedule = 'notification_new_schedule';
  static const String notificationUpdateEventSchool = 'notification_update_event_school';
  static const String notificationNewMenu = 'notification_new_menu';
  static const String notificationUpdateMenu = 'notification_update_menu';
  static const String notificationUpdateAttendance = 'notification_update_attendance';
  static const String notificationNewReviewMenu = 'notification_new_review_menu';
  static const String notificationNewAttendanceBack = 'notification_new_attendance_back';
  static const String notificationNewReviewPoo = 'notification_new_review_poo';
  static const String notificationUseMedicine = 'notification_use_medicine';
  static const String notificationServiceRegisterCountbased = 'notification_service_register_countbased';
  static const String notificationUpdateReviewSleep = 'notification_update_review_sleep';
  static const String notificationUpdateReviewDay = 'notification_update_review_day';
  static const String notificationNewAttendance = 'notification_new_attendance';
  static const String notificationUpdateReviewMenu = 'notification_update_review_menu';
  static const String notificationNewChildHealth ='notification_new_child_health';
  static const String notificationUpdateReviewWeek = 'notification_update_review_week';
  static const String notificationNewReviewWeek = 'notification_new_review_week';
  static const String notificationUpdateReviewSchedule = 'notification_update_review_schedule';
  static const String notificationNewTuition = 'notification_new_tuition';
  static const String notificationUpdateReviewPoo = 'notification_update_review_poo';
  static const String notificationNewReviewSleep = 'notification_new_review_sleep';
  static const String notificationAddDiarySchool = 'notification_add_diary_school';
  static const String notificationNewReviewDay = 'notification_new_review_day';
  static const String notificationAttendanceResign = 'notification_attendance_resign';
  static const String notificationAttendanceConfirm = 'notification_attendance_confirm';
}

class UserTypePostNews {
  static const String user = 'user';
  static const String page = 'page';
}

class PostTypeNews {
  static const String album = 'album';
  static const String photos = 'photos';
  static const String video = 'video';
  static const String groupPicture = 'group_picture';
  static const String groupCover = 'group_cover';
  static const String pagePicture = 'page_picture';
  static const String pageCover = 'page_cover';
  static const String profilePicture = 'profile_picture';
  static const String profileCover = 'profile_cover';
  static const String shared = 'shared';
  static const String ciEvent = 'ci_event';
}

class ActionPostNews {
  static const String likePost = 'like_post';
  static const String unLikePost = 'unlike_post';
  static const String deletePost = 'delete_post';
  static const String hidePost = 'hide_post';
  static const String likeComment = 'like_comment';
  static const String unLikeComment = 'unlike_comment';
  static const String deleteComment = 'delete_comment';
  static const String share = 'share';
  static const String reportPost = 'report_post';
  static const String reportGroup = 'report_group';
  static const String reportUser = 'report_user';
  static const String savePost = 'save_post';
  static const String pinPost = 'pin_post';
  static const String unPinPost = 'unpin_post';
  static const String editPost = 'edit_post';
}

class ActionFriendsConnect {
  static const String friendAccept = 'friend-accept';
  static const String friendDecline = 'friend-decline';
  static const String friendRemove = 'friend-remove';
  static const String friendAdd = 'friend-add';
  static const String friendCancel = 'friend-cancel';
  static const String follow = 'follow';
  static const String unfollow = 'unfollow';
  static const String block = 'block';
}

class HandleCommentPostNews {
  static const String post = 'post';
  static const String photo = 'photo';
  static const String comment = 'comment';
}

class PostNewsFrom {
  static const String newsFeedPage = 'news_feed_page';
  static const String schoolPage = 'school_page';
  static const String classPage = 'class_page';
  static const String personPage = 'person_page';
  static const String savedPostPage = 'saved_post_page';
  static const String friendPage = 'friend_page';
}

class ActionPageConnect {
  static const String pageLike = 'page-like';
  static const String pageUnLike = 'page-unlike';
  static const String reportPage = 'report_page';
}

class ActionGroupConnect {
  static const String groupLeave = 'group-leave';
  static const String groupJoin = 'group-join';
}

class GroupIJoin {
  static const String approved = 'approved';
  static const String pending = 'pending';
  static const String notJoined = 'not_joined';
  static const String notFalse = 'false';
}

class TypeSearchDetail {
  static const String posts = 'posts';
  static const String groups = 'groups';
  static const String pages = 'pages';
  static const String users = 'users';
}

class ViewShowPage {
  static const String all = 'all';
  static const String reviews = 'reviews';
  static const String abouts = 'abouts';
  static const String members = 'members';
  static const String friends = 'friends';
}

class TypeGetPhoto {
  static const String page = 'page';
  static const String group = 'group';
  static const String user = 'user';
}

class ActionCreatePost {
  static const String page = 'page';
  static const String group = 'group';
  static const String me = 'me';
}

class TypeCreatePost {
  static const String picturePage = 'picture-page';
  static const String covePage = 'cover-page';
  static const String pictureGroup = 'picture-group';
  static const String coverGroup = 'cover-group';
  static const String pictureUser = 'picture-user';
  static const String coverUser = 'cover-user';
  static const String publisher = 'publisher';
}

class PrivacyCreatePost {
  static const String public = 'public';
}

class PhotoType {
  static const String photo = 'photo';
  static const String album = 'album';
  static const String video = 'video';
}

class AboutType {
  static const String intro = 'intro';
  static const String member = 'member';
}

class ConnectionUser {
  static const String remove = 'remove';
  static const String me = 'me';
  static const String add = 'add';
}

class VideoFileType {
  static const String network = 'network';
  static const String storage = 'storage';
}

class UserGender {
  static const String female = 'female';
  static const String male = 'male';
}