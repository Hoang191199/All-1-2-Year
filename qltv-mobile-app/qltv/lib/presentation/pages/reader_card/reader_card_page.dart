import 'package:barcode_widget/barcode_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/services/local_storage.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';
import 'package:qltv/presentation/controllers/profile/profile_controller.dart';

class ReaderCardPage extends StatelessWidget {
  ReaderCardPage({super.key});

  final loginController = Get.find<LoginController>();
  final store = Get.find<LocalStorageService>();
  final profile = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    List<String> list = [];
    if (profile.reader.value?.userSite?.metadata?.subject_groups != null) {
      List<int> items = List.generate(
          profile.reader.value?.userSite?.metadata?.subject_groups!.length ?? 0,
          (i) => i);
      for (var i in items) {
        list.add(
            "${profile.reader.value?.userSite?.metadata?.subject_groups?[i].title}");
      }
    }
    String subject = list.join(", ");
    return GestureDetector(
        onTap: () {},
        child: Scaffold(
            backgroundColor: AppColors.background,
            // navigationBar: CupertinoNavigationBar(
            //   automaticallyImplyLeading: false,
            //   middle: Text(
            //     "reader-card".tr,
            //     style: GoogleFonts.kantumruy(
            //         textStyle: const TextStyle(
            //             fontSize: 20.0,
            //             color: Colors.black,
            //             fontWeight: FontWeight.bold)),
            //   ),
            //   backgroundColor: AppColors.background,
            //   border: const Border(bottom: BorderSide.none),
            // ),
            body: Container(
              padding: EdgeInsets.only(top: statusBarHeight + 25.0, bottom: 0),
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Obx(
                () => profile.isLoading.value == true
                    ? Container(
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : profile.mess.value == "Không tìm thấy bạn đọc"
                        ? store.readerFromStorage == null
                            ? Container(
                                child: Center(
                                    child: Text(
                                  "reader-notfound".tr,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 20),
                                )),
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                    bottom: bottomPadding
                                    // kBottomNavigationBarHeight
                                    ),
                                child: SingleChildScrollView(
                                    physics: const ClampingScrollPhysics(),
                                    child: Column(children: [
                                      Center(
                                        child: Text(
                                          "reader-card".tr,
                                          style: GoogleFonts.kantumruy(
                                              textStyle: const TextStyle(
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black)),
                                        ),
                                      ),
                                      Container(
                                        child: Text("scan-guide".tr,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.kantumruy(
                                                textStyle: const TextStyle(
                                                    fontSize: 17.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ),
                                      (store.readerFromStorage?.code != "" &&
                                              store.readerFromStorage?.code !=
                                                  null)
                                          ? Container(
                                              child: BarcodeWidget(
                                                data: store.readerFromStorage
                                                        ?.code ??
                                                    "",
                                                barcode: Barcode.code128(),
                                                drawText: false,
                                                width: widthScreen * 4 / 5,
                                              ),
                                            )
                                          : Container(
                                              child: Text(
                                                  "scan-guide-notfound".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.kantumruy(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 17.0,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                            ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      // Container(
                                      //   margin: const EdgeInsets.only(
                                      //       bottom: 20.0, left: 10),
                                      //   child: SelectableText(
                                      //       "${store.accessTokenFromStorage}",
                                      //       style: GoogleFonts.kantumruy(
                                      //           textStyle: const TextStyle(
                                      //               fontSize: 17.0,
                                      //               color: Colors.black,
                                      //               fontWeight:
                                      //                   FontWeight.bold))),
                                      // ),
                                      Container(
                                        width: widthScreen / 3,
                                        height: widthScreen * 4 / 9,
                                        decoration: BoxDecoration(
                                          image: store.readerFromStorage
                                                          ?.avatar_url !=
                                                      "" &&
                                                  store.readerFromStorage
                                                          ?.avatar_url !=
                                                      null
                                              ? DecorationImage(
                                                  // image: NetworkImage(courseItem?.image_url ?? ''),
                                                  image: CachedNetworkImageProvider(
                                                      store.readerFromStorage
                                                              ?.avatar_url ??
                                                          ""),
                                                  fit: BoxFit.cover)
                                              : const DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/anonymous.jpg'),
                                                  fit: BoxFit.cover),
                                          // borderRadius: const BorderRadius.only(
                                          //     topLeft: Radius.circular(8.0),
                                          //     topRight: Radius.circular(8.0)),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 20.0, left: 30),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("name".tr,
                                                style: GoogleFonts.kantumruy(
                                                    textStyle: const TextStyle(
                                                        fontSize: 17.0,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            bottom: 20.0,
                                          ),
                                          width: widthScreen,
                                          child: Column(children: [
                                            CupertinoButton(
                                              pressedOpacity: 0.65,
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        store.readerFromStorage
                                                                ?.fullname ??
                                                            "name-notfound".tr,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 17),
                                                      )
                                                    ],
                                                  ),
                                                  // const Icon(
                                                  //   CupertinoIcons.chevron_right,
                                                  //   color: Colors.grey,
                                                  // ),
                                                ],
                                              ),
                                              onPressed: () {},
                                            ),
                                          ])),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 20.0, left: 30),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("card-code".tr,
                                                style: GoogleFonts.kantumruy(
                                                    textStyle: const TextStyle(
                                                        fontSize: 17.0,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                          ],
                                        ),
                                      ),
                                      Obx(
                                        () => Container(
                                            margin: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              bottom: 20.0,
                                            ),
                                            width: widthScreen,
                                            child: Column(children: [
                                              CupertinoButton(
                                                pressedOpacity: 0.65,
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20.0),
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        store.readerFromStorage
                                                                        ?.code !=
                                                                    null &&
                                                                store.readerFromStorage
                                                                        ?.code !=
                                                                    ''
                                                            ? Text(
                                                                "${store.readerFromStorage?.code}",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        17),
                                                              )
                                                            : Text(
                                                                "card-code-notfound"
                                                                    .tr,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        17),
                                                              )
                                                      ],
                                                    ),
                                                    // const Icon(
                                                    //   CupertinoIcons.chevron_right,
                                                    //   color: Colors.grey,
                                                    // ),
                                                  ],
                                                ),
                                                onPressed: () {},
                                              ),
                                            ])),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 20.0, left: 30),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("agent".tr,
                                                style: GoogleFonts.kantumruy(
                                                    textStyle: const TextStyle(
                                                        fontSize: 17.0,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                          ],
                                        ),
                                      ),
                                      Obx(
                                        () => Container(
                                            margin: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              bottom: 20.0,
                                            ),
                                            width: widthScreen,
                                            child: Column(children: [
                                              CupertinoButton(
                                                pressedOpacity: 0.65,
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20.0),
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        store.readerFromStorage
                                                                    ?.role ==
                                                                "student"
                                                            ? Text(
                                                                "agent-student"
                                                                    .tr,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        17),
                                                              )
                                                            : Text(
                                                                "agent-teacher"
                                                                    .tr,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        17),
                                                              )
                                                      ],
                                                    ),
                                                    // const Icon(
                                                    //   CupertinoIcons.chevron_right,
                                                    //   color: Colors.grey,
                                                    // ),
                                                  ],
                                                ),
                                                onPressed: () {},
                                              ),
                                            ])),
                                      ),
                                      Obx(() =>
                                          store.readerFromStorage?.role ==
                                                  "student"
                                              ? Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 20.0, left: 30),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("session-year".tr,
                                                          style: GoogleFonts.kantumruy(
                                                              textStyle: const TextStyle(
                                                                  fontSize:
                                                                      17.0,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))),
                                                    ],
                                                  ),
                                                )
                                              : Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 20.0, left: 30),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("subject-group".tr,
                                                          style: GoogleFonts.kantumruy(
                                                              textStyle: const TextStyle(
                                                                  fontSize:
                                                                      17.0,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))),
                                                    ],
                                                  ),
                                                )),
                                      Obx(() => store.readerFromStorage?.role ==
                                              "student"
                                          ? Container(
                                              margin: const EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                bottom: 20.0,
                                              ),
                                              width: widthScreen,
                                              child: Column(children: [
                                                CupertinoButton(
                                                  pressedOpacity: 0.65,
                                                  color: Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "${store.readerFromStorage?.start_years} - ${store.readerFromStorage?.end_years}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 17),
                                                          )
                                                        ],
                                                      ),
                                                      // const Icon(
                                                      //   CupertinoIcons.chevron_right,
                                                      //   color: Colors.grey,
                                                      // ),
                                                    ],
                                                  ),
                                                  onPressed: () {},
                                                ),
                                              ]))
                                          : Container(
                                              margin: const EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                bottom: 20.0,
                                              ),
                                              width: widthScreen,
                                              child: Column(children: [
                                                CupertinoButton(
                                                  pressedOpacity: 0.65,
                                                  color: Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          store.readerFromStorage
                                                                      ?.subject !=
                                                                  null
                                                              ? Text(
                                                                  "${store.readerFromStorage?.subject}",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          17),
                                                                )
                                                              : Text(
                                                                  "subjectgroup-notfound"
                                                                      .tr,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          17),
                                                                )
                                                        ],
                                                      ),
                                                      // const Icon(
                                                      //   CupertinoIcons.chevron_right,
                                                      //   color: Colors.grey,
                                                      // ),
                                                    ],
                                                  ),
                                                  onPressed: () {},
                                                ),
                                              ]))),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 20.0, left: 30),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("card-expired-date".tr,
                                                style: GoogleFonts.kantumruy(
                                                    textStyle: const TextStyle(
                                                        fontSize: 17.0,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                          ],
                                        ),
                                      ),
                                      Obx(
                                        () => Container(
                                            margin: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              bottom: 20.0,
                                            ),
                                            width: widthScreen,
                                            child: Column(children: [
                                              CupertinoButton(
                                                pressedOpacity: 0.65,
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20.0),
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        store.readerFromStorage
                                                                    ?.expired_date !=
                                                                null
                                                            ? Text(
                                                                DateFormat('HH:mm:ss dd-MM-yyyy').format(DateFormat(
                                                                        'HH:mm:ss dd-MM-yyyy')
                                                                    .parse(
                                                                        DateFormat('HH:mm:ss dd-MM-yyyy').format(DateFormat('yyyy-MM-ddTHH:mm:sssZ').parse(store.readerFromStorage?.expired_date ??
                                                                            "1900-01-01T00:00:000Z")),
                                                                        true)
                                                                    .toLocal()),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        17),
                                                              )
                                                            : Text(
                                                                "indefinite-term"
                                                                    .tr,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        17),
                                                              )
                                                      ],
                                                    ),
                                                    // const Icon(
                                                    //   CupertinoIcons.chevron_right,
                                                    //   color: Colors.grey,
                                                    // ),
                                                  ],
                                                ),
                                                onPressed: () {},
                                              ),
                                            ])),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 20.0, left: 30),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("unit".tr,
                                                style: GoogleFonts.kantumruy(
                                                    textStyle: const TextStyle(
                                                        fontSize: 17.0,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            bottom: 20.0,
                                          ),
                                          width: widthScreen,
                                          child: Column(children: [
                                            CupertinoButton(
                                              pressedOpacity: 0.65,
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      store.readerFromStorage
                                                                  ?.organizations ==
                                                              null
                                                          ? Text(
                                                              "unit-notfound"
                                                                  .tr,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 17),
                                                            )
                                                          : Text(
                                                              "${store.readerFromStorage?.organizations}",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 17),
                                                            )
                                                    ],
                                                  ),
                                                  // const Icon(
                                                  //   CupertinoIcons.chevron_right,
                                                  //   color: Colors.grey,
                                                  // ),
                                                ],
                                              ),
                                              onPressed: () {},
                                            ),
                                          ])),
                                    ])))
                        : Padding(
                            padding: EdgeInsets.only(
                                bottom: bottomPadding
                                // kBottomNavigationBarHeight
                                ),
                            child: SingleChildScrollView(
                                physics: const ClampingScrollPhysics(),
                                child: Column(children: [
                                  Center(
                                    child: Text(
                                      "reader-card".tr,
                                      style: GoogleFonts.kantumruy(
                                          textStyle: const TextStyle(
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black)),
                                    ),
                                  ),
                                  Container(
                                    child: Text("scan-guide".tr,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.kantumruy(
                                            textStyle: const TextStyle(
                                                fontSize: 17.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold))),
                                  ),
                                  (profile.reader.value?.userSite?.code != "" &&
                                          profile.reader.value?.userSite
                                                  ?.code !=
                                              null)
                                      ? Container(
                                          child: BarcodeWidget(
                                            data: profile.reader.value?.userSite
                                                    ?.code ??
                                                "",
                                            barcode: Barcode.code128(),
                                            drawText: false,
                                            width: widthScreen * 4 / 5,
                                          ),
                                        )
                                      : Container(
                                          child: Text("scan-guide-notfound".tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.kantumruy(
                                                  textStyle: const TextStyle(
                                                      fontSize: 17.0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                        ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // Container(
                                  //   margin: const EdgeInsets.only(
                                  //       bottom: 20.0, left: 10),
                                  //   child: SelectableText(
                                  //       "${store.accessTokenFromStorage}",
                                  //       style: GoogleFonts.kantumruy(
                                  //           textStyle: const TextStyle(
                                  //               fontSize: 17.0,
                                  //               color: Colors.black,
                                  //               fontWeight: FontWeight.bold))),
                                  // ),
                                  Container(
                                    width: widthScreen / 3,
                                    height: widthScreen * 4 / 9,
                                    decoration: BoxDecoration(
                                      image: profile.reader.value?.userSite
                                                      ?.metadata?.avatar_url !=
                                                  "" &&
                                              profile.reader.value?.userSite
                                                      ?.metadata?.avatar_url !=
                                                  null
                                          ? DecorationImage(
                                              // image: NetworkImage(courseItem?.image_url ?? ''),
                                              image: CachedNetworkImageProvider(
                                                  profile
                                                          .reader
                                                          .value
                                                          ?.userSite
                                                          ?.metadata
                                                          ?.avatar_url ??
                                                      ""),
                                              fit: BoxFit.cover)
                                          : const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/anonymous.jpg'),
                                              fit: BoxFit.cover),
                                      // borderRadius: const BorderRadius.only(
                                      //     topLeft: Radius.circular(8.0),
                                      //     topRight: Radius.circular(8.0)),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 20.0, left: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("name".tr,
                                            style: GoogleFonts.kantumruy(
                                                textStyle: const TextStyle(
                                                    fontSize: 17.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        bottom: 20.0,
                                      ),
                                      width: widthScreen,
                                      child: Column(children: [
                                        CupertinoButton(
                                          pressedOpacity: 0.65,
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    profile.profile.value
                                                            ?.fullname ??
                                                        "name-notfound".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17),
                                                  )
                                                ],
                                              ),
                                              // const Icon(
                                              //   CupertinoIcons.chevron_right,
                                              //   color: Colors.grey,
                                              // ),
                                            ],
                                          ),
                                          onPressed: () {},
                                        ),
                                      ])),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 20.0, left: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("card-code".tr,
                                            style: GoogleFonts.kantumruy(
                                                textStyle: const TextStyle(
                                                    fontSize: 17.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ],
                                    ),
                                  ),
                                  Obx(
                                    () => Container(
                                        margin: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          bottom: 20.0,
                                        ),
                                        width: widthScreen,
                                        child: Column(children: [
                                          CupertinoButton(
                                            pressedOpacity: 0.65,
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    profile
                                                                    .reader
                                                                    .value
                                                                    ?.userSite
                                                                    ?.code !=
                                                                null &&
                                                            profile
                                                                    .reader
                                                                    .value
                                                                    ?.userSite
                                                                    ?.code !=
                                                                ''
                                                        ? Text(
                                                            "${profile.reader.value?.userSite?.code}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 17),
                                                          )
                                                        : Text(
                                                            "card-code-notfound"
                                                                .tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 17),
                                                          )
                                                  ],
                                                ),
                                                // const Icon(
                                                //   CupertinoIcons.chevron_right,
                                                //   color: Colors.grey,
                                                // ),
                                              ],
                                            ),
                                            onPressed: () {},
                                          ),
                                        ])),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 20.0, left: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("agent".tr,
                                            style: GoogleFonts.kantumruy(
                                                textStyle: const TextStyle(
                                                    fontSize: 17.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ],
                                    ),
                                  ),
                                  Obx(
                                    () => Container(
                                        margin: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          bottom: 20.0,
                                        ),
                                        width: widthScreen,
                                        child: Column(children: [
                                          CupertinoButton(
                                            pressedOpacity: 0.65,
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    profile
                                                                .reader
                                                                .value
                                                                ?.userSite
                                                                ?.role ==
                                                            "student"
                                                        ? Text(
                                                            "agent-student".tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 17),
                                                          )
                                                        : Text(
                                                            "agent-teacher".tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 17),
                                                          )
                                                  ],
                                                ),
                                                // const Icon(
                                                //   CupertinoIcons.chevron_right,
                                                //   color: Colors.grey,
                                                // ),
                                              ],
                                            ),
                                            onPressed: () {},
                                          ),
                                        ])),
                                  ),
                                  Obx(() => profile
                                              .reader.value?.userSite?.role ==
                                          "student"
                                      ? Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 20.0, left: 30),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("session-year".tr,
                                                  style: GoogleFonts.kantumruy(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 17.0,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 20.0, left: 30),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("subject-group".tr,
                                                  style: GoogleFonts.kantumruy(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 17.0,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                            ],
                                          ),
                                        )),
                                  Obx(() => profile
                                              .reader.value?.userSite?.role ==
                                          "student"
                                      ? Container(
                                          margin: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            bottom: 20.0,
                                          ),
                                          width: widthScreen,
                                          child: Column(children: [
                                            CupertinoButton(
                                              pressedOpacity: 0.65,
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${profile.reader.value?.userSite?.metadata?.start_year} - ${profile.reader.value?.userSite?.metadata?.end_year}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 17),
                                                      )
                                                    ],
                                                  ),
                                                  // const Icon(
                                                  //   CupertinoIcons.chevron_right,
                                                  //   color: Colors.grey,
                                                  // ),
                                                ],
                                              ),
                                              onPressed: () {},
                                            ),
                                          ]))
                                      : Container(
                                          margin: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            bottom: 20.0,
                                          ),
                                          width: widthScreen,
                                          child: Column(children: [
                                            CupertinoButton(
                                              pressedOpacity: 0.65,
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      profile
                                                                  .reader
                                                                  .value
                                                                  ?.userSite
                                                                  ?.metadata
                                                                  ?.subject_groups !=
                                                              null
                                                          ? Text(
                                                              subject,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 17),
                                                            )
                                                          : Text(
                                                              "subjectgroup-notfound"
                                                                  .tr,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 17),
                                                            )
                                                    ],
                                                  ),
                                                  // const Icon(
                                                  //   CupertinoIcons.chevron_right,
                                                  //   color: Colors.grey,
                                                  // ),
                                                ],
                                              ),
                                              onPressed: () {},
                                            ),
                                          ]))),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 20.0, left: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("card-expired-date".tr,
                                            style: GoogleFonts.kantumruy(
                                                textStyle: const TextStyle(
                                                    fontSize: 17.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ],
                                    ),
                                  ),
                                  Obx(
                                    () => Container(
                                        margin: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          bottom: 20.0,
                                        ),
                                        width: widthScreen,
                                        child: Column(children: [
                                          CupertinoButton(
                                            pressedOpacity: 0.65,
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    profile
                                                                .reader
                                                                .value
                                                                ?.userSite
                                                                ?.metadata
                                                                ?.expired_date !=
                                                            null
                                                        ? Text(
                                                            DateFormat('HH:mm:ss dd-MM-yyyy').format(DateFormat(
                                                                    'HH:mm:ss dd-MM-yyyy')
                                                                .parse(
                                                                    DateFormat('HH:mm:ss dd-MM-yyyy').format(DateFormat('yyyy-MM-ddTHH:mm:sssZ').parse(profile
                                                                            .reader
                                                                            .value
                                                                            ?.userSite
                                                                            ?.metadata
                                                                            ?.expired_date ??
                                                                        "1900-01-01T00:00:000Z")),
                                                                    true)
                                                                .toLocal()),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 17),
                                                          )
                                                        : Text(
                                                            "indefinite-term"
                                                                .tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 17),
                                                          )
                                                  ],
                                                ),
                                                // const Icon(
                                                //   CupertinoIcons.chevron_right,
                                                //   color: Colors.grey,
                                                // ),
                                              ],
                                            ),
                                            onPressed: () {},
                                          ),
                                        ])),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 20.0, left: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("unit".tr,
                                            style: GoogleFonts.kantumruy(
                                                textStyle: const TextStyle(
                                                    fontSize: 17.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        bottom: 20.0,
                                      ),
                                      width: widthScreen,
                                      child: Column(children: [
                                        CupertinoButton(
                                          pressedOpacity: 0.65,
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  profile
                                                              .reader
                                                              .value
                                                              ?.userSite
                                                              ?.metadata
                                                              ?.organization ==
                                                          null
                                                      ? Text(
                                                          "unit-notfound".tr,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 17),
                                                        )
                                                      : Text(
                                                          "${profile.reader.value?.userSite?.metadata?.organization}",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 17),
                                                        )
                                                ],
                                              ),
                                              // const Icon(
                                              //   CupertinoIcons.chevron_right,
                                              //   color: Colors.grey,
                                              // ),
                                            ],
                                          ),
                                          onPressed: () {},
                                        ),
                                      ])),
                                ]))),
              ),
            )));
  }
}
