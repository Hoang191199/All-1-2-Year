import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/presentation/controllers/init_page_tab_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/rest/rest_controller.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';
import 'package:table_calendar/table_calendar.dart';

class RestPage extends StatelessWidget {
  RestPage({
    super.key
  });
  
  final restController = Get.find<RestController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return GetX(
      init: restController,
      initState: (state) async {
        await restController.fetchData();
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
                    final initPageTabController = Get.put(InitPageTabController());
                    initPageTabController.changeIndexTab(1);
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
              child: restController.isLoading.value
              ? const SizedBox(
                  child: Center(
                    child: CircularLoadingIndicator(),
                  ),
                )
              :
              Container(
                height: heightScreen,
                margin: const EdgeInsets.only(top: 18.0),
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final picked = await showDateRangePicker(
                            context: Get.context!,
                            initialEntryMode: DatePickerEntryMode.input,
                            initialDateRange: DateTimeRange(
                              start: restController.firstDate,
                              end: restController.lastDate,
                            ),
                            firstDate: DateTime(DateTime.now().year - 1),
                            lastDate: DateTime(DateTime.now().year + 1),
                          );
                          if (picked != null) {
                            restController.firstDate = picked.start;
                            restController.lastDate = picked.end;
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.lightGrey
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(10.0))
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(convertDateTimeToString(restController.firstDate),
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              Icon(
                                CupertinoIcons.arrow_right,
                                size: 16.0,
                                color: AppColors.grey,
                              ),
                              const SizedBox(width: 12.0),
                              Text(convertDateTimeToString(restController.lastDate),
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CupertinoTextField(
                              controller: restController.note,
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.lightGrey
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(6.0))
                              ),
                              maxLines: 3,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => 
                                dialogNote()
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.lightGrey,
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(6.0))
                              ),
                              child: Icon(
                                CupertinoIcons.chevron_down,
                                color: AppColors.grey,
                                size: 16.0,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      GestureDetector(
                        onTap: () {
                          restController.actionRegister();
                        },
                        child: Container(
                          width: widthScreen,
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          decoration: BoxDecoration(
                            color: AppColors.pink,
                            borderRadius: const BorderRadius.all(Radius.circular(10.0))
                          ),
                          alignment: Alignment.center,
                          child: Text('Gửi',
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
                      const SizedBox(height: 24.0),
                      Text(
                        'Lịch sử điểm danh',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.primary,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        'Nghỉ học: ${restController.responseRest.value?.data?.absence_count}',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.grey,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Column(
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
                                restController.firstDayOfMonth = DateTime(year, month, 1);
                                restController.lastDayOfMonth = DateTime(year, month + 1, 0);
                                restController.dateNow = focusedDay;
                                await restController.fetchData();
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
                              focusedDay: restController.dateNow,
                              calendarStyle: CalendarStyle(
                                todayDecoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                                    color: restController.colorDateNow ?? Colors.white,
                                  ),
                                todayTextStyle: TextStyle(
                                  color: restController.colorDateNow != null ? Colors.white : AppColors.black
                                ),
                                outsideDaysVisible: false,
                              ),
                              calendarBuilders: CalendarBuilders(
                                defaultBuilder: (context, date, _) {
                                  dynamic color;
                                  dynamic colorText;
                                  if (date.weekday == 7) { // sunday
                                    color = Colors.transparent;
                                  } else if (DateTime.now().isAfter(date)) {
                                    color = AppColors.grey;
                                    colorText = Colors.white;
                                  }
                                  restController.responseRest.value?.data?.attendance?.forEach((item){
                                    if(item.attendance_date == convertDateTimeToString(date)){
                                      color = checkColor(item.status ?? '0', item.is_checked ?? '0', item.feedback ?? '0');
                                      colorText = Colors.white;
                                    }
                                    if(item.attendance_date == convertDateTimeToString(restController.dateNow)){
                                      restController.colorDateNow = checkColor(item.status ?? '0', item.is_checked ?? '0', item.feedback ?? '1');
                                    }
                                  });
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 5.0),
                                    height: 41.0,
                                    width: 36.0,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                                      color: color,
                                      ),
                                      child: Center(
                                      child: Text(
                                        '${date.day}',
                                        style: TextStyle(
                                          color: colorText ?? AppColors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 20.0,
                                          width: 30.0,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFF67882),
                                            borderRadius: BorderRadius.all(Radius.circular(2.0))
                                          ),
                                        ),
                                        const SizedBox(width: 10,),
                                        const Text('Nghỉ học', 
                                          style: TextStyle(fontSize: 14),
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
                                            color: AppColors.green,
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(2.0)
                                            )
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          'Đã xác nhận',
                                          style: TextStyle(fontSize: 14),
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
                                            color: AppColors.grey,
                                            borderRadius: const BorderRadius.all(Radius.circular(2.0))
                                          ),
                                        ),
                                        const SizedBox(width: 10,),
                                        const Text('Chưa được điểm danh', 
                                          style: TextStyle(fontSize: 14),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 20.0,
                                          width: 30.0,
                                          decoration: BoxDecoration(
                                            color: AppColors.pink,
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(2.0)
                                            )
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          'Đi học',
                                          style: TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Container(
                                          height: 20.0,
                                          width: 30.0,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFF1B821),
                                            borderRadius:BorderRadius.all(
                                              Radius.circular(2.0)
                                            )
                                          ),
                                        ),
                                        const SizedBox(width: 10,),
                                        const Text(
                                          'Chờ xác nhận',
                                          style: TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ]
                            ),
                          )
                        ]
                      ),
                    ]
                  ),
                ),
              )
            )
          )
        );
      }
    );
  }
dialogNote() {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 150),
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: restController.listNote.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      restController.toggleCheck(index);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 14.0),
                      padding: const EdgeInsets.only(bottom: 8.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: AppColors.lightGrey),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            restController.listNote[index].title,
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Obx(() {
                            return restController.checkNote[index] == false ?
                            const SizedBox()
                            : Container(
                              padding: const EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                                color: AppColors.green,
                              ),
                              child: const Icon(
                                Icons.done,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}

checkColor(String status, String checked, String feedback) {
  /* 
  status  = 0: vang mat co ly do, 
          = 1: co mat,  
          = 2: nghi khong phep hoac xin phep muon / di - tinh tien an,  
          = 3: di - khong tinh tien an, 
          = 4: nghi khong ly do 
  check: giao vien diem danh hay chua 
  */
   
  // if (status == '1' && checked == '1' && feedback == '0') {
  if (status == '1' && checked == '1') {
    return AppColors.pink;
  } else if (status == '0' && checked == '1' && feedback == '0') {
    return const Color(0xFFF67882);
  } else if (status == '0' && checked == '0' && feedback == '0') {
    return AppColors.starYellow;
  } else if (status == '0' && checked == '0' && feedback == '1') {
    return AppColors.green;
  } else if (status == '1' && checked == '0') {
    return AppColors.grey;
  } else {
    Colors.transparent;
  }
}

class ShowDateNow extends StatelessWidget{
  ShowDateNow({Key? key}) : super(key: key);
  final restController = Get.find<RestController>();

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
                    restController.fetchData();
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
                  restController.dateNow = newDateTime;
                },
                initialDateTime: restController.dateNow,
                minimumYear: 2000,
                maximumYear: DateTime.now().year,
              ),
            ),
          ],
        ),
      ),
    );
  }
}