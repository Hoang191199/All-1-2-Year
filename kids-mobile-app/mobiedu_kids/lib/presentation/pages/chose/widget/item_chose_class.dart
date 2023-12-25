import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/init_page_tab_controller.dart';
import 'package:mobiedu_kids/presentation/pages/init/init_page.dart';

class ItemChoseClass extends StatelessWidget {
  ItemChoseClass({super.key, required this.classes});
  final store = Get.find<LocalStorageService>();
  final dynamic classes;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        store.setGrouptitle = classes.group_title;
        store.setGroupname = classes.group_name;
        store.setGroupId = classes.group_id;
        Get.to(() => InitPage(index: 0));
        final initPageTabController = Get.put(InitPageTabController());
        initPageTabController.changeIndexTab(0);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        width: widthScreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              child: Image.asset(
                'assets/images/class.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(classes.group_title ?? '',
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
