import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/extensions/color.dart';
import 'package:mobiedu_kids/domain/entities/responsive.dart';
import 'package:mobiedu_kids/presentation/controllers/news_feed/home_page_controller.dart';
import 'package:mobiedu_kids/presentation/pages/news_feed/widgets/page_tag_top.dart';
import 'package:mobiedu_kids/presentation/widgets/horizontal_divider_no_padding.dart';

class PersonAboutPage extends StatelessWidget {
  const PersonAboutPage({
    super.key,
    required this.personName,
  });

  final String personName;

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    final homePageController = Get.find<HomePageController>(tag: personName);

    return Scaffold(
      backgroundColor: HexColor('FFFFFF'),
      body: Container(
        padding: EdgeInsets.only(top: statusBarHeight + context.responsive(10.0)),
        child: Column(
          children: [
            const PageTagTop(tagName: 'Giới thiệu'),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const HorizontalDividerNoPadding(),
                    infoItem(
                      context,
                      'assets/images/customize.png', 
                      homePageController.profileData.value?.user_fullname,
                      'Họ tên'
                    ),
                    infoItem(
                      context,
                      'assets/images/birth.png', 
                      homePageController.profileData.value?.user_birthdate,
                      'Ngày sinh'
                    ),
                    infoItem(
                      context,
                      'assets/images/call.png', 
                      homePageController.profileData.value?.user_phone,
                      'Số điện thoại'
                    ),
                    infoItem(
                      context,
                      'assets/images/gender.png', 
                      homePageController.profileData.value?.user_gender == UserGender.male 
                        ? 'Nam'
                        : homePageController.profileData.value?.user_gender == UserGender.female
                          ? 'Nữ'
                          : null,
                      'Giới tính'
                    ),
                    infoItem(
                      context,
                      'assets/images/working.png', 
                      homePageController.profileData.value?.user_work_title,
                      'Công việc'
                    ),
                    infoItem(
                      context,
                      'assets/images/factory.png', 
                      homePageController.profileData.value?.user_work_place,
                      'Cơ quan'
                    ),
                    infoItem(
                      context,
                      'assets/images/resident.png', 
                      homePageController.profileData.value?.user_current_city,
                      'Địa chỉ'
                    ),
                    infoItem(
                      context,
                      'assets/images/hometown.png', 
                      homePageController.profileData.value?.user_hometown,
                      'Quê quán'
                    ),
                    infoItem(
                      context,
                      'assets/images/flag.png', 
                      homePageController.profileData.value?.user_edu_major,
                      'Ngành đào tạo'
                    ),
                    infoItem(
                      context,
                      'assets/images/school_icon.png', 
                      homePageController.profileData.value?.user_edu_school,
                      'Nhà trường'
                    ),
                    infoItem(
                      context,
                      'assets/images/class_icon.png', 
                      homePageController.profileData.value?.user_edu_class,
                      'Lớp'
                    ),
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  Widget infoItem(BuildContext context, String asset, String? text1, String text2) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: context.responsive(16.0), horizontal: context.responsive(28.0)),
      decoration: BoxDecoration(
        border: Border(
          // top: BorderSide(color: HexColor('D8D8D8')),
          bottom: BorderSide(color: HexColor('D8D8D8'))
        )
      ),
      child: Row(
        children: [
          Image.asset(
            asset,
            width: context.responsive(20.0),
            height: context.responsive(20.0),
            fit: BoxFit.contain,
          ),
          SizedBox(width: context.responsive(20.0)),
          Expanded(
            child: Text(
              text1 ?? text2,
              style: GoogleFonts.raleway(
                textStyle: TextStyle(fontSize: context.responsive(14.0), fontWeight: FontWeight.w700, color: HexColor((text1?.isNotEmpty ?? false) ? '464646' : 'D8D8D8'))
              ),
            )
          )
        ],
      ),
    );
  }
}