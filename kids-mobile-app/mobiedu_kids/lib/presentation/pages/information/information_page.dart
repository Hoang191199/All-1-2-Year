import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/infomation/infomation_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/manager/manager_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/prescription/prescription_child_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_controller.dart';
import 'package:mobiedu_kids/presentation/pages/information/widget/menu_info.dart';
import 'package:mobiedu_kids/presentation/pages/information/widget/note_widget.dart';
import 'package:mobiedu_kids/presentation/pages/information/widget/prescription_info.dart';
import 'package:mobiedu_kids/presentation/pages/information/widget/social_info.dart';
import 'package:mobiedu_kids/presentation/pages/information/widget/working_info.dart';
import 'package:mobiedu_kids/presentation/widgets/avatar_error.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class InformationPage extends StatelessWidget {
  InformationPage({super.key});

  final infoUser = Get.find<SplashScreenController>();
  final informationController = Get.find<InformationController>();
  final prescriptionChildController = Get.find<PrescriptionChildController>();
  final store = Get.find<LocalStorageService>();
  final splashController = Get.find<SplashScreenController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    // PrescriptionChildBinding().dependencies();
    Get.put(ManagerController());
    return GetX(
      init: informationController,
      initState: (state) {
        informationController.fetchData();
        prescriptionChildController.fetchData();
      },
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            }, 
            child: Container(
              height: double.infinity,
              margin: const EdgeInsets.only(top: 12.0),
              child: CupertinoPageScaffold(
                resizeToAvoidBottomInset: false,
                navigationBar: CupertinoNavigationBar(
                  padding:  const EdgeInsetsDirectional.symmetric(horizontal: 28.0),
                  leading: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: 'Bé \n', style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        TextSpan(text: infoUser.responseManagerData.value?.data?.children?[informationController.indexChild.value].child_name, 
                        style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      ]
                    )
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: (){
                          showListChild(context,widthScreen);
                        },
                        child: Container(
                          width: 46.0,
                          height: 46.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: infoUser.responseManagerData.value?.data?.children?[informationController.indexChild.value].child_picture == '' || infoUser.responseManagerData.value?.data?.children?[informationController.indexChild.value].child_picture == null  ?
                            Image.asset('assets/images/avatar-mac-dinh.png',
                              fit: BoxFit.cover
                              )
                          : CachedNetworkImage(
                              imageUrl:'${infoUser.responseManagerData.value?.data?.children?[informationController.indexChild.value].child_picture}' ,
                              progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
                              errorWidget: (context, url, error) => const AvatarError(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  backgroundColor: Colors.white,
                  border: const Border(),
                ), 
                child: informationController.isLoading.value
                ? const Center(
                  child: CircularLoadingIndicator(),
                )
                :
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 16.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 28.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  DatePicker(
                                    informationController.startOfWeek,
                                    initialSelectedDate: informationController.dateNow,
                                    selectionColor: AppColors.lightPink2,
                                    selectedTextColor:  AppColors.pink,
                                    deactivatedColor: AppColors.grey,
                                    monthTextStyle: GoogleFonts.raleway(
                                      textStyle: const TextStyle(
                                        color: Color(0xFFB4B4B4),
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    dayTextStyle : GoogleFonts.raleway(
                                      textStyle: const TextStyle(
                                        color: Color(0xFFb4b4b4),
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    dateTextStyle : GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    daysCount: 7,
                                    onDateChange: (date) {
                                      informationController.dateNow = date;
                                      informationController.fetchData();
                                    },
                                    locale: 'vi_VN'
                                  ),
                                  // DateTimeLine()
                                ],
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            Column(
                              children: 
                              getDataInfo(widthScreen)
                            ),
                            const SizedBox(height: 12.0),
                          ]
                        ),
                      ),
                      if(informationController.responseNewPost.value?.data?.posts?.isNotEmpty ?? false)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: titleInfo('assets/images/album-info.png', 'Album ${store.getGrouptitle}')
                      ),
                      const SizedBox(height: 16.0),
                      if(informationController.responseNewPost.value?.data?.posts != null && (informationController.responseNewPost.value?.data?.posts?.isNotEmpty ?? false))
                      SocialInfo(),
                      if(informationController.responseInfomation.value?.data?.attendances_back?.isNotEmpty ?? false)
                      Container(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        padding: const EdgeInsets.only(top: 12, bottom:16, left:30, right:30),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 10,
                              offset: Offset(0, 6),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/diem-danh-ph.png',
                                  width: 24.0,
                                  height: 24.0,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 8.0),
                                Text('Điểm danh buổi chiều',
                                  style: GoogleFonts.raleway(
                                    textStyle: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                )
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              width: 328.0,
                              height: 256.0,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/bg-diem-danh.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    right: (328.0 / 2) - 75,
                                    child: 
                                    informationController.responseInfomation.value?.data?.attendances_back?[0].source_file == '' ? 
                                    Image.asset(
                                      'assets/images/avatar-mac-dinh.png',
                                      width: 164.0,
                                      height: 218,
                                      fit: BoxFit.fitHeight,
                                    )
                                    : Image.network(
                                      urlImageNewPost(informationController.responseInfomation.value?.data?.attendances_back?[0].source_file ?? ''),
                                      width: 164.0,
                                      height: 218,
                                      fit: BoxFit.fitHeight,
                                    )
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 26.0),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'Bé ${infoUser.responseManagerData.value?.data?.children?[informationController.indexChild.value].child_name} đã về nhà lúc ${informationController.responseInfomation.value?.data?.attendances_back?[0].came_back_time ?? ''}!',
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    height: 1.5
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              )
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ),
              )
            ),
          )
        );
      }
    );
  }

  List<Widget> getDataInfo(double widthScreen){
    List<Widget> dataArr = [];
    final informationController = Get.find<InformationController>();
    String beginTime = '11:30';
    String endTime = '14:00';
    String jsonString = '{"begin":"11:30","end":"14:00"}';
    if(informationController.typeSleep.value?.metadata != ""){
      Map<String, dynamic> jsonMap = json.decode(informationController.typeSleep.value?.metadata == "" ? jsonString : informationController.typeSleep.value?.metadata ?? jsonString);
      beginTime = jsonMap['begin']; 
      endTime = jsonMap['end']; 
    }
    if((informationController.responseInfomation.value?.data?.infoAttendance?.isNotEmpty ?? false)){
      if(informationController.responseInfomation.value?.data?.infoAttendance?[0].source_file != null){  
        dataArr.add(
          Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            padding: const EdgeInsets.only(top: 12, bottom:16, left:30, right:30),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 10,
                  offset: Offset(0, 6),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/diem-danh-ph.png',
                      width: 24.0,
                      height: 24.0,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 8.0),
                    Text('Điểm danh buổi sáng',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                Container(
                  width: 328.0,
                  height: 256.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/bg-diem-danh.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        right: (328.0 / 2) - 75,
                        child: 
                        informationController.responseInfomation.value?.data?.infoAttendance?[0].source_file == '' ? 
                        Image.asset(
                          'assets/images/avatar-mac-dinh.png',
                          width: 164.0,
                          height: 218,
                          fit: BoxFit.cover,
                        )
                        : Image.network(
                          urlImageNewPost(informationController.responseInfomation.value?.data?.infoAttendance?[0].source_file ?? ''),
                          width: 164.0,
                          height: 218,
                          fit: BoxFit.cover,
                        )
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 26.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Chào mừng bé ${infoUser.responseManagerData.value?.data?.children?[informationController.indexChild.value].child_name} đã đến lớp lúc ${convertStringDateToStringTime(informationController.responseInfomation.value?.data?.infoAttendance?[0].updated_at ?? '')}!',
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: AppColors.grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        height: 1.5
                      ),
                    ),
                    textAlign: TextAlign.center,
                  )
                ),
              ],
            ),
          )
        );

      }
    }

    if(informationController.responseSchedule.value?.data?.schedule_child != null){
      dataArr.add(
        Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          padding: const EdgeInsets.only(top: 12, bottom:16, left:30, right:30),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 10,
                offset: Offset(0, 6),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              titleInfo('assets/images/hoat-dong-info.png', 'Hoạt động học của bé'),
              WorkingInfo(),
            ],
          ),
        ),
      );
    }

    if(informationController.responseMenu.value?.data?.menu_child != null){
      dataArr.add(
        Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          padding: const EdgeInsets.only(top: 12, bottom:16, left:30, right:30),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 10,
                offset: Offset(0, 6),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              titleInfo('assets/images/thuc-don-info.png', 'Thực đơn hôm nay của bé'),
              MenuInfo(),
            ],
          ),
        ),
      );
    }
    if(informationController.responseInfomation.value?.data?.medicines?.isNotEmpty ?? false){
    dataArr.add(
      Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.only(top: 12, bottom:16, left:30, right:30),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 10,
              offset: Offset(0, 6),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          children: [
            titleInfo('assets/images/thuoc-info.png', 'Đơn thuốc con uống'),
            PrescriptionInfo(),
          ],
        ),
      ),
    );
    }
    if(informationController.typeHygiene.value?.metadata != null){
      dataArr.add(
        Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          padding: const EdgeInsets.only(top: 12, bottom:16, left:30, right:30),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 10,
                offset: Offset(0, 6),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              titleInfo('assets/images/ve-sinh-info.png', 'Hoạt động vệ sinh'),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Image.asset(
                    'assets/images/icon-ve-sinh.png',
                    width: 48.0,
                    height: 80.0,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8.0),
                  Text('Số lần poo: ${informationController.typeHygiene.value?.metadata} lần',
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              informationController.typeHygiene.value?.note == '' ? const SizedBox() :
              NoteWidget(note: '${informationController.typeHygiene.value?.note}'),
            ],
          ),
        ),
      );
    }

    if(informationController.typeSleep.value?.metadata != null){
      dataArr.add(
        Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          padding: const EdgeInsets.only(top: 12, bottom:16, left:30, right:30),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 10,
                offset: Offset(0, 6),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/ngu-info.png',
                    width: 24.0,
                    height: 24.0,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 8.0),
                  Text('Hoạt động ngủ',
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Image.asset(
                    'assets/images/icon-ngu.png',
                    width: 70.0,
                    height: 56.0,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 14.0),
                  Text('Con ngủ từ',
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ),
                  const SizedBox(width: 4.0),
                  Container(
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 2.0,horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.lightGrey,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(2))
                    ),
                    child: Text(beginTime,
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.grey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  Text('đến',
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ),
                  const SizedBox(width: 4.0),
                  Container(
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 2.0,horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.lightGrey,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(2))
                    ),
                    child: Text(endTime,
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.grey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              informationController.typeSleep.value?.note == "" ? const SizedBox():
              NoteWidget(note: informationController.typeSleep.value?.note ?? ''),
              const SizedBox(height: 32.0),
            ]
          ),
        )
      );
    }

    if(informationController.responseInfomation.value?.data?.infoChildReviewDay?.isNotEmpty ?? false) {
      dataArr.add(
        Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          padding: const EdgeInsets.only(top: 12, bottom:16, left:30, right:30),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 10,
                offset: Offset(0, 6),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              titleInfo('assets/images/nhan-xet-hang-ngay-info.png', 'Nhận xét hàng ngày'),
              const SizedBox(height: 16.0),
              NoteWidget(note: informationController.responseInfomation.value?.data?.infoChildReviewDay?[0].content ?? ''),
            ]
          ),
        )
      );
    }

    if((informationController.responseInfomation.value?.data?.infoChildReviewWeek?.isNotEmpty ?? false)
      && (informationController.responseInfomation.value?.data?.infoChildReviewWeek?[0].title?.isNotEmpty ?? false)
      && (informationController.responseInfomation.value?.data?.infoChildReviewWeek?[0].content?.isNotEmpty ?? false)) {
      dataArr.add(
        Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          padding: const EdgeInsets.only(top: 12, bottom:16, left:30, right:30),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 10,
                offset: Offset(0, 6),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              titleInfo('assets/images/nhan-xet-hang-tuan-info.png', 'Nhận xét cuối tuần'),
              const SizedBox(height: 16.0),
              if (informationController.responseInfomation.value?.data?.infoChildReviewWeek?[0].title?.isNotEmpty ?? false)
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: AppColors.primary,
                      size: 4.0,
                    ),
                    const SizedBox(width: 6.0),
                    Text(informationController.responseInfomation.value?.data?.infoChildReviewWeek?[0].title ?? 'Nội dung nhận xét',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    )
                  ],
                ),
              const SizedBox(height: 16.0),
              if (informationController.responseInfomation.value?.data?.infoChildReviewWeek?[0].content?.isNotEmpty ?? false) 
                NoteWidget(note: informationController.responseInfomation.value?.data?.infoChildReviewWeek?[0].content ?? ''),
            ]
          ),
        )
      );
    }

    return dataArr;
  }

  Widget titleInfo(String icon, String title) {
    return Row(
      children: [
        Image.asset(
          icon,
          width: 24.0,
          height: 24.0,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 8.0),
        Text(title,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              color: AppColors.primary,
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          )
        )
      ],
    );
  }

  showListChild(context, double widthScreen){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(20.0)
          ),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 200),
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Center(
                  child: Text('Chọn bé',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        height: 1.5
                      ),
                    ),
                  )
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: infoUser.responseManagerData.value?.data?.children?.length,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: () async {
                          splashController.childId.value = infoUser.responseManagerData.value?.data?.children?[index].child_id ?? '';
                          splashController.groupName.value = infoUser.responseManagerData.value?.data?.children?[index].group_name ?? '';
                          store.setSchoolname = infoUser.responseManagerData.value?.data?.children?[index].page_title ??"";
                          store.setPagename = infoUser.responseManagerData.value?.data?.children?[index].page_name ?? "";
                          store.setGroupname = infoUser.responseManagerData.value?.data?.children?[index].group_name ?? "";
                          store.setGrouptitle = infoUser.responseManagerData.value?.data?.children?[index].group_title ?? "";
                          store.setGroupId = infoUser.responseManagerData.value?.data?.children?[index].group_id ?? "";
                          store.setChild = infoUser.responseManagerData.value?.data?.children?[index];
                          informationController.indexChild.value = index;
                          Navigator.pop(context);
                          await informationController.fetchData();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 46.0,
                                height: 46.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: infoUser.responseManagerData.value?.data?.children?[index].child_picture == '' || infoUser.responseManagerData.value?.data?.children?[index].child_picture == null  ?
                                  Image.asset('assets/images/avatar-mac-dinh.png',
                                    fit: BoxFit.cover
                                    )
                                : CachedNetworkImage(
                                    imageUrl:'${infoUser.responseManagerData.value?.data?.children?[index].child_picture}' ,
                                    progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
                                    errorWidget: (context, url, error) => const AvatarError(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Text('Bé ${infoUser.responseManagerData.value?.data?.children?[index].child_name}',
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ]
                          ),
                        ),
                      );
                    }
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}

