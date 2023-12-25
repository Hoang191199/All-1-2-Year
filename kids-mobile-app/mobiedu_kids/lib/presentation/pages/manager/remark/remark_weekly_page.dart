import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
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
import 'package:mobiedu_kids/presentation/controllers/remark/image_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/remark/remark_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/speech_controller.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class RemarkWeeklyPage extends StatelessWidget {
  RemarkWeeklyPage({super.key, this.id, this.index});

  final String? id;
  final int? index;

  final remarkController = Get.find<RemarkController>();
  final sttController = Get.put(STTController());
  final store = Get.find<LocalStorageService>();
  final imageRemarkController = Get.put(ImageRemarkController());

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return GetX(
      init: remarkController,
      initState: (state) async {
        await remarkController.fetchMonthly(
          store.getGroupname,
          DateFormat("dd/MM/yyyy").format(remarkController.dateNow.value.subtract(Duration(days: remarkController.dateNow.value.weekday - 1))),
          DateFormat("dd/MM/yyyy").format(remarkController.dateNow.value.add(Duration(days: DateTime.daysPerWeek -remarkController.dateNow.value.weekday))),
        );
        await remarkController.fetchTemplate(store.getGroupname, "week");
        remarkController.numberId.value = index ?? 0;
        remarkController.thisId.value = id ?? "";
        try{
          if ((remarkController.listMonthlyChild[remarkController.numberId.value].metadata != "") &&
          (remarkController.listMonthlyChild[remarkController.numberId.value].metadata != null)) {
            final listPhoto = <ImageData>[];
            for (var i = 0; i < List<ImageData>.from(jsonDecode(remarkController.listMonthlyChild[remarkController.numberId.value].metadata ?? "").map((x) => ImageData.fromJson(x))).length; i++) {
              listPhoto.add(
                ImageData(
                  source_file: List<ImageData>.from(jsonDecode(remarkController.listMonthlyChild[remarkController.numberId.value].metadata ?? "").map((x) => ImageData.fromJson(x)))[i].source_file,
                  file_name: List<ImageData>.from(jsonDecode(remarkController.listMonthlyChild[remarkController.numberId.value].metadata ??"").map((x) => ImageData.fromJson(x)))[i].file_name
                )
              );
            }
            remarkController.listMonthlyImage.assignAll(listPhoto);
          } else {
            remarkController.listMonthlyImage.value = [];
          }
        }
        catch(e) {
          remarkController.listMonthlyImage.value = [];
        }
        remarkController.quickImageInfoMonthly.value = ImageData(
          source_file: remarkController.listMonthlyChild[remarkController.numberId.value].source_file_cert,
          file_name: remarkController.listMonthlyChild[remarkController.numberId.value].file_name_cert
        );
        remarkController.quickMonthlyTitleTextController.text = remarkController.listMonthlyChild[remarkController.numberId.value].title ?? "";
        remarkController.quickMonthlyTextController.text =  remarkController.listMonthlyChild[remarkController.numberId.value].content ?? "";
      },
      builder: (state) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: CupertinoPageScaffold(
            resizeToAvoidBottomInset: false,
            navigationBar: CupertinoNavigationBar(
              padding: const EdgeInsetsDirectional.only(top: 19.0),
              leading: Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    CupertinoIcons.back,
                    color: AppColors.primary,
                  ),
                ),
              ),
              middle: GestureDetector(
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) =>ShowDateMonthlyNow()
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 50.0),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/calendar_page.png',
                        width: 36,
                        height: 36,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        DateFormat('dd/MM/yyyy').format(remarkController.dateNow.value),
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.primary,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    ]
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              border: const Border(),
            ),
            child: remarkController.isweekLoading.value ? 
            const Center(
              child: CircularLoadingIndicator(),
            ) :
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10 + bottomPadding),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                      physics: const ClampingScrollPhysics(),
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10,  left: 28, right: 28),
                          child: CupertinoButton(
                            pressedOpacity: 0.65,
                            color: AppColors.lightPink,
                            borderRadius: const BorderRadius.all(Radius.circular(50)),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment:MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${remarkController.listMonthlyChild[remarkController.numberId.value].child_name}",
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  )
                                ]
                              ),
                              onPressed: () {
                                _showDialog(context);
                              },
                            )
                          ),
                        const SizedBox(height: 20.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                "Thông báo ngay",
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0
                                  ),
                                ),
                              )
                            ),
                            CupertinoSwitch(
                              value: remarkController.isNotifiedMonthly.value,
                              onChanged: (value) {
                                remarkController.isNotifiedMonthly.value = value;
                              }
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: 200,
                                child: Text(
                                  "Sử dụng mẫu nhận xét",
                                  style: GoogleFonts.raleway(
                                    textStyle:TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0
                                    ),
                                  ),
                                )),
                              CupertinoSwitch(
                                value: remarkController.templateUse.value,
                                onChanged: (value) {
                                  remarkController.templateUse.value = value;
                                }
                              )
                              ],
                            ),
                            remarkController.templateUse.value ? 
                            const SizedBox(height: 20.0) :
                            const SizedBox(),
                            remarkController.templateUse.value ? 
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: widthScreen - 56,
                                  child: CupertinoButton(
                                    onPressed: () async {
                                      List<SimpleDialogOption>
                                      items = List.generate(remarkController.listTemplate.length, (i) =>
                                        SimpleDialogOption(
                                          onPressed: () {
                                            remarkController.quickMonthlyTitleTextController.text = remarkController.listTemplate[i]?.title ?? "";
                                            remarkController.quickMonthlyTextController.text = remarkController.listTemplate[i]?.content ?? "";
                                            Navigator.pop(context);
                                          },
                                            child: Text('Mẫu nhận xét ${i + 1}'),
                                        ),
                                      );
                                      showDialog(
                                        context:
                                            context,
                                        builder: (context) =>
                                            SimpleDialog(
                                          title: const Text('Lựa chọn mẫu nhận xét'),
                                          children: items,
                                        ),
                                      );
                                    },
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: AppColors.grey2,
                                    child: Text(
                                      'Chọn mẫu nhận xét',
                                      style: GoogleFonts.raleway(
                                        textStyle: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    )
                                  )
                                ),
                              ]
                            ): 
                            const SizedBox(),
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 75,
                                  child: Text(
                                    "Tiêu đề: ",
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  )
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: CupertinoTextField(
                                      controller: remarkController.quickMonthlyTitleTextController,
                                      style: GoogleFonts.raleway(
                                        textStyle: TextStyle(
                                          fontSize: 12.0,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      placeholder: "Nhập tiêu đề",
                                      placeholderStyle: GoogleFonts.raleway(
                                        textStyle: TextStyle(
                                          fontSize: 12.0,
                                          color: AppColors.grey,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.lightGrey
                                        ),
                                        borderRadius: const BorderRadius.all(Radius.circular(10.0))
                                      ),
                                      autocorrect: false,
                                      keyboardType:TextInputType.multiline,
                                      minLines: 1,
                                      maxLines: 10,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 75,
                                  child: Text(
                                    "Nội dung: ",
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  )
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: CupertinoTextField(
                                      controller: remarkController.quickMonthlyTextController,
                                      style: GoogleFonts.raleway(
                                        textStyle: TextStyle(
                                          fontSize: 12.0,
                                          color: AppColors.black,
                                        ),
                                      ),
                                      placeholder: "Nhập nội dung",
                                      placeholderStyle: GoogleFonts.raleway(
                                        textStyle: TextStyle(
                                          fontSize: 12.0,
                                          color: AppColors.grey,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: AppColors.lightGrey),
                                        borderRadius: const BorderRadius.all(Radius.circular(10.0))
                                      ),
                                      autocorrect: false,
                                      keyboardType: TextInputType.multiline,
                                      minLines: 5,
                                      maxLines: 10,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 6.0 ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CupertinoCheckbox(
                                  checkColor: Colors.white,
                                  activeColor:AppColors.green,
                                  value: remarkController.applyAll.value,
                                  onChanged: (value) {
                                    remarkController.applyAll.value = value ?? false;
                                  }
                                ),
                                Text(
                                  "Áp dụng cho tất cả",
                                  style: GoogleFonts.raleway(
                                    textStyle:TextStyle(
                                      fontSize: 14.0,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox( height: 6.0,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    sttController.isListening.value = false;
                                    sttController.toggle(remarkController.quickMonthlyTextController);
                                    await showModalBottomSheet<void>(
                                      showDragHandle: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius:BorderRadius.vertical(top: Radius.circular(25.0)),
                                      ),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Padding(
                                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                          child: SingleChildScrollView(
                                              physics: const ClampingScrollPhysics(),
                                              child: Column(
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      "Thêm ghi âm",
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.raleway(
                                                        textStyle: TextStyle(
                                                          color: AppColors.primary, 
                                                          fontSize: 22.0, 
                                                          fontWeight: FontWeight.w700
                                                        )
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 24.0),
                                                  AvatarGlow(
                                                    endRadius: 100.0,
                                                    animate: true,
                                                    glowColor: AppColors.pink,
                                                    duration: const Duration(milliseconds: 2000),
                                                    repeatPauseDuration: const Duration(milliseconds: 100),
                                                    repeat: true,
                                                    child: Stack(
                                                      alignment: AlignmentDirectional.center,
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/Ellipse 2.png',
                                                          width: 150.0,
                                                          height: 150.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        Image.asset(
                                                          'assets/images/Ellipse 3.png',
                                                          width: 100.0,
                                                          height: 100.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        Image.asset(
                                                          'assets/images/microphone.png',
                                                          width: 50.0,
                                                          height: 50.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 24.0),
                                                  GetBuilder<STTController>(
                                                    init: STTController(),
                                                    builder: (controller) => Center(
                                                      child: Text(
                                                        STTController.to.temp.text,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: GoogleFonts.raleway(
                                                          textStyle: const TextStyle(
                                                            fontSize: 15.0, 
                                                            color: Colors.black
                                                          )
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height:24.0),
                                                  Container(
                                                    padding: const EdgeInsets.only(left: 28, right: 28, bottom: 20),
                                                    child: CupertinoButton(
                                                      pressedOpacity: 0.65,
                                                      color: AppColors.pink,
                                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                      alignment: Alignment.centerLeft,
                                                      child: const Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Lưu",
                                                                style: TextStyle(color: Colors.white),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    )
                                                  )
                                                ],
                                              ),
                                            )
                                          );
                                        },
                                      );
                                      sttController.toggle(remarkController.quickMonthlyTextController);
                                      sttController.temp.text = "";
                                      sttController.isListening.value = false;
                                    },
                                    child: const SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: ClipOval(
                                        child: Image(
                                          image:AssetImage('assets/images/micro.png'),
                                          fit: BoxFit.cover
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  GestureDetector(
                                    onTap: () async {
                                      showModalBottomSheet(
                                        backgroundColor:Colors.transparent,
                                        isDismissible: false,
                                        isScrollControlled: true,
                                        context: context,
                                        builder: ((builder) => GetBuilder<ImageRemarkController>(
                                          builder: ((_) => imageRemarkController.loading.value ? 
                                          WillPopScope(
                                            onWillPop: () async { return false;}, 
                                            child: Container(
                                              decoration: const BoxDecoration(color: Colors.transparent),
                                              child: const Center(
                                                child: CircularLoadingIndicator()
                                              )
                                            )
                                          ) :
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.white
                                            ),
                                            height: 120.0,
                                            width: MediaQuery.of(context).size.width,
                                            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20,
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              const SizedBox(height: 20.0),
                                              Text(
                                                "Chọn ảnh mới",
                                                style: GoogleFonts.raleway(
                                                  textStyle: TextStyle(
                                                    color: AppColors.black, 
                                                    fontSize: 20.0, 
                                                    fontWeight: FontWeight.w700
                                                  )
                                                ),
                                              ),
                                              const SizedBox(height: 20.0),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  TextButton.icon(
                                                    icon: Icon(
                                                      Icons.image,
                                                      color: AppColors.pink,
                                                    ),
                                                    onPressed: () async {
                                                      await imageRemarkController.captureMultigallery(store.getPagename);
                                                      Navigator.pop(context);
                                                    },
                                                    label: Text(
                                                      "gallery".tr,
                                                      style: TextStyle(color: AppColors.pink),
                                                    ),
                                                  ),
                                                ]
                                              )
                                            ],
                                          ),
                                        )
                                      ),
                                    )
                                  )
                                );
                              },
                              child: const Stack(
                                alignment: AlignmentDirectional .center,
                                children: [
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: ClipOval(
                                      child: Image(
                                        image:  AssetImage('assets/images/add_image_background.png'),
                                        fit: BoxFit.cover
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child:
                                        ClipOval(
                                      child: Image(
                                          image:
                                              AssetImage(
                                            'assets/images/add_image.png',
                                          ),
                                          fit: BoxFit
                                              .cover),
                                    ),
                                  ),
                                ]
                              ),
                            ),
                            const Expanded(
                              child: SizedBox()
                            ),
                            Column(
                              children: [
                                GetBuilder<ImageRemarkController>(
                                  init:ImageRemarkController(),
                                  builder: (controller) => (ImageRemarkController.to.remarkController.quickImageInfoMonthly.value?.source_file !="" &&
                                  ImageRemarkController.to.remarkController.quickImageInfoMonthly.value?.source_file != null &&
                                  ImageRemarkController.to.remarkController.quickImageInfoMonthly.value?.source_file !="null") ? 
                                  Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12.0),
                                        child: Container(
                                          width: 100,
                                          height:100,
                                          decoration:
                                            BoxDecoration(
                                              image: DecorationImage(
                                                image: CachedNetworkImageProvider("${urlImage()}${ImageRemarkController.to.remarkController.quickImageInfoMonthly.value?.source_file}"), 
                                                fit: BoxFit.cover
                                              ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height:10 )
                                    ]
                                  ) : 
                                  const SizedBox()
                                ),
                                CupertinoButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      backgroundColor:Colors.transparent,
                                      isDismissible: false,
                                      isScrollControlled: true,
                                      context: context,
                                      builder: ((builder) => GetBuilder<ImageRemarkController>(
                                        builder: ((_) => imageRemarkController.loading.value ? 
                                        WillPopScope(
                                          onWillPop: () async { return false;}, 
                                          child: Container(
                                            decoration: const BoxDecoration(color: Colors.transparent),
                                            child: const Center(child: CircularLoadingIndicator())
                                          )
                                        ) :
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.white
                                          ),
                                          height: 120.0,
                                          width: MediaQuery.of(context).size.width,
                                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20,),
                                          child: Column(
                                            children: <Widget>[
                                              const SizedBox(height: 20),
                                              Text(
                                                "Chọn ảnh mới",
                                                style: GoogleFonts.raleway(
                                                  textStyle: TextStyle(
                                                    color: AppColors.black, 
                                                    fontSize: 20.0, 
                                                    fontWeight: FontWeight.w700
                                                  )
                                                ),
                                              ),
                                              const SizedBox(height: 20,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  TextButton.icon(
                                                    icon: Icon(
                                                      Icons.camera,
                                                      color: AppColors.pink,
                                                    ),
                                                    onPressed: () async {
                                                      await imageRemarkController.quickchangecameraMonthlyCert(store.getPagename);
                                                      Navigator.pop(context);
                                                    },
                                                    label: Text(
                                                      "camera".tr,
                                                      style: TextStyle(color: AppColors.pink),
                                                    ),
                                                  ),
                                                  TextButton.icon(
                                                    icon: Icon(
                                                      Icons.image,
                                                      color: AppColors.pink,
                                                    ),
                                                    onPressed: () async {
                                                      await imageRemarkController.quickchangegalleryMonthlyCert(store.getPagename);
                                                      Navigator.pop(context);
                                                    },
                                                    label: Text(
                                                      "gallery".tr,
                                                      style: TextStyle(color: AppColors.pink),
                                                    ),
                                                  ),
                                                ]
                                              )
                                            ],
                                          ),
                                        )
                                      ),
                                    )
                                  )
                                );
                              },
                              padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 8.0),
                              borderRadius: BorderRadius.circular(10.0),
                              color: AppColors.pink,
                              child: Center(
                                child: Text(
                                  'Chọn phiếu bé ngoan',
                                  style: GoogleFonts.raleway(
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight:FontWeight.w700
                                    ),
                                  ),
                                )
                              )
                            )
                          ]
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 150,
                      child: ListView.separated(
                        itemCount: remarkController.listMonthlyImage.length,
                        itemBuilder: (context, index) {
                        return GetBuilder<ImageRemarkController>(
                          init: ImageRemarkController(),
                            builder: (controller) => (remarkController.listMonthlyImage[index].source_file != "" &&
                            remarkController.listMonthlyImage[index].source_file != null &&
                            remarkController.listMonthlyImage[index].source_file != "null"
                            ) ? 
                            Column(
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider("${urlImage()}${remarkController.listMonthlyImage[index].source_file}"), 
                                            fit: BoxFit.cover
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        remarkController.listMonthlyImage.removeAt(index);
                                      },
                                      child: const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: ClipOval(
                                          child: Image(
                                            image: AssetImage(
                                              'assets/images/close_alt.png',
                                            ),
                                            fit: BoxFit.cover
                                          ),
                                        ),
                                      )
                                    )
                                  ]
                                ),
                                const SizedBox(
                                  height:
                                      10,
                                )
                              ]
                            ) :
                            const SizedBox()
                          );
                        },
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 10,
                          );
                        },
                      ),
                    ),
                  ]
                ),
              ),
              Row(
                mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: widthScreen - 56,
                    child: CupertinoButton(
                      onPressed: () async {
                        if (remarkController.applyAll.value) {
                          var listNote = <String>[];
                          for (var i = 0; i < remarkController.listMonthlyChild.length; i++) {
                            listNote.add(remarkController.quickMonthlyTextController.text);
                          }
                          var listNoteTitle = <String>[];
                          for (var i = 0; i < remarkController.listMonthlyChild.length; i++) {
                            listNoteTitle.add(remarkController.quickMonthlyTitleTextController.text);
                          }
                          var listId = <String>[];
                          for (var i = 0; i < remarkController.listMonthlyChild.length; i++) {
                            listId.add(remarkController.listMonthlyChild[i].child_id ??"");
                          }
                          var listsource = <String>[];
                          var listfilename = <String>[];
                          for (var i = 0; i < remarkController.listMonthlyChild.length; i++) {
                            listsource.add(imageRemarkController.remarkController.quickImageInfoMonthly.value!.source_file ?? "");
                            listfilename.add(imageRemarkController.remarkController.quickImageInfoMonthly.value!.file_name ?? "");
                          }
                          await remarkController.reviewMonthly(
                            store.getGroupname,
                            DateFormat("dd/MM/yyyy").format(remarkController.dateNow.value.subtract(Duration(days: remarkController.dateNow.value.weekday - 1))),
                            DateFormat("dd/MM/yyyy").format(remarkController.dateNow.value.add(Duration(days: DateTime.daysPerWeek - remarkController.dateNow.value.weekday))),
                            listNote,
                            listNoteTitle,
                            listId,
                            listsource,
                            listfilename,
                            remarkController.listMonthlyChild.length,
                            jsonEncode(remarkController.listMonthlyImage),
                            remarkController.isNotifiedMonthly.value ? 1 : 0
                          );
                        } else {
                          var listNote = <String>[];
                          listNote.add(remarkController.quickMonthlyTextController.text);
                          var listNoteTitle = <String>[];
                          listNoteTitle.add(remarkController.quickMonthlyTitleTextController.text);
                          var listId =<String>[];
                          listId.add(remarkController.thisId.value);
                          var listsource = <String>[];
                          var listfilename = <String>[];
                          listsource.add(imageRemarkController.remarkController.quickImageInfoMonthly.value!.source_file ?? "");
                          listfilename.add(imageRemarkController.remarkController.quickImageInfoMonthly.value!.file_name ??"");
                          await remarkController.reviewMonthly(
                            store.getGroupname,
                            DateFormat("dd/MM/yyyy").format(remarkController.dateNow.value.subtract(Duration(days: remarkController.dateNow.value.weekday - 1))),
                            DateFormat("dd/MM/yyyy").format(remarkController.dateNow.value.add(Duration(days: DateTime.daysPerWeek - remarkController.dateNow.value.weekday))),
                            listNote,
                            listNoteTitle,
                            listId,
                            listsource,
                            listfilename,
                            1,
                            jsonEncode(remarkController.listMonthlyImage),
                            remarkController.isNotifiedMonthly.value ? 1 : 0
                          );    
                        }
                        Navigator.pop(context);},
                        padding: const EdgeInsets.symmetric(horizontal:10.0, vertical:20.0),
                        borderRadius: BorderRadius.circular(10.0),
                        color: AppColors.pink,
                        child: Text(
                          'Lưu',
                          style: GoogleFonts.raleway(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight:FontWeight.w700
                            ),
                          ),
                        )
                      )
                    ),
                  ]
                )
              ]
            )
          )
        )
      )
    )
  ));
  }

  void _showDialog(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: heightScreen / 3,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
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
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700
                          ),
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
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32.0,
                  scrollController: FixedExtentScrollController(
                    initialItem: remarkController.numberId.value,
                  ),
                  onSelectedItemChanged: (int selectedItem) async {
                    remarkController.numberId.value = selectedItem;
                    try{
                    if ((remarkController.listMonthlyChild[remarkController.numberId.value].metadata !="") &&
                      (remarkController.listMonthlyChild[remarkController.numberId.value].metadata != null)) {
                      final listPhoto = <ImageData>[];
                      for (var i = 0; i < List<ImageData>.from(jsonDecode(remarkController.listMonthlyChild[remarkController.numberId.value].metadata ?? "").map((x) => ImageData.fromJson(x))).length; i++) {
                      listPhoto.add(
                        ImageData(
                          source_file: List<ImageData>.from(jsonDecode(remarkController.listMonthlyChild[remarkController.numberId.value].metadata ?? "").map((x) => ImageData.fromJson(x)))[i].source_file,
                          file_name: List<ImageData>.from(jsonDecode(remarkController.listMonthlyChild[remarkController.numberId.value].metadata ??"").map((x) => ImageData.fromJson(x)))[i].file_name
                        )
                      );
                    }
                    remarkController.listMonthlyImage.assignAll(listPhoto);
                  }
                  else {
                    remarkController.listMonthlyImage.value = [];
                  }
                }
                catch(e) {
                  remarkController.listMonthlyImage.value = [];
                }
                  remarkController.quickImageInfoMonthly.value = ImageData(
                    source_file: remarkController.listMonthlyChild[remarkController.numberId.value].source_file_cert,
                    file_name: remarkController.listMonthlyChild[remarkController.numberId.value].file_name_cert
                  );
                  remarkController.quickMonthlyTitleTextController.text = remarkController.listMonthlyChild[remarkController.numberId.value].title ?? "";
                  remarkController.quickMonthlyTextController.text = remarkController.listMonthlyChild[remarkController.numberId.value].content ?? "";
                  remarkController.thisId.value = remarkController.listMonthlyChild[remarkController.numberId.value].child_id ?? "";
                },
                children: List<Widget>.generate(
                  remarkController.listMonthlyChild.length, (int index) {
                    return Center(
                      child: Text(remarkController.listMonthlyChild[index].child_name ?? "")
                    );
                  }
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowDateMonthlyNow extends StatelessWidget {
  ShowDateMonthlyNow({Key? key}) : super(key: key);
  final remarkController = Get.find<RemarkController>();
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
                          fontWeight: FontWeight.w700
                        ),
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
                          fontWeight: FontWeight.w700
                        ),
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
                  remarkController.dateNow.value = newDateTime;
                  await remarkController.fetchMonthly(
                    store.getGroupname,
                    DateFormat("dd/MM/yyyy").format(remarkController.dateNow.value.subtract(Duration(days:remarkController.dateNow.value.weekday - 1))),
                    DateFormat("dd/MM/yyyy").format(remarkController.dateNow.value.add(Duration(days: DateTime.daysPerWeek - remarkController.dateNow.value.weekday)))
                  );
                  if ((remarkController.listMonthlyChild[remarkController.numberId.value].metadata != "") &&
                  (remarkController.listMonthlyChild[remarkController.numberId.value].metadata != null)) {
                    for (var i = 0;  i < List<ImageData>.from(jsonDecode(remarkController.listMonthlyChild[remarkController.numberId.value].metadata ?? "").map((x) => ImageData.fromJson(x))).length; i++) {
                      remarkController.listMonthlyImage.add(
                        ImageData(
                          source_file: List<ImageData>.from(jsonDecode(remarkController.listMonthlyChild[remarkController.numberId.value].metadata ?? "").map((x) => ImageData.fromJson(x)))[i].source_file,
                          file_name: List<ImageData>.from(jsonDecode(remarkController.listMonthlyChild[remarkController.numberId.value].metadata ?? "").map((x) => ImageData.fromJson(x)))[i].file_name
                        )
                      );
                    }
                  }
                  remarkController.quickImageInfoMonthly.value?.source_file = remarkController.listMonthlyChild[remarkController.numberId.value].source_file_cert;
                  remarkController.quickImageInfoMonthly.value?.file_name = remarkController.listMonthlyChild[remarkController.numberId.value].file_name_cert;
                  remarkController.quickMonthlyTitleTextController.text = remarkController.listMonthlyChild[remarkController.numberId.value].title ??"";
                  remarkController.quickDailyTextController.text =  remarkController.listMonthlyChild[remarkController.numberId.value].content ?? "";
                },
                initialDateTime: remarkController.dateNow.value,
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
