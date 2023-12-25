import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/notification/notification.dart';
import 'package:mobiedu_kids/presentation/controllers/album/album_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/attendance/attendanceController.dart';
import 'package:mobiedu_kids/presentation/controllers/attendance/attendance_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/checkbox_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/event/event_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/event/event_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/growth/growth_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/hygiene/hygiene_binding.dart';
// import 'package:mobiedu_kids/presentation/controllers/infomation/infomation_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/init_page_tab_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/menu/menu_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/menu/menu_review_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/news_feed_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/saved_posts_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_group_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/show_page_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/notification/notification_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/prescription/prescription_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/prescription/prescription_child_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/prescription/prescription_child_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/prescription/prescription_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/rest/rest_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/schedule/schedule_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/schedule/schedule_review_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/service/service_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/service/service_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/service/service_parent_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/service/service_parent_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/shuttle/shuttle_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/shuttle/shuttle_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/sleep/sleep_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/tuitions/tuitions_parent_binding.dart';
import 'package:mobiedu_kids/presentation/pages/init/init_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/attendance/attendance_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/event/event_details_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/menu/menu_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/diary/diary_page.dart';
// import 'package:mobiedu_kids/presentation/pages/manager/parents/event/event_details_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/health/health_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/menu/menu_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/prescription_parent/prescription_parent.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/rest/approve_rest.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/rest/rest_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/schedule/schedule_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/service_parent/service_parent.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/tuition_parent/tuition_parent.dart';
import 'package:mobiedu_kids/presentation/pages/manager/prescription/prescription_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/schedule/schedule_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/service/service_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/shuttle/shuttle_page.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/news_feed_post_detail_page.dart';
import 'package:mobiedu_kids/presentation/pages/notification/widgets/notification_avatar.dart';
import 'package:mobiedu_kids/presentation/pages/notification/widgets/notification_dialog.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class NotificationNew extends StatelessWidget {
  NotificationNew({super.key});

  final notificationController = Get.find<NotificationController>();
  final store = Get.find<LocalStorageService>();
  final splashController = Get.find<SplashScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 28.0, top: 8.0, bottom: 8.0),
          child: Text(
            'Thông báo mới',
            style: GoogleFonts.raleway(
              textStyle: TextStyle(fontSize: 14.0, height: 1.3, fontWeight: FontWeight.w700, color: HexColor('464646'))
            ),
          ),
        ),
        Obx(
          () => ListView.builder(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.only(top: 0.0, bottom: 50.0),
            shrinkWrap: true,
            itemCount: notificationController.isLoadMore.value ? notificationController.notificationsData.length + 1 : notificationController.notificationsData.length,
            itemBuilder: (context, index) {
              if (index < notificationController.notificationsData.length) {
                final notification = notificationController.notificationsData[index];
                return GestureDetector(
                  onTap: () {
                    handlePressNotificationItem(context, notification);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                      color: notification?.seen == '0' ? HexColor('FFF4FA') : HexColor('FFFFFF')
                    ),
                    child: Row(
                      children: [
                        NotificationAvatar(userPicture: notification?.user_picture, action: notification?.action),
                        const SizedBox(width: 7.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (notification?.user_fullname != null && (notification?.user_fullname?.isNotEmpty ?? false))
                                Text(
                                  notification?.user_fullname ?? '',
                                  style: GoogleFonts.raleway(
                                    textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: HexColor('464646'))
                                  ),
                                ),
                              Text(
                                notification?.message ?? '',
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(fontSize: 14.0, height: 1.6, fontWeight: FontWeight.w500, color: HexColor('464646'))
                                ),
                              ),
                              if (notiTime(notification?.time).isNotEmpty)
                                Container(
                                  margin: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    notiTime(notification?.time),
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(fontSize: 12.0, height: 1.25, fontWeight: FontWeight.w500, color: HexColor('D8D8D8'))
                                    ),
                                  ),
                                )
                            ],
                          )
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularLoadingIndicator(),
                );
              }
            },
          )
        )
      ],
    );
  }

  Future<void> handlePressNotificationItem(BuildContext context, NotificationEntity? notification) async {
    print({notification?.action, notification?.extra1,notification?.extra2, notification?.extra3, notification?.notification_id});
    if(splashController.responseManagerData.value?.data?.classes?.isNotEmpty ?? false){
      switch (notification?.action) {
        case ActionNotification.like:
        case ActionNotification.comment:
          NewsFeedBinding().dependencies();
          ShowPageBinding().dependencies();
          ShowGroupBinding().dependencies();
          HomePageBinding('').dependencies();
          SavedPostsBinding().dependencies();
          Get.find<ShowPageController>();
          Get.find<NewsFeedController>();
          return Get.to(() => NewsFeedPostDetailPage(
            from: PostNewsFrom.newsFeedPage, 
            postId: notification?.node_url ?? '',
            showComment: true,
            ),
            duration: const Duration(milliseconds: 400),
            transition: Transition.rightToLeft
          );
        case ActionNotification.friendAdd:
          return showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return NotificationDialog(content: notification?.message ?? '');
            });
        case ActionNotification.notificationRemindAttendance:
          AttendanceBinding().dependencies();
          HygieneBinding().dependencies();
          SleepBinding().dependencies();
          final attendanceController = Get.find<AttendanceController>();
          attendanceController.dateNow = convertStringToDateTime(notification?.extra1 ?? '01/01/2023');
          attendanceController.checkState.value = 1;
          await attendanceController.fetchData(notification?.extra2 ?? '', convertDateTimeToString(attendanceController.dateNow));
          return Get.to(() => AttendancePage());
        case ActionNotification.notificationAssignLatePickupClass:
          ShuttleBinding().dependencies();
          final shuttleController = Get.find<ShuttleController>();
          await shuttleController.fetchData();
          return Get.to(() => ShuttlePage());
        case ActionNotification.postInPage:
        case ActionNotification.postInGroup:
          NewsFeedBinding().dependencies();
          ShowPageBinding().dependencies();
          ShowGroupBinding().dependencies();
          HomePageBinding('').dependencies();
          SavedPostsBinding().dependencies();
          Get.find<NewsFeedController>();
          Get.find<ShowPageController>();
          return Get.to(() => NewsFeedPostDetailPage(
            from: notification?.action == 'post_in_page' ? PostNewsFrom.newsFeedPage : PostNewsFrom.schoolPage, 
            postId: notification?.node_url ?? ''),
            duration: const Duration(milliseconds: 400),
            transition: Transition.rightToLeft
          );
        case ActionNotification.notificationUpdateMedicine:
        case ActionNotification.notificationNewMedicine:
          PrescriptionBinding().dependencies();
          Get.find<PrescriptionController>();
          return Get.to(() => PrescriptionPage(),
          );
        case ActionNotification.notificationServiceRegisterUncountbased:
        case ActionNotification.notificationServiceRegisterCountbased:
          ServiceParentBinding().dependencies();
          ServiceBinding().dependencies();
          Get.find<ServiceController>();
          return Get.to(() => ServicePage(),
          );
        case ActionNotification.notificationNewEventSchool:
        case ActionNotification.notificationNewEventClass:
        case ActionNotification.notificationUpdateEventSchool:
          EventBinding().dependencies();
          Get.find<EventController>();
          return Get.to(() => EventDetailsPage(
            event_id: notification?.node_url ?? '',
          ));
        case ActionNotification.notificationNewSchedule:
          ScheduleReviewBinding().dependencies();
          ScheduleBinding().dependencies();
          MenuBinding().dependencies();
          MenuReviewBinding().dependencies();
          Get.put(CheckBoxController());
          return Get.to(() => SchedulePage());
        case ActionNotification.notificationNewMenu:
        case ActionNotification.notificationUpdateMenu:
          ScheduleReviewBinding().dependencies();
          ScheduleBinding().dependencies();
          MenuBinding().dependencies();
          MenuReviewBinding().dependencies();
          Get.put(CheckBoxController());
          return Get.to(() => MenuPage());
        case ActionNotification.notificationAttendanceResign:
          AttendanceBinding().dependencies();
          HygieneBinding().dependencies();
          SleepBinding().dependencies();
          return Get.to(() => AppRoveRest(
              action: notification?.action ?? '',
              nodeUrl: notification?.node_url ?? '',
              nodeType: notification?.node_type ?? '',
              extra1: notification?.extra1 ?? '',
              extra2: notification?.extra2 ?? '',
              extra3: notification?.extra3 ?? '',
            )
          );
        default:
          break;
      }
    }else{
      final initPageTabController = Get.put(InitPageTabController());
      switch (notification?.action) {
        case ActionNotification.notificationUpdateAttendance:
        case ActionNotification.notificationNewReviewMenu:
        case ActionNotification.notificationNewAttendanceBack:
        case ActionNotification.notificationNewReviewPoo:
        case ActionNotification.notificationUpdateReviewDay:
        case ActionNotification.notificationUpdateReviewSleep:
        case ActionNotification.notificationNewAttendance:
        case ActionNotification.notificationUpdateReviewMenu:
        case ActionNotification.notificationUpdateReviewWeek:
        case ActionNotification.notificationNewReviewWeek:
        case ActionNotification.notificationUpdateReviewSchedule:
        case ActionNotification.notificationUpdateReviewPoo:
        case ActionNotification.notificationNewReviewSleep:
        case ActionNotification.notificationNewReviewDay:
        initPageTabController.changeIndexTab(0);
          return Get.off(() => InitPage());  
        case ActionNotification.postInPage:
        case ActionNotification.postInGroup:
          NewsFeedBinding().dependencies();
          ShowPageBinding().dependencies();
          ShowGroupBinding().dependencies();
          HomePageBinding('').dependencies();
          SavedPostsBinding().dependencies();
          Get.find<NewsFeedController>();
          Get.find<ShowPageController>();
          return Get.to(() => NewsFeedPostDetailPage(
            from: notification?.action == 'post_in_page' ? PostNewsFrom.newsFeedPage : PostNewsFrom.schoolPage, 
            postId: notification?.node_url ?? ''),
            duration: const Duration(milliseconds: 400),
            transition: Transition.rightToLeft
          );
        case ActionNotification.notificationUseMedicine:
        case ActionNotification.notificationNewMedicine:
          PrescriptionChildBinding().dependencies();
          final prescriptionChildController = Get.find<PrescriptionChildController>();  
          await prescriptionChildController.fetchData();
          return Get.to(() => PrescriptionParent());
        case ActionNotification.notificationServiceRegisterCountbased:
          ServiceParentBinding().dependencies();
          final serviceParentController = Get.find<ServiceParentController>();
          await serviceParentController.fetchData();
          await serviceParentController.getHistory();
          return Get.to(() => ServiceParent());
        case ActionNotification.notificationNewChildHealth:
          GrowthBinding().dependencies();
          return Get.to(() => HealthChildPage(
            child_parent_id: store.getChild?.child_parent_id ?? "",
          ));
        case ActionNotification.notificationRemindSchedule:
        case ActionNotification.notificationNewSchedule:
          ScheduleBinding().dependencies();
          return Get.to(() => ScheduleChildPage(child_id: store.getChild?.child_id ?? ""));
        case ActionNotification.notificationRemindMenu:
        case ActionNotification.notificationNewMenu:
          ScheduleReviewBinding().dependencies();
          ScheduleBinding().dependencies();
          MenuBinding().dependencies();
          MenuReviewBinding().dependencies();
          Get.put(CheckBoxController());
          return Get.to(() => MenuChildPage(child_id: store.getChild?.child_id ?? ""));
        case ActionNotification.notificationNewTuition:
          TuitionsParentBinding().dependencies();
          return Get.to(() => TuitionParent());
        case ActionNotification.notificationAddDiarySchool:
          AlbumBinding().dependencies();
          return Get.to(() => DiaryChildPage(
            child_parent_id: store.getChild?.child_parent_id ?? "",
          ));
        case ActionNotification.notificationAttendanceConfirm:
          RestBinding().dependencies();
          return Get.to(() => RestPage());
        // case ActionNotification.notificationNewEventSchool:
        // case ActionNotification.notificationNewEventClass:
        // case ActionNotification.notificationUpdateEventSchool:
        //   EventBinding().dependencies();
        //   Get.find<EventController>();
        //   return Get.to(() => EventChildDetailsPage(
        //     index: notification?.node_url ?? '',
        //   ));
        default:
          break;
      }
    }

  }
}