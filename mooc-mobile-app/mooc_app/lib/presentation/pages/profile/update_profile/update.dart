import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/app/config/app_constants.dart';
import 'package:mooc_app/presentation/controllers/image_controller.dart';
import 'package:mooc_app/presentation/controllers/node_controller.dart';
import 'package:mooc_app/presentation/controllers/s3/s3_controller.dart';
import '../../../controllers/text_update_controller.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    final node = Get.put(NodeController());
    final tex = Get.put(TextUpdateProfileController());
    final image = Get.put(ImageController());
    final s3 = Get.find<S3Controller>();
    Future<bool> onWillPop() async {
      if (tex.nameText.text == tex.profile.profile.value?.data?.fullname &&
              tex.emailText.text == tex.profile.profile.value?.data?.email &&
              tex.phoneText.text == tex.profile.profile.value?.data?.phone &&
              tex.avatarText.text == tex.profile.profile.value?.data?.avatar &&
              ((tex.dobText.text == tex.profile.profile.value?.data?.dob) ||
                  (tex.dobText.text == "" &&
                      tex.profile.profile.value?.data?.dob == null)) &&
              tex.addressText.text == tex.profile.profile.value?.data?.address
          // &&
          // tex.cityText.text == tex.profile.profile.value?.data?.city
          // &&
          // tex.genderText.text == tex.profile.profile.value?.data?.gender
          ) {
        FocusScope.of(context).unfocus();
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.back();
        });
      } else {
        return (await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Không lưu thay đổi'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: const <Widget>[
                      Text('Dừng thay đổi và bỏ ?'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Thoát'),
                    onPressed: () {
                      Get.back();
                      FocusScope.of(context).unfocus();
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Get.back();
                      });
                    },
                  ),
                  TextButton(
                    child: const Text('Ở lại'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ],
              ),
            )) ??
            false;
      }
      return false;
    }

    return WillPopScope(
        onWillPop: onWillPop,
        child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: CupertinoPageScaffold(
                resizeToAvoidBottomInset: false,
                navigationBar: CupertinoNavigationBar(
                  leading: CupertinoButton(
                    onPressed: () async {
                      if (tex.nameText.text ==
                                  tex.profile.profile.value?.data?.fullname &&
                              tex.emailText.text ==
                                  tex.profile.profile.value?.data?.email &&
                              tex.phoneText.text ==
                                  tex.profile.profile.value?.data?.phone &&
                              tex.avatarText.text ==
                                  tex.profile.profile.value?.data?.avatar &&
                              ((tex.dobText.text ==
                                      tex.profile.profile.value?.data?.dob) ||
                                  (tex.dobText.text == "" &&
                                      tex.profile.profile.value?.data?.dob ==
                                          null)) &&
                              tex.addressText.text ==
                                  tex.profile.profile.value?.data?.address
                          // &&
                          // tex.cityText.text ==
                          //     tex.profile.profile.value?.data?.city
                          //     &&
                          // tex.genderText.text ==
                          //     tex.profile.profile.value?.data?.gender
                          ) {
                        FocusScope.of(context).unfocus();
                        Future.delayed(const Duration(milliseconds: 500), () {
                          Get.back();
                        });
                      } else {
                        (await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Không lưu thay đổi'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: const <Widget>[
                                      Text('Dừng thay đổi và bỏ ?'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Thoát'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      FocusScope.of(context).unfocus();
                                      Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () {
                                        Get.back();
                                      });
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Ở lại'),
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                  ),
                                ],
                              ),
                            )) ??
                            false;
                      }
                    },
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                    child: const Icon(
                      CupertinoIcons.chevron_back,
                      size: 32,
                    ),
                  ),
                  middle: const Text('Cập nhật tài khoản'),
                ),
                child: Obx(() => tex.isInitialized.value == true
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: CupertinoNavigationBar().preferredSize.height +
                                statusBarHeight),
                        child: Column(children: [
                          Container(
                            height: heightScreen -
                                CupertinoNavigationBar().preferredSize.height -
                                statusBarHeight -
                                bottomPadding -
                                ((heightScreen -
                                        CupertinoNavigationBar()
                                            .preferredSize
                                            .height -
                                        statusBarHeight -
                                        bottomPadding)) /
                                    12,
                            child: ListView(
                                padding: const EdgeInsets.only(top: 5),
                                physics: const ClampingScrollPhysics(),
                                children: [
                                  Container(
                                    child: const Center(
                                        child: Text("THÔNG TIN CÁ NHÂN")),
                                  ),
                                  Column(children: [
                                    CupertinoButton(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(right: 12),
                                            child: SizedBox(
                                                height: 28,
                                                width: 28,
                                                child: Icon(
                                                  FontAwesomeIcons.user,
                                                  color: Colors.black,
                                                )),
                                          ),
                                          Container(
                                            width: 100,
                                            child: Row(
                                              children: const [
                                                Text(
                                                  "Họ và tên",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: GetBuilder<
                                                TextUpdateProfileController>(
                                              // specify type as Controller
                                              init:
                                                  TextUpdateProfileController(), // intialize with the Controller
                                              builder: (value) => EditableText(
                                                  textAlign: TextAlign.right,
                                                  controller:
                                                      TextUpdateProfileController
                                                          .to.nameText,
                                                  focusNode: node.nameFocusNode,
                                                  // autofocus: true,
                                                  style: const TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 17),
                                                  cursorColor: Colors.cyan,
                                                  backgroundCursorColor:
                                                      Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onPressed: () {},
                                    ),
                                    CupertinoButton(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(right: 12),
                                            child: SizedBox(
                                                height: 28,
                                                width: 28,
                                                child: Icon(
                                                  FontAwesomeIcons.message,
                                                  color: Colors.black,
                                                )),
                                          ),
                                          Container(
                                            width: 100,
                                            child: Row(
                                              children: const [
                                                Text(
                                                  "Email",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: GetBuilder<
                                                TextUpdateProfileController>(
                                              // specify type as Controller
                                              init:
                                                  TextUpdateProfileController(), // intialize with the Controller
                                              builder: (value) => EditableText(
                                                  textAlign: TextAlign.right,
                                                  controller:
                                                      TextUpdateProfileController
                                                          .to.emailText,
                                                  focusNode:
                                                      node.emailFocusNode,
                                                  style: const TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 17),
                                                  cursorColor: Colors.cyan,
                                                  backgroundCursorColor:
                                                      Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onPressed: () {},
                                    ),
                                    CupertinoButton(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(right: 12),
                                            child: SizedBox(
                                                height: 28,
                                                width: 28,
                                                child: Icon(
                                                  FontAwesomeIcons.phone,
                                                  color: Colors.black,
                                                )),
                                          ),
                                          Container(
                                            width: 100,
                                            child: Row(
                                              children: const [
                                                Text(
                                                  "SĐT",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: GetBuilder<
                                                TextUpdateProfileController>(
                                              // specify type as Controller
                                              init:
                                                  TextUpdateProfileController(), // intialize with the Controller
                                              builder: (value) => EditableText(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  textAlign: TextAlign.right,
                                                  controller:
                                                      TextUpdateProfileController
                                                          .to.phoneText,
                                                  focusNode:
                                                      node.phoneFocusNode,
                                                  style: const TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 17),
                                                  cursorColor: Colors.cyan,
                                                  backgroundCursorColor:
                                                      Colors.grey),
                                            ),
                                          )
                                        ],
                                      ),
                                      onPressed: () {},
                                    ),
                                    CupertinoButton(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(right: 12),
                                            child: SizedBox(
                                                height: 28,
                                                width: 28,
                                                child: Icon(
                                                  FontAwesomeIcons.addressBook,
                                                  color: Colors.black,
                                                )),
                                          ),
                                          Container(
                                            width: 100,
                                            child: Row(
                                              children: const [
                                                Text(
                                                  "Địa chỉ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: GetBuilder<
                                                TextUpdateProfileController>(
                                              // specify type as Controller
                                              init:
                                                  TextUpdateProfileController(), // intialize with the Controller
                                              builder: (value) => EditableText(
                                                  textAlign: TextAlign.right,
                                                  controller:
                                                      TextUpdateProfileController
                                                          .to.addressText,
                                                  focusNode:
                                                      node.addressFocusNode,
                                                  style: const TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 17),
                                                  cursorColor: Colors.cyan,
                                                  backgroundCursorColor:
                                                      Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onPressed: () {},
                                    ),
                                    CupertinoButton(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(right: 12),
                                            child: SizedBox(
                                                height: 28,
                                                width: 28,
                                                child: Icon(
                                                  FontAwesomeIcons.birthdayCake,
                                                  color: Colors.black,
                                                )),
                                          ),
                                          Container(
                                            width: 100,
                                            child: Row(
                                              children: const [
                                                Text(
                                                  "Ngày sinh",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: GetBuilder<
                                                TextUpdateProfileController>(
                                              // specify type as Controller
                                              init:
                                                  TextUpdateProfileController(), // intialize with the Controller
                                              builder: (value) => EditableText(
                                                readOnly: true,
                                                textAlign: TextAlign.right,
                                                controller:
                                                    TextUpdateProfileController
                                                        .to.dobText,
                                                focusNode: node.dobFocusNode,
                                                style: const TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 17),
                                                cursorColor: Colors.cyan,
                                                backgroundCursorColor:
                                                    Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        _showDialog(
                                          context,
                                          CupertinoDatePicker(
                                            initialDateTime: tex.dobText.text ==
                                                    ""
                                                ? DateTime(1900)
                                                : DateFormat("yyyy-MM-dd")
                                                    .parse(tex.dobText.text),
                                            mode: CupertinoDatePickerMode.date,
                                            use24hFormat: true,
                                            onDateTimeChanged:
                                                (DateTime newDate) {
                                              tex.dobText.text =
                                                  DateFormat("yyyy-MM-dd")
                                                      .format(newDate);
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    // CupertinoButton(
                                    //   color: Colors.white,
                                    //   borderRadius: const BorderRadius.all(
                                    //     Radius.circular(0),
                                    //   ),
                                    //   padding: const EdgeInsets.symmetric(
                                    //       horizontal: 20, vertical: 16),
                                    //   alignment: Alignment.centerLeft,
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       const Padding(
                                    //         padding: EdgeInsets.only(right: 12),
                                    //         child: SizedBox(
                                    //             height: 28,
                                    //             width: 28,
                                    //             child: Icon(
                                    //               FontAwesomeIcons.city,
                                    //               color: Colors.black,
                                    //             )),
                                    //       ),
                                    //       Container(
                                    //         width: 100,
                                    //         child: Row(
                                    //           children: const [
                                    //             Text(
                                    //               "City",
                                    //               style: TextStyle(
                                    //                   color: Colors.black),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ),
                                    //       Expanded(
                                    //         child: EditableText(
                                    //             textAlign: TextAlign.right,
                                    //             controller: tex.cityText,
                                    //             focusNode: node.cityFocusNode,
                                    //             style: const TextStyle(
                                    //                 color: Colors.blue,
                                    //                 fontSize: 17),
                                    //             cursorColor: Colors.cyan,
                                    //             backgroundCursorColor: Colors.grey),
                                    //       ),
                                    //     ],
                                    //   ),
                                    //   onPressed: () {},
                                    // ),
                                    CupertinoButton(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 12),
                                            child: tex.genderText.text == "male"
                                                ? const SizedBox(
                                                    height: 28,
                                                    width: 28,
                                                    child: Icon(
                                                      FontAwesomeIcons.male,
                                                      color: Colors.black,
                                                    ))
                                                : tex.genderText.text ==
                                                        "female"
                                                    ? const SizedBox(
                                                        height: 28,
                                                        width: 28,
                                                        child: Icon(
                                                          FontAwesomeIcons
                                                              .female,
                                                          color: Colors.black,
                                                        ))
                                                    : const SizedBox(
                                                        height: 28,
                                                        width: 28,
                                                        child: Icon(
                                                          FontAwesomeIcons
                                                              .transgender,
                                                          color: Colors.black,
                                                        )),
                                          ),
                                          Container(
                                            width: 100,
                                            child: Row(
                                              children: const [
                                                Text(
                                                  "Giới tính",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: GetBuilder<
                                                TextUpdateProfileController>(
                                              // specify type as Controller
                                              init:
                                                  TextUpdateProfileController(), // intialize with the Controller
                                              builder: (value) => EditableText(
                                                  readOnly: true,
                                                  textAlign: TextAlign.right,
                                                  controller:
                                                      TextUpdateProfileController
                                                          .to.genderText,
                                                  focusNode:
                                                      node.genderFocusNode,
                                                  style: const TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 17),
                                                  cursorColor: Colors.cyan,
                                                  backgroundCursorColor:
                                                      Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        _showDialogGender(
                                          context,
                                          CupertinoPicker(
                                            itemExtent: 35,
                                            onSelectedItemChanged: (int value) {
                                              switch (value) {
                                                case 0:
                                                  tex.genderText.text = "male";
                                                  break;
                                                case 1:
                                                  tex.genderText.text =
                                                      "female";
                                                  break;
                                                case 2:
                                                  tex.genderText.text = "other";
                                                  break;
                                              }
                                            },
                                            children: const [
                                              Text("Nam"),
                                              Text("Nữ"),
                                              Text("Khác"),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    CupertinoButton(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(right: 12),
                                            child: SizedBox(
                                                height: 28,
                                                width: 28,
                                                child: Icon(
                                                  FontAwesomeIcons.photoFilm,
                                                  color: Colors.black,
                                                )),
                                          ),
                                          Container(
                                            width: 100,
                                            child: Row(
                                              children: const [
                                                Text(
                                                  "Avatar",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: Column(children: [
                                            GetBuilder<ImageController>(
                                              // specify type as Controller
                                              init:
                                                  ImageController(), // intialize with the Controller
                                              builder: (value) => Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  image: (ImageController
                                                                  .to
                                                                  .imageFile
                                                                  ?.path !=
                                                              "" &&
                                                          ImageController.to
                                                                  .imageFile !=
                                                              null)
                                                      ? DecorationImage(
                                                          // image: NetworkImage(courseItem?.image_url ?? ''),
                                                          image: FileImage(File(
                                                              ImageController
                                                                      .to
                                                                      .imageFile
                                                                      ?.path ??
                                                                  "")),
                                                          fit: BoxFit.cover)
                                                      : (tex.avatarText.text != "" &&
                                                              (ImageController
                                                                          .to
                                                                          .imageFile
                                                                          ?.path ==
                                                                      "" ||
                                                                  ImageController
                                                                          .to
                                                                          .imageFile ==
                                                                      null))
                                                          ? DecorationImage(
                                                              // image: NetworkImage(courseItem?.image_url ?? ''),
                                                              image: CachedNetworkImageProvider(tex.avatarText.text),
                                                              fit: BoxFit.cover)
                                                          : const DecorationImage(image: AssetImage('assets/images/course_image.png'), fit: BoxFit.cover),
                                                  // borderRadius: const BorderRadius.only(
                                                  //     topLeft: Radius.circular(8.0),
                                                  //     topRight: Radius.circular(8.0)),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            // Row(
                                            //     mainAxisAlignment:
                                            //         MainAxisAlignment.center,
                                            //     crossAxisAlignment:
                                            //         CrossAxisAlignment.end,
                                            //     children: [
                                            //       Container(
                                            //         width: 100,
                                            //         height: 100,
                                            //         decoration: BoxDecoration(
                                            //           image: tex.avatarText.text !=
                                            //                   ""
                                            //               ? DecorationImage(
                                            //                   // image: NetworkImage(courseItem?.image_url ?? ''),
                                            //                   image:
                                            //                       CachedNetworkImageProvider(
                                            //                           tex.avatarText
                                            //                                   .text),
                                            //                   fit: BoxFit.cover)
                                            //               : const DecorationImage(
                                            //                   image: AssetImage(
                                            //                       'assets/images/course_image.png'),
                                            //                   fit: BoxFit.cover),
                                            //           // borderRadius: const BorderRadius.only(
                                            //           //     topLeft: Radius.circular(8.0),
                                            //           //     topRight: Radius.circular(8.0)),
                                            //         ),
                                            //       ),
                                            //       const SizedBox(
                                            //         width: 10,
                                            //       ),
                                            //       Container(
                                            //         width: 50,
                                            //         height: 50,
                                            //         decoration: BoxDecoration(
                                            //           image: tex.avatarText.text !=
                                            //                   ""
                                            //               ? DecorationImage(
                                            //                   // image: NetworkImage(courseItem?.image_url ?? ''),
                                            //                   image:
                                            //                       CachedNetworkImageProvider(
                                            //                           tex.avatarText
                                            //                                   .text),
                                            //                   fit: BoxFit.cover)
                                            //               : const DecorationImage(
                                            //                   image: AssetImage(
                                            //                       'assets/images/course_image.png'),
                                            //                   fit: BoxFit.cover),
                                            //           // borderRadius: const BorderRadius.only(
                                            //           //     topLeft: Radius.circular(8.0),
                                            //           //     topRight: Radius.circular(8.0)),
                                            //         ),
                                            //       ),
                                            //       const SizedBox(
                                            //         width: 10,
                                            //       ),
                                            //       Container(
                                            //         width: 25,
                                            //         height: 25,
                                            //         decoration: BoxDecoration(
                                            //           image: tex.avatarText.text !=
                                            //                   ""
                                            //               ? DecorationImage(
                                            //                   // image: NetworkImage(courseItem?.image_url ?? ''),
                                            //                   image:
                                            //                       CachedNetworkImageProvider(
                                            //                           tex.avatarText
                                            //                                   .text),
                                            //                   fit: BoxFit.cover)
                                            //               : const DecorationImage(
                                            //                   image: AssetImage(
                                            //                       'assets/images/course_image.png'),
                                            //                   fit: BoxFit.cover),
                                            //           // borderRadius: const BorderRadius.only(
                                            //           //     topLeft: Radius.circular(8.0),
                                            //           //     topRight: Radius.circular(8.0)),
                                            //         ),
                                            //       ),
                                            //     ]),
                                            // Text(
                                            //   tex.avatarText.text,
                                            //   textAlign: TextAlign.right,
                                            //   style: TextStyle(
                                            //       color: Colors.blue, fontSize: 17),
                                            //   // cursorColor: Colors.cyan,
                                            //   // backgroundCursorColor: Colors.grey
                                            // ),
                                          ])),
                                        ],
                                      ),
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: ((builder) => Container(
                                                height: 100.0,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 20,
                                                ),
                                                child: Column(
                                                  children: <Widget>[
                                                    const Text(
                                                      "Chọn ảnh tài khoản",
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          TextButton.icon(
                                                            icon: const Icon(
                                                                Icons.camera),
                                                            onPressed:
                                                                () async {
                                                              await image
                                                                  .changecameraAvatar();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              showSnackbar(
                                                                  SnackbarType
                                                                      .notice,
                                                                  'Thông báo',
                                                                  'Đã chọn tạm avatar mới từ camera');
                                                            },
                                                            label: const Text(
                                                                "Máy ảnh"),
                                                          ),
                                                          TextButton.icon(
                                                            icon: const Icon(
                                                                Icons.image),
                                                            onPressed:
                                                                () async {
                                                              await image
                                                                  .changegalleryAvatar();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              showSnackbar(
                                                                  SnackbarType
                                                                      .notice,
                                                                  'Thông báo',
                                                                  'Đã chọn tạm avatar mới từ thư viện ảnh');
                                                            },
                                                            label: const Text(
                                                                "Thư viện ảnh"),
                                                          ),
                                                        ])
                                                  ],
                                                ),
                                              )),
                                        );
                                      },
                                    ),
                                  ]),
                                ]),
                          ),
                          Expanded(
                              child: Container(
                                  child: GestureDetector(
                                      onTap: () async {
                                        var fullname = tex.nameText.text.trim();
                                        var email = tex.emailText.text.trim();
                                        var phone = tex.phoneText.text.trim();
                                        var isOK = false;
                                        if (fullname.isEmpty) {
                                          isOK = false;
                                        } else if (email.isEmpty) {
                                          isOK = true;
                                        } else if (!isValidEmail(email)) {
                                          isOK = false;
                                        } else if (phone.isEmpty) {
                                          isOK = true;
                                        } else if (!isValidPhone(phone)) {
                                          isOK = false;
                                        } else {
                                          isOK = true;
                                        }
                                        if (isOK) {
                                          if (image.imageFile?.path != "" &&
                                              image.imageFile != null) {
                                            final imageBinary = await image
                                                .imageFile
                                                ?.readAsBytes();
                                            await s3.uploadS3(
                                                "avatar.jpg",
                                                imageBinary,
                                                image.imageFile?.mimeType ??
                                                    "image/jpeg");
                                          }
                                          await tex.updateProfile(
                                              tex.nameText.text,
                                              tex.emailText.text,
                                              tex.phoneText.text,
                                              tex.dobText.text,
                                              tex.avatarText.text,
                                              tex.addressText.text,
                                              tex.genderText.text,
                                              tex.cityText.text);
                                          await tex.profile.fetchDataInit();
                                          await tex
                                              .updateprofileInitilization();
                                        } else {
                                          showAlertDialog(context, 'Thông báo',
                                              'Vui lòng điền chính xác thông tin cá nhân!');
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Container(
                                                  color: Colors.blue,
                                                  child: const Center(
                                                      child: Text(
                                                          "Cập nhật tài khoản",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          )))))
                                        ],
                                      ))))
                        ]))
                    : Column(children: [
                        Container(child: const CircularProgressIndicator())
                      ])))));
  }
}

void _showDialog(BuildContext context, Widget child) {
  showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
            height: 200,
            padding: const EdgeInsets.only(top: 6.0),
            // The Bottom margin is provided to align the popup above the system navigation bar.
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            // Provide a background color for the popup.
            color: CupertinoColors.systemBackground.resolveFrom(context),
            // Use a SafeArea widget to avoid system overlaps.
            child: SafeArea(
              top: false,
              child: child,
            ),
          ));
}

void _showDialogGender(BuildContext context, Widget child) {
  showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
            height: 120,
            padding: const EdgeInsets.only(top: 6.0),
            // The Bottom margin is provided to align the popup above the system navigation bar.
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            // Provide a background color for the popup.
            color: CupertinoColors.systemBackground.resolveFrom(context),
            // Use a SafeArea widget to avoid system overlaps.
            child: SafeArea(
              top: false,
              child: child,
            ),
          ));
}
