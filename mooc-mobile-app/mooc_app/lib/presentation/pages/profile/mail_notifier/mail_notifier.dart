import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/app/config/app_constants.dart';
import 'package:mooc_app/presentation/controllers/notifications/noti_binding.dart';
import 'package:mooc_app/presentation/controllers/notifications/read_controller.dart';
import 'package:mooc_app/presentation/pages/profile/mail_notifier/mail_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../controllers/notifications/list_noti_controller.dart';
import '../../init/init_page.dart';
import 'package:flutter_html/flutter_html.dart';

class MailNotice extends GetView<AuthController> {
  // static String routeName = "/favorite";

  const MailNotice({super.key});
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final list = Get.find<ListNotiController>();
    final scrollController = ScrollController();
    final read = Get.find<ReadController>();
    // final initPageTabController = Get.put(InitPageTabController());
    void scrollListener() {
      if (scrollController.position.extentAfter < 100) {
        list.loadMore();
      }
    }

    return WillPopScope(
        onWillPop: () async {
          // await initPageTabController.changeIndexTab(3);
          Get.delete<ListNotiController>();
          Get.to(() => InitPage(
                index: 3,
              ));
          return Future.value(false);
        },
        child: GetX(
            init: list,
            initState: (state) {
              list.fetchData();
              if (list.error.value ?? false) {
                if (list.code.value == ResponseCode.loginSession) {
                  if (context.mounted) {
                    showLoginSessionDialog(context);
                  }
                } else {
                  if (context.mounted) {
                    showSnackbar(
                        SnackbarType.error,
                        AppLocalizations.of(context)!.course,
                        AppLocalizations.of(context)!.error);
                  }
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
            builder: (_) {
              return CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle: const Text('Hộp thư thông báo'),
                    leading: CupertinoButton(
                      onPressed: () {
                        // initPageTabController.changeIndexTab(3);
                        Get.delete<ListNotiController>();
                        Get.to(() => InitPage(
                              index: 3,
                            ));
                      },
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      child: const Icon(
                        CupertinoIcons.chevron_back,
                        size: 32,
                      ),
                    ),
                    trailing: read.unread.value > 0
                        ? CupertinoButton(
                            onPressed: () async {
                              await read.readAll();
                              if (read.res.value?.status == true) {
                                showSnackbar(SnackbarType.notice, "Đã xem",
                                    "Tất cả các thông báo được đánh dấu là đã đọc");
                                await list.fetchData();
                                await read.listUnread();
                              } else {
                                showSnackbar(SnackbarType.error, "Lỗi",
                                    "Thao tác chưa được thực hiện");
                              }
                            },
                            padding: EdgeInsets.zero,
                            alignment: Alignment.centerLeft,
                            child: const Icon(
                              FontAwesomeIcons.listCheck,
                              size: 25,
                            ),
                          )
                        : null,
                  ),
                  child: list.isLoading.value
                      ? Container(
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : list.listNotiMoocData.value.isEmpty
                          ? Container(
                              child: const Center(
                                child: Text("Không có thông báo nào"),
                              ),
                            )
                          : ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              controller: scrollController,
                              itemCount: list.listNotiMoocData.value.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    // margin: EdgeInsets.all(20),
                                    onTap: () {
                                      list.listNotiMoocData.value[index]
                                          .read_at = "recently";
                                      NotiBinding().dependencies();
                                      Get.off(() => MailDetailsPage(
                                          id: "${list.listNotiMoocData.value[index].id}"));
                                    },
                                    child: Obx(() => Card(
                                          color: list.listNotiMoocData
                                                      .value[index].read_at ==
                                                  null
                                              ? Colors.white
                                              : Colors.grey[300],
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 12),
                                                child: SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: CircleAvatar(
                                                    backgroundColor: list
                                                                .listNotiMoocData
                                                                .value[index]
                                                                .read_at ==
                                                            null
                                                        ? Colors.blue
                                                        : Colors.grey[300],
                                                    foregroundColor: list
                                                                .listNotiMoocData
                                                                .value[index]
                                                                .read_at ==
                                                            null
                                                        ? Colors.white
                                                        : Colors.blue,
                                                    child: const Icon(
                                                        CupertinoIcons.info),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width:
                                                    (widthScreen - 20) * 3 / 4 -
                                                        50,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "${list.listNotiMoocData.value[index].title}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontWeight: list
                                                                    .listNotiMoocData
                                                                    .value[
                                                                        index]
                                                                    .read_at ==
                                                                null
                                                            ? FontWeight.bold
                                                            : FontWeight.normal,
                                                        fontSize: 16.0,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Html(
                                                      data:
                                                          "${list.listNotiMoocData.value[index].content}",
                                                      // overflow:
                                                      //     TextOverflow.ellipsis,
                                                      // style: TextStyle(
                                                      //   fontWeight: list
                                                      //               .listNotiMoocData
                                                      //               .value[
                                                      //                   index]
                                                      //               .read_at ==
                                                      //           null
                                                      //       ? FontWeight.bold
                                                      //       : FontWeight.normal,
                                                      //   fontSize: 14.0,
                                                      //   color: Colors.black,
                                                      // ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Text(
                                                      "Lúc ${DateFormat('HH:mm:ss dd-MM-yyyy').format(DateFormat('hh:mm:ss dd-MM-yyyy').parse(DateFormat('hh:mm:ss dd-MM-yyyy').format(DateFormat('yyyy-MM-ddThh:mm:sssZ').parse(list.listNotiMoocData.value[index].created_at ?? "1900-01-01T00:00:000Z")), true).toLocal())}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontWeight: list
                                                                    .listNotiMoocData
                                                                    .value[
                                                                        index]
                                                                    .read_at ==
                                                                null
                                                            ? FontWeight.bold
                                                            : FontWeight.normal,
                                                        fontSize: 14.0,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: list
                                                            .listNotiMoocData
                                                            .value[index]
                                                            .read_at !=
                                                        null
                                                    ? Container(
                                                        width:
                                                            (widthScreen - 20) /
                                                                4,
                                                        child: Column(
                                                            // mainAxisAlignment:
                                                            //     MainAxisAlignment.end,
                                                            children: [
                                                              Text(
                                                                DateFormat('HH:mm:ss').format(DateFormat(
                                                                        'hh:mm:ss dd-MM-yyyy')
                                                                    .parse(
                                                                        DateFormat('hh:mm:ss dd-MM-yyyy').format(DateFormat('yyyy-MM-ddThh:mm:sssZ').parse(list.listNotiMoocData.value[index].read_at ??
                                                                            "1900-01-01T00:00:000Z")),
                                                                        true)
                                                                    .toLocal()),
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight: list
                                                                              .listNotiMoocData
                                                                              .value[
                                                                                  index]
                                                                              .read_at ==
                                                                          null
                                                                      ? FontWeight
                                                                          .bold
                                                                      : FontWeight
                                                                          .normal,
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                // textAlign:
                                                                //     TextAlign.right,
                                                              ),
                                                              Text(
                                                                DateFormat('dd-MM-yyyy').format(DateFormat(
                                                                        'hh:mm:ss dd-MM-yyyy')
                                                                    .parse(
                                                                        DateFormat('hh:mm:ss dd-MM-yyyy').format(DateFormat('yyyy-MM-ddThh:mm:sssZ').parse(list.listNotiMoocData.value[index].read_at ??
                                                                            "1900-01-01T00:00:000Z")),
                                                                        true)
                                                                    .toLocal()),
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight: list
                                                                              .listNotiMoocData
                                                                              .value[
                                                                                  index]
                                                                              .read_at ==
                                                                          null
                                                                      ? FontWeight
                                                                          .bold
                                                                      : FontWeight
                                                                          .normal,
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                // textAlign:
                                                                //     TextAlign.right,
                                                              ),
                                                            ]))
                                                    : Text(
                                                        "Chưa đọc",
                                                        style: TextStyle(
                                                          fontWeight: list
                                                                      .listNotiMoocData
                                                                      .value[
                                                                          index]
                                                                      .read_at ==
                                                                  null
                                                              ? FontWeight.bold
                                                              : FontWeight
                                                                  .normal,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                              )
                                            ]),
                                          ),
                                        )));
                              },
                            ) // Container(
                  // )
                  );
            }));
  }
}
