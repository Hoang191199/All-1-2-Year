import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/presentation/pages/manager/list_student/search_user_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/list_student/student_code_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/child_controller.dart';

class AddDetailPage extends StatelessWidget {
  AddDetailPage({super.key, this.child_id});

  final String? child_id;

  final childController = Get.find<ChildController>();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return GetX(
      init: childController,
      initState: (state) async {
        childController.firstname.text = "";
        childController.lastname.text = "";
        childController.birthday.text = "Ngày sinh";
        childController.description.text = "";
        childController.begin_at.text = "Ngày nhập học";
        childController.parent_email.text = "";
        childController.parent_phone.text = "";
        childController.parent_name.text = "";
        childController.address.text = "";
        childController.password.text = "";
        childController.parents.value = [];
        childController.action.value = false;
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
                  ChildController.to.validateName.value = false;
                  ChildController.to.validatePassWord.value = false;
                  Navigator.pop(context);
                },
                child: Icon(
                  CupertinoIcons.back,
                  color: AppColors.primary,
                ),
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
          child: Padding(
            padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => StudentCodePage());
                        },
                        child: Row(
                          children: [
                            const ClipRRect(
                              child: Image(
                                height: 24.0,
                                width: 24.0,
                                image: AssetImage("assets/images/register.png"),
                                fit: BoxFit.cover
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Text(
                                "Thêm học sinh đã tồn tại trên hệ thống",
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.0
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: CupertinoTextField(
                              controller: childController.lastname,
                              onEditingComplete: () {
                                childController.update();
                              },
                              onChanged: (value) {
                                childController.update();
                              },
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              placeholder: "Họ và tên đệm",
                              placeholderStyle: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: AppColors.lightGrey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            flex: 1,
                            child: CupertinoTextField(
                              controller: childController.firstname,
                              onEditingComplete: () {
                                childController.update();
                              },
                              onChanged: (value) {
                                childController.update();
                              },
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              placeholder: "Tên",
                              placeholderStyle: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: AppColors.lightGrey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          )
                        ]
                      ),
                      const SizedBox(height: 10),
                      GetBuilder<ChildController>(
                        builder: (cxt) {
                          return ChildController.to.validateName.value ?
                          ChildController.to.firstname.text == "" || ChildController.to.lastname.text == "" ? 
                          Row(
                            children: [
                              SizedBox(
                                width: widthScreen - 56,
                                child: Row(
                                  children: [
                                    Text(
                                      "Trường họ tên không được để trống",
                                      style: GoogleFonts.raleway(
                                        fontSize: 12,
                                        color: AppColors.red
                                      ),
                                    ),
                                  ]
                                )
                              ),
                            ],
                          )
                          : const SizedBox()
                          : const SizedBox();
                        } 
                      ),
                      const SizedBox( height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              childController.gender(true);
                            },
                            child: Row(
                              children: [
                                childController.gender.value == true ? 
                                const ClipOval(
                                  child: Image(
                                    height: 20,
                                    width: 20,
                                    image: AssetImage("assets/images/active.png"),
                                    fit: BoxFit.cover
                                  ),
                                ) : 
                                const ClipOval(
                                  child: Image(
                                    height: 20,
                                    width: 20,
                                    image: AssetImage("assets/images/inactive.png"),
                                    fit: BoxFit.cover
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Nam",
                                  style: GoogleFonts.raleway(
                                    textStyle: TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                )
                              ]
                            )
                          ),
                          const SizedBox(width: 20.0),
                          GestureDetector(
                            onTap: () {
                              childController.gender(false);
                            },
                            child: Row(
                              children: [
                                childController.gender.value == true ? 
                                const ClipOval(
                                  child: Image(
                                    height: 20,
                                    width: 20,
                                    image: AssetImage("assets/images/inactive.png"),
                                    fit: BoxFit.cover
                                  ),
                                ): 
                                const ClipOval(
                                  child: Image(
                                    height: 20,
                                    width: 20,
                                    image: AssetImage("assets/images/active.png"),
                                    fit: BoxFit.cover
                                  ),
                                ),
                                const SizedBox(width: 10 ),
                                Text("Nữ",
                                  style: GoogleFonts.raleway(
                                    textStyle: TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                )
                              ]
                            )
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) =>
                            ShowDateBirthAdd()
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                          decoration: BoxDecoration(
                          border:Border.all(color: AppColors.lightGrey),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(5.0)
                            )
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                                  child: EditableText(
                                    style: childController.birthday.text == "Ngày sinh" ? 
                                      GoogleFonts.raleway(
                                        textStyle: TextStyle(
                                          color: AppColors.lightGrey,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ) : 
                                      GoogleFonts.raleway(
                                        textStyle: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    controller: childController.birthday,
                                    cursorColor: AppColors.black,
                                    backgroundCursorColor: AppColors.black,
                                    focusNode: FocusNode(),
                                    readOnly: true,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 14.0,
                                color: AppColors.lightGrey,
                              )
                            ],
                          )
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      SizedBox(
                        height: 56.0 * childController.parents.length,
                        child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 36.0,
                                  height: 36.0,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipOval(
                                    child: (childController.parents[index]?.user_picture == '' || childController.parents[index]?.user_picture == null) ? 
                                    Image.asset('assets/images/avatar-mac-dinh.png',
                                      fit: BoxFit.contain
                                    ): 
                                    CachedNetworkImage(
                                      imageUrl: childController.parents[index]?.user_picture ?? '',
                                      fit: BoxFit.cover
                                    )
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${childController.parents[index]?.user_fullname}",
                                      style: GoogleFonts.raleway(
                                        textStyle:TextStyle(
                                          color: AppColors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                    (childController.parents[index]?.user_phone != "" && childController.parents[index]?.user_phone != null) ? 
                                    Text( "${childController.parents[index]?.user_phone}",
                                      style: GoogleFonts.raleway(
                                        textStyle: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ) :
                                    Text(
                                      "Chưa cập nhật",
                                      style: GoogleFonts.raleway(
                                        textStyle: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Expanded(
                                  child: SizedBox()
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    childController.parents.removeAt(index);
                                  },
                                  child: Container(
                                    width: 30.0,
                                    height: 30.0,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: const ClipOval(
                                      child: Image(
                                        image: AssetImage(
                                          'assets/images/delete.png',
                                        ),
                                        fit: BoxFit.cover
                                      ),
                                    ),
                                  )
                                )
                              ],
                            )
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                        itemCount: childController.parents.length
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SearchUserPage());
                      },
                      child: Row(
                        children: [
                          const ClipRRect(
                            child: Image(
                              height: 24.0,
                              width: 24.0,
                              image: AssetImage("assets/images/register.png"),
                              fit: BoxFit.cover
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Thêm phụ huynh đã có tài khoản",
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.0
                              ),
                            ),
                          )
                        ],
                      )
                    ),
                    const SizedBox(height: 10.0),
                    formParent(childController.parent_name, 'Họ và tên phụ huynh', false, false),
                    const SizedBox(height: 10.0),
                    formParent(childController.parent_phone, 'Số điện thoại', true, false),
                    const SizedBox(height: 10.0),
                    formParent(childController.parent_email, 'Email', false, false),
                    const SizedBox(height: 10.0),
                    formParent(childController.address, 'Địa chỉ', false, false),
                    const SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) => ShowDateBeginAdd()
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.lightGrey),
                          borderRadius: const BorderRadius.all(Radius.circular(5.0))
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 3.0),
                                child: EditableText(
                                  style: childController.begin_at.text == "Ngày nhập học" ? 
                                  GoogleFonts.raleway(
                                    textStyle: TextStyle(
                                      color: AppColors.lightGrey,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ) : 
                                  GoogleFonts.raleway(
                                    textStyle: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  controller: childController.begin_at,
                                  cursorColor: AppColors.black,
                                  backgroundCursorColor: AppColors.black,
                                  focusNode: FocusNode(),
                                  readOnly: true,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 14.0,
                              color: AppColors.lightGrey,
                            )
                          ],
                        )
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    CupertinoTextField(
                      controller: childController.description,
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      placeholder: "Mô tả",
                      placeholderStyle: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.lightGrey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      minLines: 3,
                      maxLines: 10,
                    ),
                    const SizedBox(height: 10.0),
                    formParent(childController.password, 'Mật khẩu', false, true),
                    const SizedBox(height: 10.0),
                    GetBuilder<ChildController>(
                      builder: (cxt) => ChildController.to.validatePassWord.value ? 
                      ChildController.to.password.text == "" ? 
                        Row(
                          children: [
                            SizedBox(
                                width: widthScreen - 56,
                                child: Row(
                                  children: [
                                  Text(
                                    "Trường mật khẩu không được để trống",
                                    style: GoogleFonts.raleway(
                                      fontSize: 12,
                                      color: AppColors.red
                                    ),
                                  ),
                                ]
                              )
                            ),
                          ],
                        )
                      : const SizedBox()
                      : const SizedBox()
                    ),
                  ]
                )
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10 + bottomPadding),
                width: (widthScreen - 56),
                child: CupertinoButton(
                  onPressed: () async {
                    ChildController.to.action.value = false;
                    childController.update();
                    if(childController.firstname.text == "" || childController.lastname.text == "" || childController.password.text == ""){
                      if(childController.firstname.text == "" || childController.lastname.text == ""){
                        ChildController.to.validateName.value = true;
                      }
                      if(childController.password.text == ""){
                        ChildController.to.validatePassWord.value = true;
                      }
                    }else{
                      final par = <String>[];
                        par.assignAll(childController.parents.map((e) => e!.user_id!));
                        await childController.add(
                          store.getGroupname,
                          "1",
                          childController.firstname.text,
                          childController.lastname.text,
                          childController.description.text,
                          childController.gender.isTrue ? "male" : "female",
                          childController.parent_phone.text,
                          childController.parent_name.text,
                          childController.parent_email.text,
                          (childController.parent_phone.text == "" && childController.parent_name.text == "" && childController.parent_email.text == "") ? "0" : "1",
                          childController.address.text,
                          childController.birthday.text,
                          childController.begin_at.text,
                          "0",
                          childController.password.text,
                          par,
                          par.length
                        );
                        await childController.fetch(store.getGroupname);
                        childController.gender.value = true;
                        childController.firstname.text = "";
                        childController.lastname.text = "";
                        childController.description.text = "";
                        childController.parent_phone.text = "";
                        childController.parent_name.text = "";
                        childController.parent_email.text = "";
                        childController.address.text = "";
                        childController.birthday.text = "Ngày sinh";
                        childController.begin_at.text = "Ngày nhập học";
                        childController.password.text = "";
                        childController.parents.value = [];
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

  Widget formParent(TextEditingController textController, String? placeholder, bool? type, bool? checkPass){
    return CupertinoTextField(
      controller: textController,
      keyboardType: type == false ? TextInputType.text : TextInputType.number,
      obscureText: checkPass == true ? true : false,
      style: GoogleFonts.raleway(
        textStyle: TextStyle(
          color: AppColors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.w500
        ),
      ),
      placeholder: "$placeholder",
      placeholderStyle: GoogleFonts.raleway(
        textStyle: TextStyle(
          color: AppColors.lightGrey,
          fontSize: 14.0,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}

class ShowDateBirthAdd extends StatelessWidget {
  ShowDateBirthAdd({Key? key}) : super(key: key);
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
                    childController.birthday.text = DateFormat('dd/MM/yyyy').format(DateFormat('dd/MM/yyyy').parse(
                    childController.birthday.text == "" || childController.birthday.text == "Ngày sinh" 
                      ? DateFormat("dd/MM/yyyy").format(childController.dateNow.value) 
                      : childController.birthday.text)
                    );
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
                  childController.birthday.text = DateFormat('dd/MM/yyyy').format(newDateTime);
                },
                initialDateTime: DateFormat('dd/MM/yyyy').parse(childController.birthday.text == "" || childController.birthday.text == "Ngày sinh" 
                  ? DateFormat("dd/MM/yyyy").format(childController.dateNow.value) 
                  : childController.birthday.text
                ),
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

class ShowDateBeginAdd extends StatelessWidget {
  ShowDateBeginAdd({Key? key}) : super(key: key);
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
                    childController.begin_at.text = DateFormat('dd/MM/yyyy').format(DateFormat('dd/MM/yyyy').parse(
                    childController.begin_at.text == "" || childController.begin_at.text == "Ngày nhập học"
                        ? DateFormat("dd/MM/yyyy").format(childController.dateNow.value)
                        : childController.begin_at.text)
                    );
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
                  childController.begin_at.text = DateFormat('dd/MM/yyyy').format(newDateTime);
                },
                initialDateTime: DateFormat('dd/MM/yyyy').parse(
                  childController.begin_at.text == "" || childController.begin_at.text == "Ngày nhập học"
                  ? DateFormat("dd/MM/yyyy").format(childController.dateNow.value)
                  : childController.begin_at.text
                ),
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
