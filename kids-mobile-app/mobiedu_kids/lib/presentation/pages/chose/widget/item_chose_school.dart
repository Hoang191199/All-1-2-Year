import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/pages/chose/chose_class.dart';

class ItemChoseSchool extends StatelessWidget {
  ItemChoseSchool({super.key, required this.school});
  final store = Get.find<LocalStorageService>();
  final dynamic school;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        store.setPagename = school.page_name;
        Get.to(() => ChoseClass());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        width: widthScreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              child: Image.asset(
                'assets/images/school.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(school.page_title ?? '',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 17.0
                ),
              )
            )
          ],
        ),
      )
    );
  }
}
