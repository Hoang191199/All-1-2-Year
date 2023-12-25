import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/presentation/pages/bookcase/widgets/filter_item.dart';
import 'package:qltv/presentation/pages/bookcase/widgets/sort_item.dart';

class SortFilterDialog extends StatelessWidget {
  const SortFilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return Dialog(
        alignment: Alignment.topRight,
        insetPadding: EdgeInsets.only(
            top: 160.0, right: 28.0, left: widthScreen - 320.0 - 28.0),
        backgroundColor: Colors.white,
        child: Container(
          width: 320.0,
          // height: 200.0,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 22.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'sort'.tr,
                          style: GoogleFonts.kantumruy(
                              textStyle: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)),
                        ),
                        const SizedBox(height: 16.0),
                        SortItem(sortType: BookcaseSortType.title),
                        const SizedBox(height: 8.0),
                        SortItem(sortType: BookcaseSortType.authors),
                        const SizedBox(height: 8.0),
                        SortItem(sortType: BookcaseSortType.created_at),
                        const SizedBox(height: 8.0),
                        SortItem(sortType: BookcaseSortType.last_seen),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('filter'.tr,
                            style: GoogleFonts.kantumruy(
                                textStyle: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black))),
                        const SizedBox(height: 16.0),
                        FilterItem(filterType: BookcaseFilterType.notRead),
                        const SizedBox(height: 8.0),
                        FilterItem(filterType: BookcaseFilterType.reading),
                        const SizedBox(height: 8.0),
                        FilterItem(
                            filterType: BookcaseFilterType.readCompleted),
                      ],
                    ),
                  ))
                ],
              )
            ],
          ),
        ));
  }
}
