import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/data_student.dart';
import 'package:mobiedu_kids/presentation/controllers/shuttle/shuttle_controller.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class AddStudentToShuttle extends StatelessWidget {
  AddStudentToShuttle({super.key});

  final shuttleController = Get.find<ShuttleController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return GetX(
      init: shuttleController,
      builder: (_) {
        var studentTemp = List<DataStudent>.from(shuttleController.listStudentWithClass);
        return Scaffold(
        body: GestureDetector(
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
                    Navigator.pop(context);
                  },
                  child: const Icon(CupertinoIcons.back),
                ),
              ),
              middle: Text(
                'Thêm học sinh',
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
            child: shuttleController.isLoadingListChild.value ?
              SizedBox(
                width: widthScreen,
                child: const Center(
                  child: CircularLoadingIndicator(),
                ),
              )
            : Container(
              margin: const EdgeInsets.only(top: 6.0),
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _showClass(context);
                      },
                      child: Text(shuttleController.nameClass.value,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      )
                    ),
                  ),
                  shuttleController.listStudentWithClass.isNotEmpty ?
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Chọn tất cả', 
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.grey,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        Obx(() =>Checkbox(
                          checkColor: Colors.white,
                          activeColor: AppColors.green,
                          value: shuttleController.checkAll.value,
                          onChanged: (bool? value) {
                            shuttleController.checkAll.value = value!;
                            shuttleController.checkAllData(value);
                            shuttleController.listStudentWithClass.value = studentTemp;
                          },
                        ))
                      ],
                    )
                  )
                : const SizedBox(),
                shuttleController.listStudentWithClass.isNotEmpty ?
                  Expanded(
                    child: ListView.builder(
                    itemCount: shuttleController.listStudentWithClass.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.lightGrey
                            )
                          )
                        ),
                      child: 
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: '${(index + 1)}.${shuttleController.listStudentWithClass[index].student?.child_name}  ',
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                        color: AppColors.black,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w700,
                                        height: 1.5
                                      ),
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: shuttleController.listStudentWithClass[index].student?.birthday,
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                            color: AppColors.grey,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            height: 1.5
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if(shuttleController.listStudentWithClass[index].exist == null 
                                  || shuttleController.responseShuttle.value?.data?.pickup_class_id == shuttleController.listStudentWithClass[index].exist)
                                Obx(() => Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: AppColors.green,
                                  value: shuttleController.listStudentWithClass[index].check,
                                  onChanged: (bool? value) {
                                    shuttleController.listStudentWithClass[index].check = value!;
                                    for (var item in shuttleController.listStudentWithClass) {
                                      if (item.check  == false) {
                                        if(item.exist == null || shuttleController.responseShuttle.value?.data?.pickup_class_id == item.exist){
                                          shuttleController.checkAll.value = false;
                                          break;
                                        }
                                      }else{
                                        shuttleController.checkAll.value = true;
                                      }
                                    }  
                                    shuttleController.listStudentWithClass.value = studentTemp;
                                  }),
                                )
                              ],
                            ),
                            CupertinoTextField(
                              controller: shuttleController.listStudentWithClass[index].description,
                              padding: const EdgeInsets.symmetric(vertical: 9.0),
                              placeholder: "Ghi chú...",
                              placeholderStyle: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey
                                )
                              ),
                              style :GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black
                                )
                              ),
                              decoration: const BoxDecoration(),
                            )
                          ],
                        ));
                      }
                    )
                  )
                  : Expanded(
                      child: SizedBox(
                      width: widthScreen,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/no_assig.png'
                          ),
                          const SizedBox(height: 8.0),
                          Text('Không có học sinh', 
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: AppColors.grey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          )
                        ]
                      ),
                    ),
                  ),
                  shuttleController.listStudentWithClass.isNotEmpty ?
                  Container(
                    width: widthScreen,
                    padding: EdgeInsets.only(bottom: bottomPadding + 10.0),
                    child: CupertinoButton(
                      onPressed: () {
                        shuttleController.addchild();
                      },
                      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
                      color: AppColors.pink,
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      child: Text(
                        'Lưu',
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            height: 1.5
                          ),
                        ),
                      ),
                    )
                  )
                : const SizedBox()
                ]
              ),
            ), 
          )
        )
      );
    }
  );
}

void _showClass(BuildContext context) {
  double heightScreen = MediaQuery.of(context).size.height;
  final shuttleController = Get.find<ShuttleController>();
  final data = shuttleController.responseListClass.value?.data?.classes;

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
                  onTap: () async {
                    Navigator.pop(context);
                    shuttleController.nameClass.value = data?[shuttleController.nameClassIndex.value].group_title ?? '';
                    shuttleController.classId.value = data?[shuttleController.nameClassIndex.value].group_id ?? '';
                    await shuttleController.listchild();
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
                  initialItem: shuttleController.nameClassIndex.value,
                ),
                onSelectedItemChanged: (int selectedItem) {
                  shuttleController.nameClassIndex.value = selectedItem;
                },
                children: List<Widget>.generate(data?.length ?? 0, (int index) 
                  {
                  return Center(child: Text(data?[index].group_title ?? ""));
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
}