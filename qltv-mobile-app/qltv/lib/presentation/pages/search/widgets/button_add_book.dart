import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/config/app_common.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/presentation/controllers/search/search_controller.dart'
    as search;
import 'package:qltv/presentation/pages/search/widgets/dialog_register.dart';

// ignore: must_be_immutable
class ButtonAddBook extends StatelessWidget {
  ButtonAddBook(
      {super.key, this.type, required this.idItem, required this.remain});

  String? type;
  int idItem;
  int remain;
  final searchController = Get.find<search.SearchController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return 
    searchController.searchType.value != 'document' ?
    Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: SizedBox(
            height: 50,
            width: widthScreen,
            child: ElevatedButton(
              onPressed: () {
                if (remain > 0) {
                  openDialog(context, widthScreen, heightScreen, idItem, type);
                } else if (type != 'publications') {
                  searchController.add(idItem, context);
                } else {
                  showSnackbar(
                      SnackbarType.error, 'notification'.tr, 'no-bookcase'.tr);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: type == 'publications'
                    ? AppColors.primary
                    : AppColors.starYellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
              ),
              child: Text(
                  type == 'publications'
                      ? 'register-bookcase'.tr
                      : 'add-to-bookcase'.tr,
                  style: GoogleFonts.kantumruy(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  )),
            ),
          )),
    ) : const SizedBox();
  }

  Future openDialog(context, width, height, idItem, type) => showDialog(
      context: context,
      builder: (context) => DiaLog(
          remain: remain,
          widthScreen: width,
          heightScreen: height,
          idItem: idItem,
          type: type));
}
