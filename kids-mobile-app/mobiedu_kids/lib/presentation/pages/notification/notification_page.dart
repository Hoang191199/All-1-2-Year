import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/presentation/controllers/notification/notification_controller.dart';
import 'package:mobiedu_kids/presentation/pages/notification/widgets/notification_friend_request.dart';
import 'package:mobiedu_kids/presentation/pages/notification/widgets/notification_new.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  final notificationController = Get.find<NotificationController>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return GetX(
      init: notificationController,
      initState: (state) async {
        // await notificationController.fetchData();
        notificationController.setCountNotifications();
        scrollController.addListener(scrollListener);
      },
      didUpdateWidget: (old, newState) {
        scrollController.addListener(scrollListener);
      },
      dispose: (state) {
        scrollController.removeListener(scrollListener);
      },
      builder: (_) {
        return Scaffold(
          backgroundColor: HexColor('FFFFFF'),
          body: Container(
            padding: EdgeInsets.only(top: statusBarHeight + 10.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: HexColor('D8D8D8')))
                  ),
                  child: Center(
                    child: Text(
                      'Thông báo',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(fontSize: 22.0, height: 1.4, fontWeight: FontWeight.w700, color: HexColor('783199'))
                      ),
                    ),
                  ),
                ),
                notificationController.isLoading.value 
                  ? const Expanded(
                    child: Center(
                      child: CircularLoadingIndicator(),
                    ),
                  )
                  : Expanded(
                    child: RefreshIndicator(
                      color: AppColors.pink,
                      onRefresh: () async {
                        await notificationController.fetchData();
                      },
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            NotificationFriendRequest(),
                            NotificationNew()
                          ],
                        ),
                      ),
                    )
                  )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> scrollListener() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      await notificationController.loadMore();
    }
  }
}
