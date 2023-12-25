import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';
import '../../../controllers/notification/noti_controller.dart';
import '../../../widgets/message_noti.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  final loginController = Get.find<LoginController>();
  final noti = Get.find<NotiController>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    return GetX(
        init: noti,
        initState: (state) async {
          await noti.fetchData();
          if (noti.error.value) {
            if (noti.code.value == 401) {
              if (context.mounted) {}
              await noti.fetchData();
            } else {
              if (context.mounted) {}
            }
          }
          scrollController.addListener(scrollListener);
        },
        didUpdateWidget: (old, newState) {
          scrollController.addListener(scrollListener);
        },
        dispose: (state) {
          scrollController.removeListener(scrollListener);
        },
        builder: (context) {
          return Scaffold(
              body: Container(
                  padding: EdgeInsets.only(top: statusBarHeight, bottom: 0),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(children: [
                    Container(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Row(children: [
                        Container(
                          width: widthScreen / 6,
                          child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.chevron_left_rounded,
                                size: 40,
                                weight: 5,
                                color: Colors.grey,
                              )),
                        ),
                        Container(
                          width: widthScreen * 4 / 6,
                          child: Center(
                            child: Text(
                              "notification".tr,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.kantumruy(
                                  textStyle: const TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black)),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.only(top: 0),
                          child: noti.isLoading.value
                              ? Container(
                                  child: const Center(
                                  child: CircularProgressIndicator(),
                                ))
                              : noti.responseData.isEmpty
                                  ? Center(
                                      child: Text("noti-empty".tr,
                                          style: const TextStyle(
                                              color: Colors.black54)),
                                    )
                                  : ListView.separated(
                                      physics: const ClampingScrollPhysics(),
                                      padding: const EdgeInsets.only(
                                          top: 10.0,
                                          left: 28.0,
                                          bottom:
                                              kBottomNavigationBarHeight + 10.0,
                                          right: 28.0),
                                      itemCount: noti.responseData.length,
                                      controller: scrollController,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 10.0),
                                      itemBuilder: (context, index) {
                                        return MessageNotification(
                                          widthItem: widthScreen,
                                          contentItem: noti.responseData[index],
                                          index: index,
                                        );
                                      })),
                    )
                  ])));
        });
  }

  void scrollListener() {
    if (scrollController.position.extentAfter < 500) {
      noti.loadMore();
    }
  }
}
