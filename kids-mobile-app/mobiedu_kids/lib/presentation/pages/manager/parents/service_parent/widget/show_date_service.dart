import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/presentation/controllers/service/service_parent_controller.dart';

class ShowDateParent extends StatelessWidget {
  ShowDateParent({Key? key}) : super(key: key);

  final serviceController = Get.find<ServiceParentController>();
  
  @override
  Widget build(BuildContext context) {
    DateTime dateOnly = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

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
                    if (serviceController.dateUsing.compareTo(dateOnly) < 0) {
                      showSnackbar(SnackbarType.notice, "Thất bại", "Ngày chọn không được nhỏ hơn ngày hiện tại!");
                      serviceController.dateUsing = DateTime.now();
                    }else{
                      serviceController.fetchData();
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
                  serviceController.dateUsing = newDateTime; 
                },
                initialDateTime: serviceController.dateUsing,
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