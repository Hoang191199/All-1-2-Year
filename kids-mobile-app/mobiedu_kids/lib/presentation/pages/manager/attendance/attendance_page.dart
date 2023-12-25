import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/attendance/attendanceController.dart';
import 'package:mobiedu_kids/presentation/pages/manager/attendance/widget/body_attendance.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:mobiedu_kids/presentation/widgets/no_data.dart';

class AttendancePage extends StatelessWidget {
  AttendancePage({super.key});

  final attendanceController = Get.find<AttendanceController>();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    // double widthScreen = MediaQuery.of(context).size.width;

    return GetX(
      init: attendanceController,
      initState: (state) async {
        if(attendanceController.checkState.value == 0){
          await attendanceController.fetchData(store.getGroupname,convertDateTimeToString(attendanceController.dateNow));
        }
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
                padding: const EdgeInsetsDirectional.only(top: 19.0),
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
              middle: GestureDetector(
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => ShowDateNow());
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 50.0),
                  alignment: Alignment.center,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/calendar_page.png',
                          width: 36,
                          height: 36,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          convertDateTimeToString(attendanceController.dateNow),
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                      ]
                    ),
                ),
              ),
              backgroundColor: Colors.white,
              border: const Border(),
            ),
            child: attendanceController.isLoading.value
          ? const Center(
            child: CircularLoadingIndicator(),
          )
          : attendanceController.responseAttendance.value?.data ?.attendance_list?.detail?.isEmpty ?? true
              ? const NoData()
              : Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: DefaultTabController(
                    initialIndex: attendanceController.indexTabs,
                    length: 2,
                    child: Column(children: [
                      Container(
                        height: 36,
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: const Color(0xffffdff1)
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))
                        ),
                        child: TabBar(
                          labelColor: AppColors.primary,
                          unselectedLabelColor: AppColors.primary,
                          labelStyle: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          unselectedLabelStyle: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: AppColors.lightPink,
                          ),
                          tabs: const [
                            Tab(
                              child: Text('Điểm danh đến'),
                            ),
                            Tab(
                              child: Text('Điểm danh về'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            BodyAttendance(
                              tabs: 'check-in',
                            ),
                            BodyAttendance(
                              tabs: 'check-out',
                            )
                          ]
                        )
                      )
                    ]
                  ),
                )
              ),
            )
          )
        );
      }
    );
  }
}

class ShowDateNow extends StatelessWidget {
  ShowDateNow({Key? key}) : super(key: key);
  final attendanceController = Get.find<AttendanceController>();
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
                    attendanceController.fetchData(store.getGroupname, convertDateTimeToString(attendanceController.dateNow));
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
                onDateTimeChanged: (DateTime newDateTime) {
                  attendanceController.dateNow = newDateTime;
                },
                initialDateTime: attendanceController.dateNow,
                minimumYear: 1990,
                maximumYear: DateTime.now().year,
                maximumDate: DateTime.now()
              ),
            ),
          ],
        ),
      ),
    );
  }
}
