import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/presentation/controllers/publication_digital/publication_digital_controller.dart';

class LeftOptionTab extends StatelessWidget {
  LeftOptionTab({super.key});

  final publicationDigitalController = Get.find<PublicationDigitalController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        initialIndex: publicationDigitalController.tapOptionIndex.value,
        child: Column(
          children: [
            TabBar(
              tabs: [
                tabItem('table-content'.tr),
                tabItem('bookmark'.tr),
                tabItem('note'.tr),
              ],
              onTap: (value) {
                publicationDigitalController.changeTapOptionIndex(value);
              },
              labelPadding: const EdgeInsets.all(0.0),
              labelColor: AppColors.primaryBlue,
              unselectedLabelColor: HexColor('333333'),
              indicatorColor: AppColors.primaryBlue,
            ),
          ],
        ));
  }

  Widget tabItem(String tabLabel) {
    return Tab(
        child: Text(tabLabel,
            style: GoogleFonts.kantumruy(
                textStyle: const TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.w400))));
  }
}
