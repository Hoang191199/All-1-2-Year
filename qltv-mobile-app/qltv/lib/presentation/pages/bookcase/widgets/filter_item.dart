import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/presentation/controllers/bookcase/bookcase_controller.dart';

class FilterItem extends StatelessWidget {
  FilterItem({
    super.key,
    required this.filterType,
  });

  final int filterType;

  final bookcaseController = Get.find<BookcaseController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bookcaseController.changeBookcaseFilterType(filterType);
      },
      child: Row(
        children: [
          Obx(() => bookcaseController.bookcaseFilterType.contains(filterType)
              ? Icon(CupertinoIcons.checkmark_square_fill,
                  size: 16.0, color: AppColors.primaryBlue)
              : Icon(CupertinoIcons.square,
                  size: 16.0, color: HexColor('D9D9D9'))),
          const SizedBox(width: 8.0),
          Text(getItemFilterLabel(filterType),
              style: GoogleFonts.kantumruy(
                  textStyle: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)))
        ],
      ),
    );
  }

  String getItemFilterLabel(int type) {
    switch (type) {
      case BookcaseFilterType.notRead:
        return 'unread'.tr;
      case BookcaseFilterType.reading:
        return 'reading'.tr;
      case BookcaseFilterType.readCompleted:
        return 'read'.tr;
      default:
        return '';
    }
  }
}
