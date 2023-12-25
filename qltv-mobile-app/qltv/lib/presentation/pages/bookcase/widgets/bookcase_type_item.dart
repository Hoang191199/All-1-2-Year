import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/presentation/controllers/bookcase/bookcase_controller.dart';

class BookcaseTypeItem extends StatelessWidget {
  BookcaseTypeItem({
    super.key,
    required this.bookcaseType,
    required this.widthItem,
  });

  final String bookcaseType;
  final double widthItem;

  final bookcaseController = Get.find<BookcaseController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bookcaseController.changeBookcaseType(bookcaseType);
      },
      child: Container(
        width: widthItem,
        padding: const EdgeInsets.all(3.0),
        child: Obx(() => Container(
              decoration: bookcaseController.bookcaseType.value == bookcaseType
                  ? BoxDecoration(
                      color: HexColor('D9E9F2'),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(7.0)),
                    )
                  : null,
              child: Center(
                child: Text(
                    bookcaseType == BookcaseType.digital_publications
                        ? 'publication-store'.tr
                        : 'document-store'.tr,
                    style: GoogleFonts.kantumruy(
                        textStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: bookcaseController.bookcaseType.value ==
                                    bookcaseType
                                ? FontWeight.w700
                                : FontWeight.w400,
                            color: AppColors.primaryBlue))),
              ),
            )),
      ),
    );
  }
}
