import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/attendance/attendanceController.dart';
import 'package:mobiedu_kids/presentation/controllers/notification/notification_controller.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class AppRoveRest extends StatelessWidget {
  AppRoveRest({
    super.key,     
    required this.action,
    required this.nodeUrl,
    required this.nodeType,
    required this.extra1,
    required this.extra2,
    required this.extra3,
  });

  final String action; 
  final String nodeUrl; 
  final String nodeType;
  final String extra1;
  final String extra2;
  final String extra3;

  final attendanceController = Get.find<AttendanceController>();
  final notificationController = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    return GetX(
      init: notificationController,
      initState: (state) {
        notificationController.detail(action, nodeUrl, nodeType, extra1, extra2, extra3);
      },
      builder: (_) {
        return Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: CupertinoPageScaffold(
              resizeToAvoidBottomInset: false,
              navigationBar: CupertinoNavigationBar(
                padding: const EdgeInsetsDirectional.only(top: 18.0),
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 70.0,
                    color: Colors.transparent,
                    child: Icon(
                      CupertinoIcons.back,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                middle: Text(
                  'Xin nghỉ',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: AppColors.primary,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                backgroundColor: Colors.white,
                border: const Border(),
              ), 
              child: notificationController.isLoadingDetail.value
              ? SizedBox(
                width: widthScreen,
                child: const Center(
                  child: CircularLoadingIndicator(),
                ),
              )
              : Container(
                margin: const EdgeInsets.only(top: 20.0),
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/background-rest.png', 
                      width: widthScreen,
                      height: 124.0,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16.0),
                    Text('Tôi là phụ huynh của cháu ${notificationController.responseDetail.value?.data?.attendance_class?.detail?[0].child_name}.',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text('Xin nghỉ phép cho cháu từ ngày ${notificationController.responseDetail.value?.data?.attendance_class?.detail?[0].start_date} đến ngày ${notificationController.responseDetail.value?.data?.attendance_class?.detail?[0].end_date}.',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text('Với lý do: ${notificationController.responseDetail.value?.data?.attendance_class?.detail?[0].reason}',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text('Cảm ơn!',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if(notificationController.responseDetail.value?.data?.attendance_class?.detail?[0].feedback == '0')
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.only(bottom: bottomPadding + 20),
                          width: widthScreen,
                          child: CupertinoButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              await attendanceController.confirmRest(
                                notificationController.responseDetail.value?.data?.group_name ?? '', 
                                notificationController.responseDetail.value?.data?.attendance_class?.detail?[0].child_id ?? '', 
                                notificationController.responseDetail.value?.data?.attendance_class?.detail?[0].attendance_detail_id ?? ''
                              );
                            },
                            color: AppColors.green,
                            child: Text('Xác nhận',
                              style: GoogleFonts.raleway(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]
                ),
              )
            )
          )
        );
      }
    );
  }
}