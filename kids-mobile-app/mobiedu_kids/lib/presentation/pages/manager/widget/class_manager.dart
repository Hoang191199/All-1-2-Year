import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/presentation/controllers/manager/manager_controller.dart';
import 'package:mobiedu_kids/presentation/pages/manager/manager_page.dart';

class ClassManager extends StatelessWidget {
  ClassManager({
    super.key,
    required this.item,
  });

  final ListItemService item;
  final managerController = Get.put(ManagerController());

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        managerController.reidrectPage(item.typeTitle);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        width: 120.0,
        height: 120.0,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            Image.asset(
              item.icon == '' ? 'assets/images/no_image_publication.png' : item.icon,
              fit: BoxFit.cover,
              // height: 30.0,
              // width: 28.0,
            ),
            const SizedBox(height: 10.0),
            Center(
              child: Text(
                item.title,
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.primary,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            )
          ]
        ),
      )
    );
  }
}
