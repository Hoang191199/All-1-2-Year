import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/child_controller.dart';

class CustomizeStudentPage extends StatelessWidget {
  CustomizeStudentPage({super.key, this.child_parent_id});
  
  final String? child_parent_id;
  final childController = Get.find<ChildController>();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return GetX(
      init: childController,
      initState: (state) async {},
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
                  Navigator.pop(context);
                },
                child: Icon(
                  CupertinoIcons.back,
                  color: AppColors.primary,
                ),
              ),
            ),
            middle: Text(
              'Thông tin',
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
            padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "Mã học sinh :",
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                        fontSize: 14.0,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                flex: 3,
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    '${childController.child_info_parent.value?.child_code}',
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                        fontSize: 14.0,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                        ],
                      ),
                      editInfoChild('Họ và tên đệm', childController.lastname, ''),
                      editInfoChild('Tên', childController.firstname, ''),
                      editInfoChild('Biệt danh', childController.nickname, ''),
                      GestureDetector(
                        onTap: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) =>ShowDateBirth()
                          );
                        },
                        child: editInfoChild('Ngày sinh', childController.birthday, 'birthday'),
                      ),
                      editInfoChild('Giới tính', childController.nickname, 'gender'),
                      editInfoChild('Nhóm máu', childController.blood_type, ''),
                      editInfoChild('Sở thích', childController.hobby, ''),
                      editInfoChild('Dị ứng', childController.allergy, ''),
                      editInfoChild('Mô tả', childController.description, 'description'),
                    ]
                  )
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10 + bottomPadding),
                  width: (widthScreen - 56),
                  child: CupertinoButton(
                    onPressed: () async {
                      if (childController.firstname.text != "" && childController.lastname.text != "") {
                        if (childController.parents_parent.isNotEmpty) {
                          final par = <String>[];
                          par.assignAll(childController.parents_parent.map((e) => e!.user_id!));
                          await childController.edit_parent(
                            child_parent_id ?? "",
                            childController.firstname.text,
                            childController.lastname.text,
                            childController.nickname.text,
                            childController.description.text,
                            childController.gender.isTrue ? "male" : "female",
                            childController.parent_phone.text,
                            childController.parent_name.text,
                            childController.parent_email.text,
                            childController.address.text,
                            childController.birthday.text,
                            childController.blood_type.text,
                            childController.hobby.text,
                            childController.allergy.text,
                            par,
                            par.length
                          );
                          Navigator.pop(context);
                          await childController.detail_parent(child_parent_id ?? "");
                        } else {
                          showAlertDialog(
                            context,
                            "Vui lòng chọn thêm cha mẹ",
                            "Trẻ không thể thiếu cha mẹ hoặc người giám hộ"
                          );
                        }
                      } else {
                        showAlertDialog(
                          context,
                          "Vui lòng nhập đủ trường",
                          "Các trường không thể trống"
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
                  ),
                )
              ]
            )
          )
        )
      )
    );
  }
  Widget editInfoChild(String content, TextEditingController info, String type){
    return Column(
      children: [
        type == 'description' ? const SizedBox(height: 12.0) : const SizedBox(),
        Row(
          crossAxisAlignment: type == 'description' ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "$content :",
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            if(type == '')
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: CupertinoTextField(
                  controller: info,
                  placeholder: "Chưa có mô tả",
                  placeholderStyle: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: AppColors.lightGrey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  decoration: const BoxDecoration(border: Border()),
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.black,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                )
              ),
            ),
            if(type == 'birthday')
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(childController.birthday.text == "" ? "Chưa có mô tả" : childController.birthday.text,
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        fontWeight: childController.birthday.text == "" ? FontWeight.w500 : FontWeight.w700 ,
                        fontSize: 14.0,
                        color: childController.birthday.text == "" ? AppColors.lightGrey : AppColors.black
                      ),
                    )
                  ),
                )
              ),
            ),
            if(type == 'gender')
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        childController.gender(true);
                      },
                      child: Row(
                        children: [
                          childController.gender.value == true ? 
                          imageCheck("assets/images/green_active.png") : 
                          imageCheck("assets/images/inactive.png"),
                          const SizedBox(width: 10),
                          Text(
                            "Nam",
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                fontSize: 14,
                                color: AppColors.black,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          )
                        ]
                      )
                    ),
                    const SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () {
                        childController.gender(false);
                      },
                      child: Row(
                        children: [
                          childController.gender.value == false ? 
                          imageCheck("assets/images/green_active.png") : 
                          imageCheck("assets/images/inactive.png"),
                          const SizedBox(width: 10),
                          Text(
                            "Nữ",
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                fontSize: 14,
                                color: AppColors.black,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          )
                        ]
                      )
                    ),
                  ],
                )
              ),
            ),
            if(type == 'description')
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: CupertinoTextField(
                  controller: info,
                  placeholder: "Chưa có mô tả",
                  placeholderStyle: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: AppColors.lightGrey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.black,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  minLines: 5,
                  maxLines: 10,
                )
              ),
            ),
          ],
        ),
        type == 'description' ? const SizedBox() : const Divider(),
      ],
    );
  }

  Widget imageCheck(String image){
    return ClipOval(
      child: Image(
        height: 20,
        width: 20,
        image: AssetImage(image),
        fit: BoxFit.cover
      ),
    );
  }
}

class ShowDateBirth extends StatelessWidget {
  ShowDateBirth({Key? key}) : super(key: key);
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
                  childController.birthday.text =  DateFormat('dd/MM/yyyy').format(newDateTime);
                },
                initialDateTime: DateFormat('dd/MM/yyyy').parse(childController.birthday.text),
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
