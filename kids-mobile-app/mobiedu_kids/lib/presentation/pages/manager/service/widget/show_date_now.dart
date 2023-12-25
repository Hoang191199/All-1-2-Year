import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/service/service_controller.dart';

class ShowDateNow extends StatelessWidget {
  ShowDateNow({Key? key}) : super(key: key);

  final serviceController = Get.find<ServiceController>();

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
                    if(serviceController.tabs.value == 'using-service'){
                      serviceController.fetchData();
                    }else{
                      serviceController.historyService();
                    }
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
                  serviceController.tabs.value == 'using-service' 
                  ? serviceController.dateUsing = newDateTime 
                  : serviceController.dateHistory = newDateTime;
                },
                initialDateTime: serviceController.tabs.value == 'using-service' 
                  ? serviceController.dateUsing
                  : serviceController.dateHistory,
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