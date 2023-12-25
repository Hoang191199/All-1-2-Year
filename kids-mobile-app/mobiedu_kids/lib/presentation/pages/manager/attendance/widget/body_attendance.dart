import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/attendance/attendanceController.dart';
import 'package:mobiedu_kids/presentation/pages/manager/attendance/widget/student_in_attendance.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class BodyAttendance extends StatelessWidget {
  BodyAttendance({
    super.key,
    required this.tabs,
  });

  final String tabs;

  final attendanceController = Get.find<AttendanceController>();

  @override
  Widget build(BuildContext context) {
    attendanceController.tabs.value = tabs;
    final data = attendanceController.responseAttendance.value?.data;

    return attendanceController.isLoading.value ?
      const SizedBox(
        child: Center(
          child: CircularLoadingIndicator(),
        ),
      ) 
    : Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          Container(
            decoration: ShapeDecoration(
              color: AppColors.lightPink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 11.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tabs == "check-in" ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text('Tổng số: ${data?.attendance_list?.detail?.length}', 
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                            color: AppColors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Nghỉ học: ${data?.attendance_list?.absence_count}' ,
                        style: GoogleFonts.raleway( 
                          textStyle: TextStyle(
                            color: AppColors.grey, 
                            fontSize: 14.0, 
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: AppColors.grey,
                            size: 4.0,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            'Không phép: ${attendanceController.notAllowed}',
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: AppColors.grey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: AppColors.grey,
                            size: 4.0,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            'Có phép: ${attendanceController.leavePermission}',
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: AppColors.grey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ) 
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text('Tổng số: ${(int.parse(data?.attendance_back?.came_back_count ?? '0') + int.parse(data?.attendance_back?.not_came_back_count ?? '0'))}', 
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                            color: AppColors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: AppColors.grey,
                            size: 4.0,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            'Đã về: ${data?.attendance_back?.came_back_count ?? '0'}',
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: AppColors.grey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: AppColors.grey,
                            size: 4.0,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            'Chưa về: ${data?.attendance_back?.not_came_back_count ?? '0'}',
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: AppColors.grey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CupertinoButton(
                    onPressed: () {
                      tabs == "check-in" ? attendanceController.updateStudents() :attendanceController.updateCheckOutStudents(context);
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.pink,
                    child: Text(
                      'Cập nhật',
                      style: GoogleFonts.raleway(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14.0),
          Expanded(
            child: ListView.builder(
              itemCount: tabs == "check-in" ? attendanceController.listDetailCheckIn.length 
              : attendanceController.listDetailCheckOut.length,
              itemBuilder: (context, index) => StudentInAttendace(
                index: index,
                tabs: tabs
              )
            )
          )
        ],
      )
    );
  }
}


