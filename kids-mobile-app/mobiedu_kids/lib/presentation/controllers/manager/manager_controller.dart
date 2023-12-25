import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/album/album_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/attendance/attendanceController.dart';
import 'package:mobiedu_kids/presentation/controllers/attendance/attendance_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/contact/contact_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/event/event_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/feedback/feedback_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/growth/growth_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/hygiene/hygiene_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/child_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/menu/menu_binding.dart';
// import 'package:mobiedu_kids/presentation/controllers/menu/menu_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/menu/menu_review_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/saved_posts_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_group_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/prescription/prescription_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/prescription/prescription_child_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/remark/remark_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/rest/rest_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/schedule/schedule_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/schedule/schedule_review_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/service/service_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/service/service_parent_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/shuttle/shuttle_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/sleep/sleep_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/tuitions/tuitions_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/tuitions/tuitions_parent_binding.dart';
import 'package:mobiedu_kids/presentation/pages/manager/diary/diary_add_album.dart';
import 'package:mobiedu_kids/presentation/pages/manager/event/event_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/health/health_note_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/hygiene/hygiene_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/appreciate/appreciate_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/attendance/attendance_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/let_sleep/let_sleep_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/list_student/list_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/menu/menu_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/contact/contact_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/diary/diary_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/event/event_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/feedback/feedback_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/health/health_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/menu/menu_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/prescription_parent/prescription_parent.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/rest/rest_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/schedule/schedule_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/service_parent/service_parent.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/tuition_parent/tuition_parent.dart';
import 'package:mobiedu_kids/presentation/pages/manager/prescription/prescription_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/remark/remark_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/schedule/schedule_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/service/service_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/shuttle/shuttle_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/tuition/tuition_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/class_page.dart';

class ManagerController extends GetxController {

  final splashController = Get.find<SplashScreenController>();
  final store = Get.find<LocalStorageService>();

  @override
  void onInit() {
    super.onInit();
  }

  reidrectPage(String title) async {
    GrowthBinding().dependencies();
    AlbumBinding().dependencies();
    RemarkBinding().dependencies();
    EventBinding().dependencies();
    TuitionsBinding().dependencies();
    PrescriptionBinding().dependencies();
    ShuttleBinding().dependencies();
    MenuBinding().dependencies();
    MenuReviewBinding().dependencies();
    ScheduleBinding().dependencies();
    ScheduleReviewBinding().dependencies();
    ChildBinding().dependencies();
    AttendanceBinding().dependencies();
    HygieneBinding().dependencies();
    SleepBinding().dependencies();
    ServiceBinding().dependencies();
    FeedbackBinding().dependencies();
    ContactBinding().dependencies();
    RestBinding().dependencies();
    PrescriptionChildBinding().dependencies();
    TuitionsParentBinding().dependencies();
    ServiceParentBinding().dependencies();

    switch (title) {
      case 'diem-danh':
        final attendanceController = Get.find<AttendanceController>();
        attendanceController.checkState.value = 0;
        return Get.to(() => AttendancePage());
      case 'thuc-don':
        return Get.to(() => MenuPage());
      case 'lich-hoc':
        return Get.to(() => SchedulePage());
      case 'nhan-xet':
        return Get.to(() => RemarkPage());
      case 'ngu':
        return Get.to(() => LetSleepPage());
      case 've-sinh':
        return Get.to(() => HygienePage());
      case 'don-muon':
        return Get.to(() => ShuttlePage());
      case 'don-thuoc':
        return Get.to(() => PrescriptionPage());
      case 'hoc-phi':
        return Get.to(() => TuitionPage());
      case 'Sổ liên lạc':
        return '';
      case 'thong-bao':
        return Get.to(() => EventPage());
      case 'dich-vu':
        return Get.to(() => ServicePage());
      case 'nhom-lop':
        NewsFeedBinding().dependencies();
        ShowPageBinding().dependencies();
        ShowGroupBinding().dependencies();
        HomePageBinding('').dependencies();
        SavedPostsBinding().dependencies();
        Get.to(
        () => ClassPage(
          classTitle: store.getGrouptitle,
          className: store.getGroupname,
          classId: store.getGroupId,
        ),
        duration: const Duration(milliseconds: 400),
        transition: Transition.rightToLeft
      );
        break;
      case 'danh-sach-hoc-sinh':
        return Get.to(() => ListPage());
      case 'nhat-ky':
        return Get.to(() => DiaryAddAlbum());
      case 'chi-so-suc-khoe':
        return Get.to(() => HealthNotePage());
      case 'danh-gia-dinh-ky':
        return Get.to(() => AppreciatePage());
      case 'lien-he':
        return Get.to(() => ContactPage());
      case 'gop-y':
        return Get.to(() => FeedbackPage());
      case 'xin-nghi':
        return Get.to(() => RestPage());
      case 'don-thuoc-parent':
        return Get.to(() => PrescriptionParent());
      case 'hoc-phi-parent':
        return Get.to(() => TuitionParent());
      case 'dich-vu-parent':
        return Get.to(() => ServiceParent());
      case 'thong-bao-parent':
        return Get.to(() => EventChildPage());
      case 'chi-so-suc-khoe-parent':
        return Get.to(() => HealthChildPage(
              child_parent_id: store.getChild?.child_parent_id ?? "",
            ));
      case 'nhat-ky-parent':
        return Get.to(() => DiaryChildPage(
              child_parent_id: store.getChild?.child_parent_id ?? "",
            ));
      case 'thuc-don-parent':
        return Get.to(() => MenuChildPage(
              child_id: store.getChild?.child_id ?? "",
            ));
      case 'lich-hoc-parent':
        return Get.to(() => ScheduleChildPage(
              child_id: store.getChild?.child_id ?? "",
            ));
      case 'camera':
        return showSnackbar(SnackbarType.notice, "Tính năng đang phát triển",
            "Sẽ có mặt trong một ngày sớm nhất");
      default:
        return '';
    }
  }
}
