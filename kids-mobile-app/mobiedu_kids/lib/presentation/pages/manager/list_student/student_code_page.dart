import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/child_controller.dart';

class StudentCodePage extends StatelessWidget {
  StudentCodePage({super.key});

  final childController = Get.find<ChildController>();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return WillPopScope(
      onWillPop: () async{
        childController.code.text = "";
        Navigator.pop(context);
        return false;
      },
      child: GestureDetector(
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
                  childController.code.text = "";
                  Navigator.pop(context);
                },
                child: Icon(
                  CupertinoIcons.back,
                  color: AppColors.primary,
                ),
              ),
            ),
            middle: Text(
              'Thêm tài khoản đã tồn tại',
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
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              children: [
                SizedBox(
                  width: widthScreen - 56,
                  child: Row(
                    children: [
                      SizedBox(
                        width: (widthScreen - 56) / 12,
                      ),
                      Text(
                        "Mã học sinh :",
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      )
                    ]
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: widthScreen - 56,
                  child: CupertinoTextField(
                    controller: childController.code,
                    placeholder: "Mã học sinh",
                  ),
                ),
                const Expanded(
                  child: SizedBox()
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10 + bottomPadding),
                  width: widthScreen - 56,
                  child: CupertinoButton(
                    onPressed: () async {
                      await childController.searchCode(store.getGroupname, childController.code.text); 
                      if(childController.resp.value?.code == 200){
                        childController.parents.assignAll(childController.resp.value?.data?.child?.parent ?? []);
                        childController.firstname.text = childController.resp.value?.data?.child?.first_name ?? "";
                        childController.lastname.text = childController.resp.value?.data?.child?.last_name ?? "";
                        childController.birthday.text = childController.resp.value?.data?.child?.birthday ?? "";
                        childController.description.text = childController.resp.value?.data?.child?.description ?? "";
                        childController.parent_email.text = childController.resp.value?.data?.child?.parent_email ?? "";
                        childController.parent_phone.text = childController.resp.value?.data?.child?.parent_phone ?? "";
                        childController.parent_name.text = childController.resp.value?.data?.child?.parent_name ?? "";
                        childController.address.text = childController.resp.value?.data?.child?.address ?? "";
                        childController.nickname.text = childController.resp.value?.data?.child?.child_nickname ?? "";
                        childController.gender.value = childController.resp.value?.data?.child?.gender == "male" ? true : false;
                        childController.begin_at.text = (childController.resp.value?.data?.child?.begin_at == "" || childController.resp.value?.data?.child?.begin_at == null) ? "Ngày nhập học" : childController.resp.value?.data?.child?.begin_at ?? "Ngày nhập học";
                        childController.code.text = "";
                        Navigator.pop(context);
                      }       
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.pink,
                    child: Text(
                      'Tìm kiếm',
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
              ],
            )
          )
        )
      )
    );
  }
}
