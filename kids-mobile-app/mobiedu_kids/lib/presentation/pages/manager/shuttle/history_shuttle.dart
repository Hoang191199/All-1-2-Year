import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/presentation/controllers/shuttle/shuttle_controller.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryShuttle extends StatelessWidget {
  HistoryShuttle({super.key});

  final shuttleController = Get.find<ShuttleController>();

  @override
  Widget build(BuildContext context) {
    return GetX(
      init: shuttleController,
      initState: (state) async {
        await shuttleController.historyClass();
        
      },
      builder: (_) { 
        return Scaffold(
        body: CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          navigationBar: CupertinoNavigationBar(
            padding: const EdgeInsetsDirectional.only(top: 19.0),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                shuttleController.assignDate.value = [];
                shuttleController.doneDate.value = [];
                shuttleController.isDateNow = false;
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
              'Lịch sử đón muộn',
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
          child: shuttleController.isLoadingHistory.value
        ? const SizedBox(
            child: Center(
              child: CircularLoadingIndicator(),
            ),
          )
        : Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.grey,
                        blurRadius: 1.5,
                        spreadRadius: 0.5,
                      ), //BoxShadow
                      const BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: TableCalendar(
                    locale: "vi-VN", 
                    headerStyle: HeaderStyle(
                      headerMargin: const EdgeInsets.only(bottom: 12.0),
                      headerPadding: const EdgeInsets.symmetric(vertical: 14.0),
                      formatButtonVisible: false,
                      titleCentered: true,
                      leftChevronVisible: true,
                      rightChevronVisible: true,
                      titleTextStyle: TextStyle(
                        color: AppColors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700
                      )
                    ),
                    onPageChanged: (focusedDay) async {
                        int month = focusedDay.month;
                        int year = focusedDay.year;
                        DateTime firstDay = DateTime(year, month, 1);
                        DateTime lastDay = DateTime(year, month + 1, 0);
                        shuttleController.firstDayOfMonthString = convertDateTimeToString(firstDay);
                        shuttleController.lastDayOfMonthString = convertDateTimeToString(lastDay);
                        shuttleController.focusedDay = focusedDay;
                        await shuttleController.historyClass();
                    },
                    onHeaderTapped: (focusedDay){
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) => 
                        ShowDateNow()
                      );
                    },
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: shuttleController.focusedDay,
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                          color: shuttleController.isDateNow ? AppColors.pink : Colors.white,
                        ),
                      todayTextStyle:  TextStyle(color: shuttleController.isDateNow ? Colors.white : Colors.black),
                      outsideDaysVisible: false,
                    ),
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, date, _) {
                        bool isDateAssign = false;
                        bool isDone = false;
                        for (var i = 0; i < shuttleController.assignDate.length; i++) {
                          if (isSameDay(shuttleController.assignDate[i], date)) {
                            // isDone = true;
                            isDateAssign = true;
                            break;
                          }
                        }
                        for (var i = 0; i < shuttleController.doneDate.length; i++) {
                          if (isSameDay(shuttleController.doneDate[i], date)) {
                            // isDateAssign = true;
                            isDone = true;
                            break;
                          }
                        }
                        return Container(
                          margin: const EdgeInsets.only(bottom: 5.0),
                          height: 41,
                          width: 36,
                          decoration:  BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                            color: isDone ? const Color(0xFFF1B821) : isDateAssign ?  AppColors.pink : Colors.transparent,
                            ),
                            child: Center(
                            child: Text(
                              '${date.day}',
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: isDateAssign ? Colors.white : isDone ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          )
                        );
                      },
                    ),
                  ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 20.0,
                              width: 30.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF1B821),
                                borderRadius: BorderRadius.all(Radius.circular(2.0))
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Text('Ngày đã trông muộn', 
                              style:GoogleFonts.raleway(
                                textStyle: const TextStyle(fontSize: 14),
                              )
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              height: 20.0,
                              width: 30.0,
                              decoration: BoxDecoration(
                                color: AppColors.pink,
                                borderRadius: const BorderRadius.all(Radius.circular(2.0))
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Text('Lịch được phân công', 
                              style: GoogleFonts.raleway(
                                textStyle: const TextStyle(fontSize: 14),
                              )
                            )
                          ],
                        )
                      ]
                    ),
                  )
                ],
              )
            ),
          )
        );
      }
    );
  }
}

class ShowDateNow extends StatelessWidget{
  ShowDateNow({Key? key}) : super(key: key);
  final shuttleController = Get.find<ShuttleController>();

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
                    shuttleController.historyClass();
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
                  shuttleController.focusedDay = newDateTime;
                },
                initialDateTime: shuttleController.focusedDay,
                minimumYear: 1990,
                maximumYear: DateTime.now().year,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

