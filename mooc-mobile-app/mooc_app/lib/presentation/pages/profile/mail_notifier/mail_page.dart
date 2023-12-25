import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/presentation/controllers/history/login_history_binding.dart';
import '../../../controllers/notifications/detail_noti_controller.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../controllers/notifications/noti_binding.dart';
import 'mail_notifier.dart';

class MailDetailsPage extends StatelessWidget {
  // static String routeName = "/favorite";
  MailDetailsPage({super.key, required this.id});
  final String id;
  final noti = Get.find<DetailNotiController>();
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return GetX(
        init: noti,
        initState: (state) async {
          await noti.fetchDetailData(id);
        },
        builder: (_) {
          return WillPopScope(
              onWillPop: () {
                NotiBinding().dependencies();
                LoginHistoryBinding().dependencies();
                Get.off(() => const MailNotice());
                return Future.value(false);
              },
              child: CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    leading: CupertinoButton(
                      onPressed: () {
                        NotiBinding().dependencies();
                        LoginHistoryBinding().dependencies();
                        Get.off(() => const MailNotice());
                      },
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      child: const Icon(
                        CupertinoIcons.chevron_back,
                        size: 32,
                      ),
                    ),
                    middle: Container(
                        width: widthScreen / 2,
                        child: Center(
                            child:
                                noti.detailNotiData.value?.data?.title == null
                                    ? const Text(
                                        'Tiêu đề',
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : Text(
                                        '${noti.detailNotiData.value?.data?.title}',
                                        overflow: TextOverflow.ellipsis,
                                      ))),
                  ),
                  child: noti.isLoading.value == true
                      ? Container(
                          child: const Center(
                          child: CircularProgressIndicator(),
                        ))
                      : noti.detailNotiData.value?.data?.content != null
                          ? Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5
                                  // top: CupertinoNavigationBar().preferredSize.height
                                  ),
                              child: ListView(
                                  padding: EdgeInsets.only(
                                      top: const CupertinoNavigationBar()
                                              .preferredSize
                                              .height +
                                          statusBarHeight),
                                  physics: const ClampingScrollPhysics(),
                                  children: [
                                    Center(
                                      child: Container(
                                        child: Text(
                                          "Người gửi : ${noti.detailNotiData.value?.data?.creator_name}",
                                          style: const TextStyle(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      child: Html(
                                          data:
                                              "${noti.detailNotiData.value?.data?.content}"),
                                    ),
                                    // Container(
                                    //   height: heightScreen * 2,
                                    // ),
                                  ]))
                          : Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5
                                  // top: CupertinoNavigationBar().preferredSize.height
                                  ),
                              child: ListView(
                                  physics: const ClampingScrollPhysics(),
                                  children: [
                                    Center(
                                      child: Container(
                                        child: const Text("NỘI DUNG TRỐNG"),
                                      ),
                                    ),
                                    Container(
                                      height: heightScreen * 2,
                                    ),
                                  ]))));
        });
  }
}
