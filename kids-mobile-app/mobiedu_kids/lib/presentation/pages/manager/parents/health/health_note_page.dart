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
import 'package:mobiedu_kids/presentation/controllers/growth/growth_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/init_page_tab_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/image_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/health/widget/form_health.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class HealthNoteChildPage extends StatelessWidget {
  HealthNoteChildPage({super.key});

  final imageChildController = Get.put(ImageChildController());
  final growthController = Get.find<GrowthController>();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return GetX(
      init: growthController,
      initState: (_) {
        growthController.height.text = "";
        growthController.weight.text = "";
        growthController.eye.text = "";
        growthController.ear.text = "";
        growthController.blood_pressure.text = "";
        growthController.heart.text = "";
        growthController.nose.text = "";
        growthController.nutriture_status.text = "";
        growthController.description.text = "";
        growthController.Image.value = null;
        growthController.dateNow.value = DateTime.now();
        growthController.action.value = false;
      },
      builder: (_) => GestureDetector(
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
                  final initPageTabController = Get.put(InitPageTabController());
                  initPageTabController.changeIndexTab(1);
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
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
            backgroundColor: Colors.white,
            border: const Border(),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 20, bottom: 10 + bottomPadding),
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
                                textStyle:
                                TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.0,
                                  color: AppColors.black
                                ),
                              ),
                            ),
                            const SizedBox(width: 22.0),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (BuildContext context) =>ShowDateChildNow()
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.grey2
                                    ),
                                    borderRadius:BorderRadius.circular(8.0)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(DateFormat('dd/MM/yyyy').format(growthController.dateNow.value),
                                        style:GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                            color:AppColors.lightGrey,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ),
                                      Image.asset(
                                        'assets/images/Union.png',
                                        width: 12.0,
                                        height: 12.0,
                                      ),
                                    ]
                                  )
                                ),
                              ),
                            ),
                            const SizedBox(width: 60.0)
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  const Expanded(child: SizedBox()),
                                  Text(
                                    "Chiều cao: ",
                                    style: GoogleFonts.raleway(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black
                                    ),
                                  ),
                                ]
                              )
                            ),
                            Expanded(
                              child: CupertinoTextField(
                                controller: growthController.height,
                                keyboardType: TextInputType.number,
                                onEditingComplete: () {
                                  growthController.update();
                                },
                                onChanged: (value) {
                                  growthController.update();
                                },
                                style: GoogleFonts.raleway(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                  color: Colors.transparent)
                                ),
                              )
                            ),
                            Text(
                              "cm",
                              style: GoogleFonts.raleway(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.grey
                              ),
                            ),
                          ],
                        ),
                        GetBuilder<GrowthController>(
                          builder: (cxt) => GrowthController.to.action.value ? 
                          GrowthController.to.height.text == "" ? 
                          Row(
                            children: [
                              SizedBox(
                                width: widthScreen - 56,
                                child: Row(
                                  children: [
                                    Text(
                                      "Trường chiều cao không được để trống",
                                      style: GoogleFonts.raleway(
                                        fontSize: 12,
                                        color: AppColors.red
                                      ),
                                    ),
                                  ]
                                )
                              ),
                            ],
                          ) : 
                          const SizedBox(): 
                          const SizedBox()
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: SizedBox()
                                  ),
                                  Text(
                                    "Cân nặng: ",
                                    style: GoogleFonts.raleway(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black
                                    ),
                                  ),
                                ]
                              )
                            ),
                            Expanded(
                              child: CupertinoTextField(
                                controller: growthController.weight,
                                keyboardType: TextInputType.number,
                                onEditingComplete: () {
                                  growthController.update();
                                },
                                onChanged: (value) {
                                  growthController.update();
                                },
                                style: GoogleFonts.raleway(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.transparent
                                  )
                                ),
                              )
                            ),
                            Text(
                              "kg",
                              style: GoogleFonts.raleway(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.grey
                              ),
                            ),
                          ],
                        ),
                        GetBuilder<GrowthController>(
                          builder: (cxt) => GrowthController.to.action.value ? 
                          GrowthController.to.weight.text == "" ?
                          Row(
                            children: [
                              SizedBox(
                                  width: widthScreen - 56,
                                  child: Row(
                                    children: [
                                    Text(
                                      "Trường cân nặng không được để trống",
                                      style: GoogleFonts.raleway(
                                        fontSize: 12,
                                        color: AppColors.red
                                      ),
                                    ),
                                  ]
                                )
                              ),
                            ],
                          ) : 
                          const SizedBox() : 
                          const SizedBox()
                        ),
                        FormHealth(
                          title: 'Dinh dưỡng',
                          text: growthController.nutriture_status, 
                          type: ''
                        ),
                        FormHealth(
                          title: 'Nhịp tim',
                          text: growthController.heart, 
                          type: 'Nhịp/phút'
                        ),
                        FormHealth(
                          title: 'Huyết áp',
                          text: growthController.blood_pressure, 
                          type: 'mmHg'
                        ),
                        FormHealth(
                          title: 'Tai',
                          text: growthController.ear, 
                          type: ''
                        ),
                        FormHealth(
                          title: 'Thị lực',
                          text: growthController.eye, 
                          type: ''
                        ),
                        FormHealth(
                          title: 'Mũi',
                          text: growthController.nose, 
                          type: ''
                        ),
                        const SizedBox(height: 10.0),
                        CupertinoTextField(
                          controller: growthController.description,
                          style: GoogleFonts.raleway(
                            fontSize: 14,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500
                          ),
                          placeholder: "Ghi chú",
                          placeholderStyle: GoogleFonts.raleway(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.lightGrey
                          ),
                          minLines: 5,
                          maxLines: 10,
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 200,
                              child: GetBuilder<ImageChildController>(
                                init: ImageChildController(),
                                builder: (controller) => (ImageChildController.to.imageFile?.path != "" && ImageChildController.to.imageFile != null) ? 
                                Column(
                                  children: [
                                    Stack(
                                      alignment:AlignmentDirectional.topEnd,
                                      children: [
                                        ClipRRect(
                                          borderRadius:BorderRadius.circular(12.0),
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: FileImage(File(ImageChildController.to.imageFile?.path ??"")),
                                                fit: BoxFit.cover
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                    ),
                                    const SizedBox(height: 10.0)
                                  ]
                                ): 
                                (growthController.Image.value?.source_file != "" && growthController.Image.value?.source_file != null) &&
                                (ImageChildController.to.imageFile?.path == "" || ImageChildController.to.imageFile?.path == null)  ? 
                                Column(
                                  children: [
                                    Stack(
                                      alignment:AlignmentDirectional.topEnd,
                                      children: [
                                        ClipRRect(
                                          borderRadius:BorderRadius.circular(12.0),
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: CachedNetworkImageProvider("${urlImage()}${growthController.Image.value?.source_file}"),
                                                fit: BoxFit.cover
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                    ),
                                    const SizedBox(height: 10.0)
                                  ]
                                ) : 
                                const SizedBox()
                              ),
                            ),
                            const Expanded(
                              child: SizedBox()
                            ),
                            GestureDetector(
                              onTap: () async {
                                showModalBottomSheet(
                                  backgroundColor:Colors.transparent,
                                  isScrollControlled: true,
                                  isDismissible: imageChildController.loading.value ? false : true,
                                  context: context,
                                  builder: ((builder) => GetBuilder<ImageChildController>(
                                    builder: ((_) => imageChildController.loading.value ?
                                    WillPopScope(
                                      onWillPop: () async { return false;}, 
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent
                                        ),
                                        child: const Center(
                                          child: CircularLoadingIndicator()
                                        ),
                                      )
                                    ) : 
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white
                                      ),                    
                                      height: 120.0,
                                      width: MediaQuery.of(context).size.width,
                                      margin:const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 20,
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          const SizedBox(height: 20.0),
                                          Text(
                                            "Chọn ảnh mới",
                                            style: GoogleFonts.raleway(
                                              textStyle: TextStyle(
                                                color: AppColors.black, 
                                                fontSize: 20.0, fontWeight: 
                                                FontWeight.w700
                                              )
                                            ),
                                          ),
                                          const SizedBox(height: 20.0),
                                          Row(
                                            mainAxisAlignment:MainAxisAlignment.center,
                                            children: <Widget>[
                                              TextButton.icon(
                                                icon: Icon(
                                                  Icons.camera,
                                                  color:AppColors.pink,
                                                ),
                                                onPressed: () async {
                                                  await imageChildController.capturecamera(store.getPagename);
                                                  Navigator.pop(context);        
                                                },
                                                label: Text(
                                                  "camera".tr,
                                                  style: TextStyle(
                                                    color: AppColors.pink,
                                                  ),
                                                ),
                                              ),
                                              TextButton.icon(
                                                icon: Icon(
                                                  Icons.image,
                                                  color: AppColors.pink,
                                                ),
                                                onPressed: () async {
                                                  await imageChildController.capturegallery(store.getPagename);
                                                  Navigator.pop(context);            
                                                },
                                                label: Text(
                                                  "gallery".tr,
                                                  style: TextStyle(
                                                    color: AppColors.pink
                                                  ),
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
                          child: Image.asset(
                            'assets/images/image_add.png',
                            width: 15,
                            height: 15,
                          ),
                        )
                      ]
                    )
                  ],
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: widthScreen - 56,
                    child: CupertinoButton(
                      onPressed: () async {
                        growthController.action.value = true;
                        growthController.update();
                        if (growthController.height.text != "" && growthController.weight.text != "") {
                          Uint8List? file;
                          if (imageChildController.imageFile?.path != "" && imageChildController.imageFile?.path != null) {
                            file = await imageChildController.imageFile?.readAsBytes();
                            await growthController.addChild(
                              store.getChild?.child_parent_id ?? "",
                              growthController.height.text,
                              growthController.weight.text,
                              growthController.nutriture_status.text,
                              growthController.ear.text,
                              growthController.eye.text,
                              growthController.blood_pressure.text,
                              growthController.heart.text,
                              growthController.nose.text,
                              growthController.description.text,
                              DateFormat('dd/MM/yyyy').format(growthController.dateNow.value),
                              file
                            );
                              growthController.height.text = "";
                              growthController.weight.text = "";
                              growthController.nutriture_status.text = "";
                              growthController.ear.text = "";
                              growthController.eye.text = "";
                              growthController.blood_pressure.text = "";
                              growthController.heart.text = "";
                              growthController.nose.text = "";
                              growthController.description.text = "";
                              growthController.Image.value?.source_file = "";
                              GrowthController.to.action.value = false;
                              ImageChildController.to.resetImageFile();
                            } else {
                              await growthController.addChild(
                                store.getChild?.child_parent_id ?? "",
                                growthController.height.text,
                                growthController.weight.text,
                                growthController.nutriture_status.text,
                                growthController.ear.text,
                                growthController.eye.text,
                                growthController.blood_pressure.text,
                                growthController.heart.text,
                                growthController.nose.text,
                                growthController.description.text,
                                DateFormat('dd/MM/yyyy').format(growthController.dateNow.value),
                                null
                              );
                              growthController.height.text = "";
                              growthController.weight.text = "";
                              growthController.nutriture_status.text = "";
                              growthController.ear.text = "";
                              growthController.eye.text = "";
                              growthController.blood_pressure.text = "";
                              growthController.heart.text = "";
                              growthController.nose.text = "";
                              growthController.description.text = "";
                              GrowthController.to.action.value = false;
                              ImageChildController.to.resetImageFile();
                            }
                            await growthController.fetchChild(
                              store.getChild?.child_parent_id ?? "",
                              (growthController.startMonth.value.toInt()).toString(),
                              (growthController.endMonth.value.toInt()).toString()
                            );
                          } 
                        },
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                        borderRadius: BorderRadius.circular(10.0),
                        color: AppColors.pink,
                        child: Text(
                          'Lưu',
                          style: GoogleFonts.raleway(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700
                            ),
                        ),
                      )
                    )
                  ),
                ]
              ),
            ],
          )
        )
      )
    )
  );
  }
}

class ShowDateChildNow extends StatelessWidget {
  ShowDateChildNow({Key? key}) : super(key: key);
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
