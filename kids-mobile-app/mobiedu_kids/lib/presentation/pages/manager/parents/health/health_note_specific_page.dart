import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/image_data.dart';
import 'package:mobiedu_kids/presentation/controllers/growth/growth_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/image_controller.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class HealthNoteSpecificChildPage extends StatelessWidget {
  HealthNoteSpecificChildPage({super.key, required this.ind});

  final int ind;
  final imageChildController = Get.put(ImageChildController());
  final growthController = Get.find<GrowthController>();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return WillPopScope(
      onWillPop: () async{
        ImageChildController.to.resetImageFile();
        Navigator.pop(context);
        return false;
      },
      child: GetX(
        init: growthController,
        initState: (state) async {
          growthController.height.text =
              growthController.listGrowth[ind]?.height ?? "";
          growthController.weight.text =
              growthController.listGrowth[ind]?.weight ?? "";
          growthController.eye.text =
              growthController.listGrowth[ind]?.eye ?? "";
          growthController.ear.text =
              growthController.listGrowth[ind]?.ear ?? "";
          growthController.blood_pressure.text =
              growthController.listGrowth[ind]?.blood_pressure ?? "";
          growthController.heart.text =
              growthController.listGrowth[ind]?.heart ?? "";
          growthController.nose.text =
              growthController.listGrowth[ind]?.nose ?? "";
          growthController.nutriture_status.text =
              growthController.listGrowth[ind]?.nutriture_status ?? "";
          growthController.description.text =
              growthController.listGrowth[ind]?.description ?? "";
                    growthController.Image.value = ImageData(
              source_file: growthController.listGrowth[ind]?.source_file ?? "",
              file_name: growthController.listGrowth[ind]?.file_name ?? "");
          growthController.dateNow.value = DateFormat('dd/MM/yyyy')
              .parse(growthController.listGrowth[ind]?.recorded_at ?? "");
              growthController.action.value = false;
        },
        builder: (state) => GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: CupertinoPageScaffold(
                resizeToAvoidBottomInset: false,
                navigationBar: CupertinoNavigationBar(
                  padding: const EdgeInsetsDirectional.only(top: 12.0),
                  leading: Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        ImageChildController.to.resetImageFile();
                        Navigator.pop(context);
                      },
                      child: Icon(
                        CupertinoIcons.back,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  middle: Text(
                    'Chỉ số sức khỏe',
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                          color: AppColors.primary,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  border: const Border(),
                ),
                child: Padding(
                    padding: EdgeInsets.only(
                        left: 28.0,
                        right: 28.0,
                        top: 20,
                        bottom: 10 + bottomPadding),
                    child: Column(
                      children: [
                        Expanded(
                            child: ListView(
                          physics: const ClampingScrollPhysics(),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Ngày tạo: ",
                                  style: GoogleFonts.raleway(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showCupertinoModalPopup(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            ShowDateGrowthNow());
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 50.0),
                                    alignment: Alignment.center,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              height: 30,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2,
                                                      color: AppColors.grey2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              child: Row(
                                                  // mainAxisAlignment:
                                                  //     MainAxisAlignment
                                                  //         .spaceBetween,
                                                  children: [
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      DateFormat('dd/MM/yyyy')
                                                          .format(
                                                              growthController
                                                                  .dateNow
                                                                  .value),
                                                      style:
                                                          GoogleFonts.raleway(
                                                        textStyle: TextStyle(
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    const Expanded(
                                                        child: SizedBox()),
                                                    Image.asset(
                                                      'assets/images/Union.png',
                                                      width: 15,
                                                      height: 15,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    )
                                                  ])),
                                          // Image.asset(
                                          //   'assets/images/calendar_page.png',
                                          //   width: 36,
                                          //   height: 36,
                                          // ),
                                        ]),
                                  ),
                                ),
                                const SizedBox()
                              ],
                            ),
                                                        Row(
                              children: [
                                Container(
                                    width: 100,
                                    child: Row(children: [
                                      const Expanded(child: SizedBox()),
                                      Text(
                                        "Chiều cao: ",
                                        style:
                                            GoogleFonts.raleway(fontSize: 14),
                                      ),
                                    ])),
                                Expanded(
                                    child: CupertinoTextField(
                                  controller: growthController.height,
                                  onEditingComplete: () {
                                    growthController.update();
                                  },
                                  onChanged: (value) {
                                    growthController.update();
                                  },
                                  style: GoogleFonts.raleway(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.transparent)),
                                )),
                                Container(
                                  child: Text(
                                    "cm",
                                    style: GoogleFonts.raleway(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            GetBuilder<GrowthController>(
                                builder: (cxt) => GrowthController
                                                    .to.action.value ? GrowthController
                                            .to.height.text ==
                                        ""
                                    ? Row(
                                        children: [
                                          Container(
                                              width: widthScreen - 56,
                                              child: Row(children: [
                                                Text(
                                                  "Trường chiều cao không được để trống",
                                                  style: GoogleFonts.raleway(
                                                      fontSize: 12,
                                                      color: AppColors.red),
                                                ),
                                              ])),
                                        ],
                                      )
                                    : SizedBox(): SizedBox()),
                            Row(
                              children: [
                                Container(
                                    width: 100,
                                    child: Row(children: [
                                      const Expanded(child: SizedBox()),
                                      Text(
                                        "Cân nặng: ",
                                        style:
                                            GoogleFonts.raleway(fontSize: 14),
                                      ),
                                    ])),
                                Expanded(
                                    child: CupertinoTextField(
                                  controller: growthController.weight,
                                  onEditingComplete: () {
                                    growthController.update();
                                  },
                                  onChanged: (value) {
                                    growthController.update();
                                  },
                                  style: GoogleFonts.raleway(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.transparent)),
                                )),
                                Container(
                                  child: Text(
                                    "kg",
                                    style: GoogleFonts.raleway(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            GetBuilder<GrowthController>(
                                builder: (cxt) => GrowthController
                                                    .to.action.value ? GrowthController
                                            .to.weight.text ==
                                        ""
                                    ? Row(
                                        children: [
                                          Container(
                                              width: widthScreen - 56,
                                              child: Row(children: [
                                                Text(
                                                  "Trường cân nặng không được để trống",
                                                  style: GoogleFonts.raleway(
                                                      fontSize: 12,
                                                      color: AppColors.red),
                                                ),
                                              ])),
                                        ],
                                      )
                                    : SizedBox(): SizedBox()),
                            Row(
                              children: [
                                Container(
                                    width: 100,
                                    child: Row(children: [
                                      const Expanded(child: SizedBox()),
                                      Text(
                                        "Dinh dưỡng: ",
                                        style:
                                            GoogleFonts.raleway(fontSize: 14),
                                      ),
                                    ])),
                                Expanded(
                                    child: CupertinoTextField(
                                  controller: growthController.nutriture_status,
                                  style: GoogleFonts.raleway(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.transparent)),
                                )),
                                // Container(
                                //   child: Text(
                                //     "cm",
                                //     style: GoogleFonts.raleway(),
                                //   ),
                                // ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    width: 100,
                                    child: Row(children: [
                                      const Expanded(child: SizedBox()),
                                      Text(
                                        "Nhịp tim: ",
                                        style:
                                            GoogleFonts.raleway(fontSize: 14),
                                      ),
                                    ])),
                                Expanded(
                                    child: CupertinoTextField(
                                  controller: growthController.heart,
                                  style: GoogleFonts.raleway(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.transparent)),
                                )),
                                Container(
                                  child: Text(
                                    "Nhịp/phút",
                                    style: GoogleFonts.raleway(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    width: 100,
                                    child: Row(children: [
                                      const Expanded(child: SizedBox()),
                                      Text(
                                        "Huyết áp: ",
                                        style:
                                            GoogleFonts.raleway(fontSize: 14),
                                      ),
                                    ])),
                                Expanded(
                                    child: CupertinoTextField(
                                  controller: growthController.blood_pressure,
                                  style: GoogleFonts.raleway(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.transparent)),
                                )),
                                Container(
                                  child: Text(
                                    "mmHg",
                                    style: GoogleFonts.raleway(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    width: 100,
                                    child: Row(children: [
                                      const Expanded(child: SizedBox()),
                                      Text(
                                        "Tai: ",
                                        style:
                                            GoogleFonts.raleway(fontSize: 14),
                                      ),
                                    ])),
                                Expanded(
                                    child: CupertinoTextField(
                                  controller: growthController.ear,
                                  style: GoogleFonts.raleway(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.transparent)),
                                )),
                                // Container(
                                //   child: Text(
                                //     "cm",
                                //     style: GoogleFonts.raleway(),
                                //   ),
                                // ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    width: 100,
                                    child: Row(children: [
                                      const Expanded(child: SizedBox()),
                                      Text(
                                        "Thị lực: ",
                                        style:
                                            GoogleFonts.raleway(fontSize: 14),
                                      ),
                                    ])),
                                Expanded(
                                    child: CupertinoTextField(
                                  controller: growthController.eye,
                                  style: GoogleFonts.raleway(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.transparent)),
                                )),
                                // Container(
                                //   child: Text(
                                //     "cm",
                                //     style: GoogleFonts.raleway(),
                                //   ),
                                // ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    width: 100,
                                    child: Row(children: [
                                      const Expanded(child: SizedBox()),
                                      Text(
                                        "Mũi: ",
                                        style:
                                            GoogleFonts.raleway(fontSize: 14),
                                      ),
                                    ])),
                                Expanded(
                                    child: CupertinoTextField(
                                  controller: growthController.nose,
                                  style: GoogleFonts.raleway(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.transparent)),
                                )),
                                // Container(
                                //   child: Text(
                                //     "cm",
                                //     style: GoogleFonts.raleway(),
                                //   ),
                                // ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CupertinoTextField(
                              controller: growthController.description,
                              style: GoogleFonts.raleway(fontSize: 14),
                              placeholder: "Ghi chú",
                              placeholderStyle:
                                  GoogleFonts.raleway(fontSize: 14),
                              minLines: 5,
                              maxLines: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 200,
                                    child: GetBuilder<ImageChildController>(
                                        init: ImageChildController(),
                                        builder: (controller) => (ImageChildController
                                                        .to.imageFile?.path !=
                                                    "" &&
                                                ImageChildController
                                                        .to.imageFile?.path !=
                                                    null)
                                            ? Column(children: [
                                                Stack(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .topEnd,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        child: Container(
                                                          width: 100,
                                                          height: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                            // image:
                                                            // DecorationImage(image: CachedNetworkImageProvider("https://kids.codeinet.com/content/uploads/${childController.Image.value?.source_file}"), fit: BoxFit.cover),
                                                            image: DecorationImage(
                                                                image: FileImage(File(
                                                                    ImageChildController
                                                                            .to
                                                                            .imageFile
                                                                            ?.path ??
                                                                        "")),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ),
                                                                                                         ]),
                                                const SizedBox(
                                                  height: 10,
                                                )
                                              ])
                                            : (growthController.Image.value
                                                                ?.source_file !=
                                                            "" &&
                                                        growthController
                                                                .Image
                                                                .value
                                                                ?.source_file !=
                                                            null) &&
                                                    (ImageChildController
                                                                .to
                                                                .imageFile
                                                                ?.path ==
                                                            "" ||
                                                        ImageChildController
                                                                .to
                                                                .imageFile
                                                                ?.path ==
                                                            null)
                                                ? Column(children: [
                                                    Stack(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .topEnd,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                            child: Container(
                                                              width: 100,
                                                              height: 100,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: CachedNetworkImageProvider(
                                                                        "${growthController.Image.value?.source_file}"),
                                                                    fit: BoxFit
                                                                        .cover),
                                                                // image: DecorationImage(image: FileImage(File(ImageRemarkController.to.imageFile?.path ?? "")), fit: BoxFit.cover),
                                                              ),
                                                            ),
                                                          ),
                                                                                                                  ]),
                                                    const SizedBox(
                                                      height: 10,
                                                    )
                                                  ])
                                                : const SizedBox()),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  GestureDetector(
                                    onTap: () async {
                                      showModalBottomSheet(
                                        backgroundColor:Colors.transparent,
                                        isScrollControlled: true,
                                        isDismissible: imageChildController.loading.value ? false : true,
                                        context: context,
                                        builder: ((builder) => GetBuilder<ImageChildController>(builder: ((_) => imageChildController.loading.value ? WillPopScope(onWillPop: () async { return false;} , child: Container(
                                                                decoration: const BoxDecoration(color: Colors.transparent),
                                                                child: const Center(child: CircularLoadingIndicator()),)) : Container(
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
                                              height: 120.0,
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
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    // "choose-avatar".tr,
                                                    "Chọn ảnh mới",
                                                    style: const TextStyle(
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
                                                          icon: Icon(
                                                            Icons.camera,
                                                            color:
                                                                AppColors.pink,
                                                          ),
                                                          onPressed: () async {
                                                            await imageChildController
                                                                .capturecamera(store
                                                                    .getPagename);
                                                                    Navigator.pop(context);
                                                          },
                                                          label: Text(
                                                            "camera".tr,
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .pink,
                                                            ),
                                                          ),
                                                        ),
                                                        TextButton.icon(
                                                          icon: Icon(
                                                            Icons.image,
                                                            color:
                                                                AppColors.pink,
                                                          ),
                                                          onPressed: () async {
                                                            await imageChildController
                                                                .capturegallery(
                                                                    store
                                                                        .getPagename);
                                                                        Navigator.pop(context);
                                                          },
                                                          label: Text(
                                                            "gallery".tr,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .pink),
                                                          ),
                                                        ),
                                                      ])
                                                ],
                                              ),
                                            )),
                                      )));
                                    },
                                    child: Image.asset(
                                      'assets/images/image_add.png',
                                      width: 15,
                                      height: 15,
                                    ),
                                  )
                                ])
                          ],
                        )),
                        Container(
                          padding: EdgeInsets.only(bottom: 10 + bottomPadding),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: widthScreen - 56,
                                    child: CupertinoButton(
                                        onPressed: () async {
                                          growthController.action.value = true;
                                          growthController.update();
                                          if (growthController.height.text !=
                                                  "" &&
                                              growthController.weight.text !=
                                                  "") {
                                            Uint8List? file;
                                            if (imageChildController
                                                        .imageFile?.path !=
                                                    "" &&
                                                imageChildController
                                                        .imageFile?.path !=
                                                    null) {
                                              file = await imageChildController
                                                  .imageFile
                                                  ?.readAsBytes();
                                              await growthController.editChild(
                                                  store.getChild?.child_id ??
                                                      "",
                                                  growthController
                                                          .listGrowth[ind]
                                                          ?.child_growth_id ??
                                                      "",
                                                  growthController.height.text,
                                                  growthController.weight.text,
                                                  growthController
                                                      .nutriture_status.text,
                                                  growthController.ear.text,
                                                  growthController.eye.text,
                                                  growthController
                                                      .blood_pressure.text,
                                                  growthController.heart.text,
                                                  growthController.nose.text,
                                                  growthController
                                                      .description.text,
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(growthController
                                                          .dateNow.value),
                                                  file);
                                            } else {
                                              await growthController.editChild(
                                                  store.getChild?.child_id ??
                                                      "",
                                                  growthController
                                                          .listGrowth[ind]
                                                          ?.child_growth_id ??
                                                      "",
                                                  growthController.height.text,
                                                  growthController.weight.text,
                                                  growthController
                                                      .nutriture_status.text,
                                                  growthController.ear.text,
                                                  growthController.eye.text,
                                                  growthController
                                                      .blood_pressure.text,
                                                  growthController.heart.text,
                                                  growthController.nose.text,
                                                  growthController
                                                      .description.text,
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(growthController
                                                          .dateNow.value),
                                                  null);
                                            }
                                                                                       await growthController.fetchChild(
                                                store.getChild
                                                        ?.child_parent_id ??
                                                    "",
                                                (growthController
                                                        .startMonth.value
                                                        .toInt())
                                                    .toString(),
                                                (growthController.endMonth.value
                                                        .toInt())
                                                    .toString());
                                            Navigator.pop(context);        
                                          } else {
                                            showAlertDialog(
                                                context,
                                                "Không được để trống trường",
                                                "Vui lòng nhập đầy đủ");
                                          }
                                        },
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 20.0),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: AppColors.pink,
                                        child: Text(
                                          'Lưu',
                                          style: GoogleFonts.raleway(
                                            textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ))),
                              ]),
                        ),
                      ],
                    ))))));
  }
}

class ShowDateGrowthNow extends StatelessWidget {
  ShowDateGrowthNow({Key? key}) : super(key: key);
  final growthController = Get.find<GrowthController>();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).copyWith().size.height / 3,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Hủy',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                            color: AppColors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Chọn',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                            color: AppColors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime newDateTime) async {
                  growthController.dateNow.value = newDateTime;
                },
                initialDateTime: growthController.dateNow.value,
                minimumYear: 1990,
                maximumDate: DateTime.now(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
