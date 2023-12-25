import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_controller.dart';
import 'package:mobiedu_kids/presentation/pages/chose/widget/item_chose_class.dart';

class ChoseClass extends StatelessWidget {
  ChoseClass({super.key});

  final splashController = Get.find<SplashScreenController>();
  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
      padding: const EdgeInsetsDirectional.only(top: 12.0),
      leading: Container(
        margin: const EdgeInsets.only(left: 20.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            CupertinoIcons.back,
            color: AppColors.primary,
          ),
        ),
      ),
      middle: Text(
        'Chọn lớp',
        style: GoogleFonts.raleway(
          textStyle: TextStyle(
              color: AppColors.primary,
              fontSize: 22.0,
              fontWeight: FontWeight.w700),
        ),
      ),
        backgroundColor: Colors.white,
        border: const Border(),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: splashController.responseManagerData.value?.data?.classes?.length,
                itemBuilder: (context, index) => store.getPagename == splashController.responseManagerData.value?.data?.classes?[index].page_name
                  ? ItemChoseClass(classes: splashController.responseManagerData.value?.data?.classes?[index])
                  : const SizedBox()
              ),
            )
          ],
        )
      )
    );
  }
}
