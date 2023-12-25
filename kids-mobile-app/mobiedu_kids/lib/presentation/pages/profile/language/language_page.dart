import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';

class LanguagePage extends StatelessWidget {
  LanguagePage({super.key});
  final store = Get.find<LocalStorageService>();
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: CupertinoPageScaffold(
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
            'Ngôn ngữ',
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
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      updateLocale(const Locale('vi', 'VN'), context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.lightGrey
                          )
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: widthScreen - 100,
                            child: Text(
                              "Tiếng Việt",
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.0
                                ),
                              ),
                            )
                          ),
                          Icon(
                            CupertinoIcons.check_mark_circled_solid,
                            color: AppColors.green,
                            size: 16.0,
                          ),
                        ],
                      )
                    )
                  ),
                ]
              ),
            )
          ]
        )
      )
    );
  }

  updateLocale(Locale locale, BuildContext context) {
    Get.updateLocale(locale);
    store.setLocale = [locale.languageCode, locale.countryCode ?? ""];
  }
}
