import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/presentation/controllers/search/search_controller.dart'
    as search;

class ListTags extends StatelessWidget {
  ListTags({
    super.key,
    required this.index,
    required this.name,
  });

  final int index;
  final String name;

  final searchController = Get.find<search.SearchController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: HexColor('D9E9F2'),
      ),
      child: Center(
        child: Text(name,
            style: GoogleFonts.kantumruy(
                textStyle: TextStyle(
                    fontSize: 14.0,
                    height: 1.4,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryBlue))),
      ),
    );
  }
}
