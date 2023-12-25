import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/services/local_storage.dart';
import 'package:qltv/presentation/controllers/bookcase/bookcase_controller.dart';
import 'package:qltv/presentation/controllers/image_controller.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';
import 'package:qltv/presentation/controllers/profile/profile_controller.dart';
import 'option/profile_item.dart';

class AccountPage extends GetView<LoginController> {
  AccountPage({super.key});

  final loginController = Get.find<LoginController>();
  final store = Get.find<LocalStorageService>();
  final profile = Get.find<ProfileController>();
  final image = Get.put(ImageController());
  final bookcaseController = Get.find<BookcaseController>();
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async {
          Get.back();
          await profile.fetchProfile();
          return false;
        },
        child: Scaffold(
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
                child: Obx(
                  () => Container(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            child: Row(children: [
                              Container(
                                width: widthScreen / 6,
                                child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () async {
                                      Get.back();
                                      await profile.fetchProfile();
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
                                    "general-setting".tr,
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
                          Stack(children: [
                            GestureDetector(
                              child: GetBuilder<ImageController>(
                                init: ImageController(),
                                initState: (state) async {
                                  ImageController.to.imageFile == null;
                                  await ImageController.to.profile
                                      .fetchProfile();
                                },
                                builder: (value) => image.isLoading.value
                                    ? Container(
                                        child: const Center(
                                            child: CircularProgressIndicator()),
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            image: (ImageController.to.imageFile?.path != "" &&
                                                    ImageController.to.imageFile !=
                                                        null)
                                                ? DecorationImage(
                                                    // image: NetworkImage(courseItem?.image_url ?? ''),
                                                    image: FileImage(File(ImageController
                                                            .to
                                                            .imageFile
                                                            ?.path ??
                                                        "")),
                                                    fit: BoxFit.cover)
                                                : (store.userFromStorage?.avatar_url != "" &&
                                                        store.userFromStorage
                                                                ?.avatar_url !=
                                                            null &&
                                                        (ImageController
                                                                    .to
                                                                    .imageFile
                                                                    ?.path ==
                                                                "" ||
                                                            ImageController.to
                                                                    .imageFile ==
                                                                null))
                                                    ? DecorationImage(
                                                        image: CachedNetworkImageProvider(store.userFromStorage?.avatar_url ?? ""),
                                                        fit: BoxFit.cover)
                                                    : const DecorationImage(image: AssetImage('assets/images/anonymous.jpg'), fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                              ),
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => Container(
                                        height: 100.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 20,
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "choose-avatar".tr,
                                              style: const TextStyle(
                                                fontSize: 20.0,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  TextButton.icon(
                                                    icon: const Icon(
                                                      Icons.camera,
                                                      color: Colors.teal,
                                                    ),
                                                    onPressed: () async {
                                                      await image
                                                          .changecameraAvatar(
                                                              context);
                                                      await image.tex
                                                          .updateprofileInitilization();
                                                    },
                                                    label: Text(
                                                      "camera".tr,
                                                      style: const TextStyle(
                                                          color: Colors.teal),
                                                    ),
                                                  ),
                                                  TextButton.icon(
                                                    icon: const Icon(
                                                      Icons.image,
                                                      color: Colors.teal,
                                                    ),
                                                    onPressed: () async {
                                                      await image
                                                          .changegalleryAvatar(
                                                              context);
                                                      await image.tex
                                                          .updateprofileInitilization();
                                                    },
                                                    label: Text(
                                                      "gallery".tr,
                                                      style: const TextStyle(
                                                          color: Colors.teal),
                                                    ),
                                                  ),
                                                ])
                                          ],
                                        ),
                                      )),
                                );
                              },
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  child: const Icon(
                                      CupertinoIcons.pencil_circle_fill),
                                ))
                          ]),
                          const SizedBox(
                            height: 20,
                          ),
                          GetBuilder<ProfileController>(
                            // specify type as Controller/ intialize with the Controller
                            initState: (state) async {
                              await ProfileController.to.fetchProfile();
                            },
                            builder: (value) => Container(
                              child: Center(
                                child: Text(
                                  "${store.userFromStorage?.fullname}",
                                  style: GoogleFonts.kantumruy(
                                    textStyle: const TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                "describe".tr,
                                style: GoogleFonts.kantumruy(
                                  textStyle: const TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  left: widthScreen / 10,
                                  right: widthScreen / 10),
                              width: widthScreen,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: (widthScreen - widthScreen / 5) / 3,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          child: const CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 20,
                                            child: Icon(
                                              CupertinoIcons.book,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        bookcaseController.responseData.value
                                                    ?.data?.total !=
                                                // profile.reader.value?.borrowing
                                                //             ?.publications !=
                                                null
                                            ? Container(
                                                child: Center(
                                                  child: Text(
                                                    "${bookcaseController.responseData.value?.data?.total}",
                                                    // "${profile.reader.value?.borrowing?.publications}",
                                                    style:
                                                        GoogleFonts.kantumruy(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 15.0,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                child: Center(
                                                  child: Text(
                                                    "0",
                                                    style:
                                                        GoogleFonts.kantumruy(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 15.0,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          child: Center(
                                            child: Text(
                                              "statistic-publication".tr,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.kantumruy(
                                                textStyle: const TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: (widthScreen - widthScreen / 5) / 3,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          child: const CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 20,
                                            child: Icon(
                                              CupertinoIcons.clock,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          child: Center(
                                            child: Text(
                                              "50",
                                              style: GoogleFonts.kantumruy(
                                                textStyle: const TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          child: Center(
                                            child: Text(
                                              "statistic-reading-hour".tr,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.kantumruy(
                                                textStyle: const TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width:
                                          (widthScreen - widthScreen / 5) / 3,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            child: const CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 20,
                                              child: Icon(
                                                CupertinoIcons.bolt,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            child: Center(
                                              child: Text(
                                                "80",
                                                style: GoogleFonts.kantumruy(
                                                  textStyle: const TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            child: Center(
                                              child: Text(
                                                "statistic-pageperhour".tr,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.kantumruy(
                                                  textStyle: const TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.only(left: 28, right: 28),
                              child: Column(children: [
                                ProfileItem(
                                  titleItem: "notification".tr,
                                  typeItem: 'notification',
                                  icon: CupertinoIcons.bell,
                                  order: 1,
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                ProfileItem(
                                  titleItem: "lending-history".tr,
                                  typeItem: 'history',
                                  icon: CupertinoIcons
                                      .arrow_right_arrow_left_circle,
                                  order: 2,
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                ProfileItem(
                                  titleItem: "setting".tr,
                                  typeItem: 'setting',
                                  icon: CupertinoIcons.gear,
                                  order: 3,
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                ProfileItem(
                                  titleItem: "rate".tr,
                                  typeItem: 'rate',
                                  icon: CupertinoIcons.star,
                                  order: 4,
                                )
                              ])),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.only(left: 28, right: 28),
                              child: CupertinoButton(
                                pressedOpacity: 0.65,
                                color: Colors.red,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "log-out".tr,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                onPressed: () async {
                                  await loginController.logout();
                                },
                              ))
                        ],
                      ),
                    ),
                  ),
                ))));
  }
}
