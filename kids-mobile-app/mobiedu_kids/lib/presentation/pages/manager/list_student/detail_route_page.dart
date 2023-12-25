import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/album/album_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/contact/contact_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/growth/growth_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/child_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/child_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/diary/diary_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/health/health_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/list_student/detail_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/list_student/widgets/student_info.dart';
import 'package:mobiedu_kids/presentation/pages/manager/pick_up/pickup_page.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
// import 'package:mobiedu_kids/presentation/pages/manager/menu/widget/student_in_menu.dart';

// ignore: must_be_immutable
class DetailRoutePage extends StatelessWidget {
  DetailRoutePage({
    super.key, 
    this.child_id,
    this.childName,
  });

  String? child_id;
  String? childName;

  final childController = Get.find<ChildController>();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    // double widthScreen = MediaQuery.of(context).size.width;
    // double bottomPadding = MediaQuery.of(context).padding.bottom;
    return GetX(
      init: childController,
      initState: (state) async {
        await childController.detail(store.getGroupname, child_id ?? '');
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
            middle: Text(
              // '${childController.child_info.value?.child_name}',
              childName ?? '',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(color: AppColors.primary, fontSize: 22.0, fontWeight: FontWeight.w700),
              ),
            ),
            backgroundColor: Colors.white,
            border: const Border(),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 22.0),
            child: childController.isdetailLoading.value
              ? const Center(
                child: CircularLoadingIndicator()
              )
              : Column(
                children: [
                  StudentInfo(),
                  const SizedBox(height: 64.0),
                  Expanded(
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Chi tiết học sinh",
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(fontSize: 16.0, color: AppColors.black, fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        detailItem('detail', 'Thông tin', 'assets/images/detail.png'),
                        const Divider(thickness: 1.0),
                        detailItem('pickup', 'Người đón học sinh', 'assets/images/pickup.png'),
                        const Divider(thickness: 1.0),
                        detailItem('health', 'Sức khỏe', 'assets/images/growth.png'),
                        const Divider(thickness: 1.0),
                        detailItem('diary', 'Nhật ký', 'assets/images/journal.png'),
                        const Divider(thickness: 1.0),
                      ]
                    )
                  ),
                ],
              )
          )
        )
      )
    );
  }

  Widget detailItem(String type, String text, String image) {
    return CupertinoButton(
      onPressed: () {
        handlePressItem(type);
      },
      child: Row(
        children: [
          SizedBox(
            child: Image(
              height: 24.0,
              width: 24.0,
              image: AssetImage(image),
              fit: BoxFit.cover
            ),
          ),
          const SizedBox(width: 16.0),
          Text(
            text,
            style: GoogleFonts.raleway(
              textStyle: TextStyle(fontSize: 14.0, color: AppColors.black, fontWeight: FontWeight.w700),
            ),
          ),
          const Expanded(child: SizedBox()),
          Icon(CupertinoIcons.chevron_right, size: 24.0, color: AppColors.grey2)
        ],
      )
    );
  }
  
  Future<void> handlePressItem(String type) async {
    switch (type) {
      case 'detail':
        await Get.delete<ChildController>();
        ChildBinding().dependencies();
        ContactBinding().dependencies();
        Get.to(() => DetailPage(
          child_id: child_id,
        ));
        break;
      case 'pickup':
        await Get.delete<ChildController>();
        ChildBinding().dependencies();
        Get.to(() => PickUpPage(
          child_id: child_id,
        ));
        break;
      case 'health':
        GrowthBinding().dependencies();
        Get.to(() => HealthPage(
          child_id: child_id,
        ));
        break;
      case 'diary':
        AlbumBinding().dependencies();
        Get.to(() => DiaryPage(
          child_id: child_id,
        ));
        break;
      default:
        break;
    }
  }
}
