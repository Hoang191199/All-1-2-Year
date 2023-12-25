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
import 'package:mobiedu_kids/presentation/controllers/list_student/child_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/image_controller.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/no_data.dart';

class HealthNotePage extends StatelessWidget {
  HealthNotePage({super.key});

  final childController = Get.find<ChildController>();
  final imageChildController = Get.put(ImageChildController());
  final growthController = Get.find<GrowthController>();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return
      WillPopScope(
        onWillPop: () async {
          ImageChildController.to.resetImageFile();
          Navigator.pop(context);
          return false;
        },
        child: GetX(
          init: childController,
          initState: (state) async {
            await childController.fetch(store.getGroupname);
            childController.currentStudent.value = 0;
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
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                backgroundColor: Colors.white,
                border: const Border(),
              ),
              child: childController.isLoading.value ? 
              const Center(
                child: CircularLoadingIndicator()
              ) : 
              childController.listStudent.isEmpty ? 
              const NoData() : 
              Padding(
                padding: EdgeInsets.only(
                  left: 28.0,
                  right: 28.0,
                  top: 20,
                  bottom: 10 + bottomPadding
                ),
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
                                textStyle: TextStyle(
                                  fontWeight:FontWeight.w700,
                                  fontSize: 14.0,
                                  color: AppColors.black
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (BuildContext context) => ShowDateChildNow()
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 50.0),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 2,
                                          color: AppColors.grey2
                                        ),
                                        borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 5),
                                          Text(
                                            DateFormat('dd/MM/yyyy').format(childController.dateNow.value),
                                            style: GoogleFonts.raleway(
                                              textStyle: TextStyle(
                                                color: AppColors.lightGrey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            child: SizedBox()
                                          ),
                                          Image.asset(
                                            'assets/images/Union.png',
                                            width: 15,
                                            height: 15,
                                          ),
                                          const SizedBox(width: 5)
                                        ]
                                      )
                                    ),
                                  ]
                                ),
                              ),
                            ),
                            const SizedBox()
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10, left: 28, right: 28),
                          child: CupertinoButton(
                            pressedOpacity: 0.65,
                            color: AppColors.lightPink,
                            borderRadius:const BorderRadius.all(Radius.circular(50)),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text("${childController.listStudent[childController.currentStudent.value]?.child_name}",
                                      style: GoogleFonts.raleway(
                                        textStyle: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ]
                                )
                              ]
                            ),
                            onPressed: () {
                              _showDialog(context);
                            },
                          )
                        ),
                        Row(
                          children: [
                            textIndex('Chiều cao'),
                            Expanded(
                              child: CupertinoTextField(
                                keyboardType: TextInputType.number,
                                controller: growthController.height,
                                onEditingComplete: () {
                                  growthController.update();
                                },
                                onChanged: (value) {
                                  growthController.update();
                                },
                                style: GoogleFonts.raleway(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.black
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:Colors.transparent
                                  )
                                ),
                              )
                            ),
                            Text(
                              "cm",
                              style: GoogleFonts.raleway(
                                fontSize: 14.0,
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
                                          fontSize: 12.0,
                                          color: AppColors.red,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ]
                                  )
                                ),
                              ],
                            ) : const SizedBox(): const SizedBox()
                          ),
                          Row(
                            children: [
                              textIndex('Cân nặng'),
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
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:Colors.transparent
                                    )
                                  ),
                                )
                              ),
                              Text(
                                "kg",
                                style: GoogleFonts.raleway(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey
                                ),
                              ),
                            ],
                          ),
                          GetBuilder<GrowthController>(
                          builder: (cxt) => GrowthController.to.action.value ? 
                          GrowthController.to.weight.text == ""? 
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
                                          color: AppColors.red,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ]
                                  )
                                ),
                              ],
                            ) : const SizedBox() : const SizedBox()
                          ),
                          Row(
                            children: [
                            textIndex('Dinh dưỡng'),
                            textField(growthController.nutriture_status, '')
                          ],
                        ),
                        Row(
                          children: [
                            textIndex('Nhịp tim'),
                            textField(growthController.heart, 'number'),
                            Text(
                              "Nhịp/phút",
                              style: GoogleFonts.raleway(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.grey
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            textIndex('Huyết áp'),
                            textField(growthController.blood_pressure, ''),
                            Text(
                              "mmHg",
                              style: GoogleFonts.raleway(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.grey
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            textIndex('Tai'),
                            textField(growthController.ear, ''),
                          ],
                        ),
                        Row(
                          children: [
                            textIndex('Thị lực'),
                            textField(growthController.eye, ''),
                          ],
                        ),
                        Row(
                          children: [
                            textIndex('Mũi'),
                            textField(growthController.nose, ''),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        CupertinoTextField(
                          controller: growthController.description,
                          style: GoogleFonts.raleway(
                            color: AppColors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500
                          ),
                          placeholder: "Ghi chú",
                          placeholderStyle: GoogleFonts.raleway(
                            fontSize: 14.0,
                            color: AppColors.lightGrey,
                          ),
                          minLines: 5,
                          maxLines: 10,
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 200.0,
                              child: GetBuilder<ImageChildController>(
                                init: ImageChildController(),
                                builder: (controller) => (
                                ImageChildController.to.imageFile?.path != "" && ImageChildController.to.imageFile != null) ? 
                                Column(
                                  children: [
                                    Stack(
                                      alignment: AlignmentDirectional.topEnd,
                                      children: [
                                        ClipRRect(
                                          borderRadius:BorderRadius.circular(12.0),
                                          child: Container(
                                            width: 100.0,
                                            height: 100.0,
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
                                    const SizedBox(height: 10)
                                  ]
                                ) : 
                                (growthController.Image.value?.source_file != "" && growthController.Image.value?.source_file != null) 
                                && (ImageChildController.to.imageFile?.path == "" || ImageChildController.to.imageFile == null) ? 
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
                                                image: CachedNetworkImageProvider("${urlImage()}${growthController.Image.value?.source_file}"), 
                                                fit: BoxFit.cover
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                    ),
                                    const SizedBox(height: 10)
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
                                  builder: (
                                    (builder) => GetBuilder<ImageChildController>(
                                      builder: ((_) => imageChildController.loading.value ? 
                                        WillPopScope(
                                          onWillPop: () async { return false;} , 
                                          child: Container(
                                            decoration: const BoxDecoration(color: Colors.transparent),
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
                                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                          child: Column(
                                            children: <Widget>[
                                              const SizedBox(height: 20),
                                                Text(
                                                  "Chọn ảnh mới",
                                                  style: GoogleFonts.raleway(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.black
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                Row(
                                                  mainAxisAlignment:MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    TextButton.icon(
                                                      icon:Icon(
                                                        Icons.camera,
                                                        color:AppColors.pink,
                                                      ),
                                                      onPressed: () async {
                                                        await imageChildController.capturecamera(store.getPagename);
                                                        Navigator.pop(context);
                                                      },
                                                      label: Text(
                                                        "camera".tr,
                                                        style: GoogleFonts.raleway(
                                                          fontSize: 14.0,
                                                          fontWeight: FontWeight.w600,
                                                          color: AppColors.pink
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
                                                        style: GoogleFonts.raleway(
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.w600,
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
                              await growthController.add(
                                store.getGroupname,
                                childController.listStudent[childController.currentStudent.value]?.child_id ?? "",
                                growthController.height.text,
                                growthController.weight.text,
                                growthController.nutriture_status.text,
                                growthController.ear.text,
                                growthController.eye.text,
                                growthController.blood_pressure.text,
                                growthController.heart.text,
                                growthController.nose.text,
                                growthController.description.text,
                                DateFormat('dd/MM/yyyy').format(childController.dateNow.value),
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
                              ImageChildController.to.resetImageFile();
                              GrowthController.to.action.value = false;
                            } else {
                              await growthController.add(
                                store.getGroupname,
                                childController.listStudent[childController.currentStudent.value]?.child_id ?? "",
                                growthController.height.text,
                                growthController.weight.text,
                                growthController.nutriture_status.text,
                                growthController.ear.text,
                                growthController.eye.text,
                                growthController.blood_pressure.text,
                                growthController.heart.text,
                                growthController.nose.text,
                                growthController.description.text,
                                DateFormat('dd/MM/yyyy').format(childController.dateNow.value),
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
                          }
                        },
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                        borderRadius: BorderRadius.circular(10.0),
                        color: AppColors.pink,
                        child: Text(
                          'Lưu',
                          style: GoogleFonts.raleway(
                            textStyle:const TextStyle(
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
      )
    );
  }

  void _showDialog(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    // final managerController = Get.put(ManagerController());
    // final splashController = Get.find<SplashScreenController>();
    // final data = splashController.responseManagerData.value?.data?.classes;

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
                    initialItem: 0,
                  ),
                  onSelectedItemChanged: (int selectedItem) async {
                    childController.currentStudent.value = selectedItem;
                  },
                  children: List<Widget>.generate(
                    childController.listStudent.length, (int index) {
                      return Center(
                        child: Text("${childController.listStudent[index]?.child_name}")
                      );
                    }
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textIndex(String text){
    return SizedBox(
      width: 100,
      child: Row(
        children: [
          const Expanded(
            child: SizedBox()
          ),
          Text(
            "$text: ",
            style: GoogleFonts.raleway(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: AppColors.grey
            ),
          ),
        ]
      )
    );
  }

  Widget textField(TextEditingController controller, String? type){
    return Expanded(
      child: CupertinoTextField(
        keyboardType: type == 'number' ? TextInputType.number : TextInputType.text,
        controller: controller,
        style: GoogleFonts.raleway(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.black
        ),
        decoration: BoxDecoration(
          border: Border.all(color:Colors.transparent)
        ),
      )
    );
  }
}

class ShowDateChildNow extends StatelessWidget {
  ShowDateChildNow({Key? key}) : super(key: key);
  final childController = Get.find<ChildController>();
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
                  childController.dateNow.value = newDateTime;
                },
                initialDateTime: childController.dateNow.value,
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
