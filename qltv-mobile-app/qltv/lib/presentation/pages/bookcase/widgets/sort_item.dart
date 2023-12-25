import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/presentation/controllers/bookcase/bookcase_controller.dart';

class SortItem extends StatelessWidget {
  SortItem({
    super.key,
    required this.sortType,
  });

  final String sortType;

  final bookcaseController = Get.find<BookcaseController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bookcaseController.changeBookcaseSortType(sortType);
      },
      child: Row(
        children: [
          Obx(
            () => bookcaseController.bookcaseSortType.value == sortType
                ? Icon(CupertinoIcons.largecircle_fill_circle,
                    size: 16.0, color: AppColors.primaryBlue)
                : Icon(CupertinoIcons.circle,
                    size: 16.0, color: HexColor('D9D9D9')),
          ),
          const SizedBox(width: 8.0),
          Text(getItemSortLabel(sortType),
              style: GoogleFonts.kantumruy(
                  textStyle: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)))
        ],
      ),
    );
  }

  String getItemSortLabel(String type) {
    switch (type) {
      case BookcaseSortType.title:
        return 'title-name'.tr;
      case BookcaseSortType.authors:
        return 'author-name'.tr;
      case BookcaseSortType.created_at:
        return 'created_at'.tr;
      case BookcaseSortType.last_seen:
        return 'last_seen'.tr;
      default:
        return '';
    }
  }
}
