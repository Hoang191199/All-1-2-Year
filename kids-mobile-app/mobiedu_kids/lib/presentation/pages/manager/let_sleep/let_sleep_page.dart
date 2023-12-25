import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/domain/entities/attendance/hygiene_temp.dart';
import 'package:mobiedu_kids/presentation/controllers/sleep/sleep_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/hygiene/widget/item_student.dart';
import 'package:mobiedu_kids/presentation/pages/manager/hygiene/widget/quick_review.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class LetSleepPage extends StatelessWidget {
  LetSleepPage({super.key});

  final sleepController = Get.find<SleepController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return GetX(
      init: sleepController,
      initState: (state) async {
        await sleepController.fetchData();
      },
      builder: (_) { 
        var hygieneTemp = List<HygieneTemp>.from(sleepController.listSleepTemp);
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
                    sleepController.checkAll.value = false;
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
                  'Ngủ',
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
              child: sleepController.isLoading.value ?
              const SizedBox(
                child: Center(
                  child: CircularLoadingIndicator(),
                ),
              )
            : sleepController.listSleepTemp.isNotEmpty ?
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                width: widthScreen,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: AppColors.green,
                          value: sleepController.checkAll.value,
                          onChanged: (bool? value) {
                            sleepController.checkAll.value = value!;
                            sleepController.checkAllData(value);
                            sleepController.listSleepTemp.value = hygieneTemp;
                          },
                        ),
                        Text(
                          'Chọn tất cả',
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: sleepController.listSleepTemp.length,
                        itemBuilder: (context, index) => ItemStudent(
                          data: sleepController.listSleepTemp[index],
                          index: index,
                          type: 'sleep',
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.only(top: 10.0, bottom: bottomPadding + 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoButton(
                            onPressed: () {
                              sleepController.listName();
                              Get.to(() => QuickReview(page: 'sleep'));
                            },
                            padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 30.0),
                            color: const Color(0xFFF2F2F2),
                            child: Text(
                              'Nhận xét nhanh',
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: CupertinoButton(
                              padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 30.0),
                              onPressed: () {
                                sleepController.updateData();
                              },
                              color: AppColors.pink,
                              child: Text(
                                'Lưu',
                                style: GoogleFonts.raleway(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox(
                width: widthScreen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/no_assig.png'
                    ),
                    const SizedBox(height: 8.0),
                    Text('Không có dữ liệu', 
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: AppColors.grey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                  ]
                ),
              ),
            )
          )
        );
      }
    );
  }
}
