import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/child_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/list/add_parent.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/list/student_customize_page.dart';
import 'package:mobiedu_kids/presentation/widgets/avatar_error.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';


class DetailStudentPage extends StatelessWidget {
  DetailStudentPage({super.key, this.child_parent_id});

  final String? child_parent_id;

  final childController = Get.find<ChildController>();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {

    return GetX(
      init: childController,
      initState: (state) async {
        await childController.detail_parent(child_parent_id ?? "");
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
                  Navigator.pop(context);
                },
                child: Icon(
                  CupertinoIcons.back,
                  color: AppColors.primary,
                ),
              ),
            ),
            trailing: Container(
              margin: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => CustomizeStudentPage(child_parent_id: child_parent_id,));
                },
                child: Icon(
                  Icons.edit,
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
          child: childController.isdetailLoading.value ? 
          const Center(child: CircularLoadingIndicator()) : 
          Padding(
            padding: EdgeInsets.only( left: 28.0, right: 28.0, top: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      infoChild('Mã học sinh', childController.child_info_parent.value?.child_code ?? ''),
                      const SizedBox(height: 6.0),
                      infoChild('Họ và tên', childController.child_info_parent.value?.child_name ?? ''),
                      const SizedBox(height: 6.0),
                      infoChild(
                        'Biệt danh', 
                        childController.child_info_parent.value?.child_nickname == "null" 
                        || childController.child_info_parent.value?.child_nickname == null 
                        || childController.child_info_parent.value?.child_nickname == "" 
                        ? "Chưa cập nhật" 
                        : "${childController.child_info_parent.value?.child_nickname}",
                      ),
                      const SizedBox(height: 6.0),
                      infoChild('Ngày sinh', childController.child_info_parent.value?.birthday ?? ''),
                      const SizedBox(height: 6.0),
                      infoChild('Giới tính', childController.child_info_parent.value?.gender == 'male' ? 'Nam' : 'Nữ'),
                      const SizedBox(height: 6.0),
                      infoChild(
                        'Nhóm máu', 
                        childController.child_info_parent.value?.blood_type == "null" || 
                        childController.child_info_parent.value?.blood_type == null || 
                        childController.child_info_parent.value?.blood_type == "" ? 
                        "Chưa cập nhật" : 
                        "${childController.child_info_parent.value?.blood_type}"
                      ),
                      const SizedBox(height: 6.0),
                      infoChild(
                        'Sở thích', 
                        childController.child_info_parent.value?.hobby == "null" || 
                        childController.child_info_parent.value?.hobby == null || 
                        childController.child_info_parent.value?.hobby == "" ? 
                        "Chưa cập nhật" : 
                        "${childController.child_info_parent.value?.hobby}",
                      ),
                      const SizedBox(height: 6.0),
                      infoChild(
                        'Dị ứng', 
                        childController.child_info_parent.value?.allergy == "null" || 
                        childController.child_info_parent.value?.allergy == null || 
                        childController.child_info_parent.value?.allergy == "" ? 
                        "Chưa cập nhật" : 
                        "${childController.child_info_parent.value?.allergy}"
                      ),
                      const SizedBox(height: 6.0),
                      SizedBox(
                        height: 56.0 * childController.parents_parent.length,
                        child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 36.0,
                                      height: 36.0,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipOval(
                                        child: (childController.parents_parent[index]?.user_picture == '' || childController.parents_parent[index]?.user_picture == null) ? 
                                        Image.asset(
                                          'assets/images/avatar-mac-dinh.png',
                                          fit: BoxFit.contain
                                        ) : 
                                        CachedNetworkImage(
                                          imageUrl: childController.parents_parent[index]?.user_picture ?? '',
                                          progressIndicatorBuilder: (context,url, downloadProgress) =>Container(),
                                          errorWidget:(context, url, error) =>const AvatarError(),
                                          fit: BoxFit.cover
                                        )
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    (childController.parents_parent[index]?.user_phone != "" && childController.parents_parent[index]?.user_phone != null) ? 
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${childController.parents_parent[index]?.user_fullname}",
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${childController.parents_parent[index]?.user_phone}",
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                      ],
                                    ) : 
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${childController.parents_parent[index]?.user_fullname}",
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Chưa cập nhật",
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    childController.parents_parent.removeAt(index);
                                    final par = <String>[];
                                    par.assignAll(childController.parents_parent.map((e) => e!.user_id!));
                                    await childController.edit_parent(
                                      store.getChild?.child_parent_id ?? "",
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
                                    await childController.detail_parent(store.getChild?.child_parent_id ?? "");
                                  },
                                  child: Container(
                                    width: 30.0,
                                    height: 30.0,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: const ClipOval(
                                      child: Image(
                                        image: AssetImage('assets/images/delete.png',),
                                        fit: BoxFit.cover
                                      ),
                                    ),
                                  )
                                ),
                              ],
                            )
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                        itemCount: childController.parents_parent.length
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 6.0),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  "Phụ huynh :",
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
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => SearchUserParentPage());
                                },
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 30.0,
                                        height: 30.0,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: const ClipRRect(
                                          child: Image(
                                            image: AssetImage('assets/images/add_parent.png'),
                                            fit: BoxFit.cover
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 6.0),
                                      Text(
                                        'Thêm phụ huynh',
                                        style: GoogleFonts.raleway(
                                          textStyle: TextStyle(
                                            fontSize: 14.0,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w700
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    infoChild(
                      'Mô tả', 
                      childController.child_info_parent.value?.description == "null" || 
                        childController.child_info_parent.value?.description == null || 
                        childController.child_info_parent.value?.description == "" ? 
                        "Chưa cập nhật" : 
                        "${childController.child_info_parent.value?.description}",
                    ),
                    const SizedBox(height: 10.0),
                  ]
                )
              ),
            ]
          )
        )
      )
    ));
  }

  Widget infoChild(String content, String info){
    return Column(
      children: [
        Row(
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
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  info,
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
    );
  }
}
