import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/presentation/controllers/bookcase/bookcase_controller.dart';
import 'package:qltv/presentation/pages/bookcase/widgets/sort_filter_dialog.dart';

class BookcaseSearchSortFilter extends StatelessWidget {
  BookcaseSearchSortFilter({super.key});

  final bookcaseController = Get.find<BookcaseController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SizedBox(
            height: 36.0,
            child: CupertinoSearchTextField(
              controller: bookcaseController.searchInputController,
              backgroundColor: HexColor('FFFDFD'),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              itemSize: 16.0,
              itemColor: HexColor('7B858B'),
              placeholder: 'title-placeholder'.tr,
              style: GoogleFonts.kantumruy(
                  textStyle: TextStyle(
                      fontSize: 14.0,
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                      color: HexColor('7B858B'),
                      decorationThickness: 0.0)),
              onSuffixTap: () {
                bookcaseController.searchInputController.clear();
                bookcaseController.fetchData();
              },
              onSubmitted: (value) async {
                await Future.delayed(const Duration(milliseconds: 200));
                bookcaseController.fetchData();
              },
            ),
          ),
        ),
        Row(
          children: [
            const SizedBox(width: 16.0),
            Obx(
              () => bookcaseController.bookcaseViewType.value ==
                      BookcaseViewType.grid
                  ? GestureDetector(
                      onTap: () {
                        bookcaseController
                            .changeBookcaseViewType(BookcaseViewType.list);
                      },
                      child: Icon(CupertinoIcons.line_horizontal_3,
                          size: 22.0, color: HexColor('7B858B')),
                    )
                  : GestureDetector(
                      onTap: () {
                        bookcaseController
                            .changeBookcaseViewType(BookcaseViewType.grid);
                      },
                      child: Icon(CupertinoIcons.square_grid_2x2,
                          size: 22.0, color: HexColor('7B858B')),
                    ),
            ),
            const SizedBox(width: 8.0),
            GestureDetector(
              onTap: () {
                handlePressMenu(context);
              },
              child: Transform.rotate(
                angle: pi / 2,
                child: Icon(Icons.tune, size: 22.0, color: HexColor('7B858B')),
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<void> handlePressMenu(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return const SortFilterDialog();
        }).then((value) => bookcaseController.fetchData());
  }
}
