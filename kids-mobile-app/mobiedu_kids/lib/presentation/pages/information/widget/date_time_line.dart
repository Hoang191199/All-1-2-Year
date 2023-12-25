import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/infomation/infomation_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_controller.dart';

class DateTimeLine extends StatefulWidget {
  const DateTimeLine({super.key});

  @override
  State<DateTimeLine> createState() => _DateTimeLineState();
}

class _DateTimeLineState extends State<DateTimeLine> {
  
  final infoUser = Get.find<SplashScreenController>();
  final informationController = Get.find<InformationController>();
  final DatePickerController datePickerController = DatePickerController();

  void executeAfterBuild() {
    // datePickerController.animateToSelection();
    datePickerController.animateToDate(
      informationController.dateNow.subtract(const Duration(days: 2)),
      duration: const Duration(milliseconds: 50)
    );
    // datePickerController.jumpToSelection();
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) => executeAfterBuild());
    
    return DatePicker(
      // informationController.startOfWeek,
      // DateTime.parse(infoUser.responseManagerData.value?.data?.children?[informationController.indexChild.value].begin_at ?? ''),
      getStartDate(),
      controller: datePickerController,
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
      // daysCount: 7,
      daysCount: informationController.dateNow.difference(getStartDate()).inDays + DateTime(informationController.dateNow.year, informationController.dateNow.month + 1, 0).day,
      onDateChange: (date) {
        informationController.dateNow = date;
        informationController.startOfWeek = getDateOfWeek(date.subtract(Duration(days: date.weekday - 1)));
        informationController.endOfWeek = getDateOfWeek(date.add(Duration(days: DateTime.daysPerWeek - date.weekday)));
        informationController.fetchData();
      },
      locale: 'vi_VN'
    );
  }

  DateTime getStartDate() {
    final dateBeginAt = DateTime.parse(infoUser.responseManagerData.value?.data?.children?[informationController.indexChild.value].begin_at ?? '');
    final twoMonthAgo = DateTime(informationController.dateNow.year, informationController.dateNow.month -2, 1);
    if (dateBeginAt.isAfter(twoMonthAgo)) {
      return dateBeginAt;
    } else {
      return twoMonthAgo;
    }
  }

  DateTime getDateOfWeek(DateTime dateData) {
    return DateTime(dateData.year, dateData.month, dateData.day);
  }
}