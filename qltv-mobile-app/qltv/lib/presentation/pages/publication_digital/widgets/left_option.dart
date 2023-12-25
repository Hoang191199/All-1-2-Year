import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/publication_digital_controller.dart';
import 'package:qltv/presentation/pages/publication_digital/widgets/left_option_tab.dart';
import 'package:qltv/presentation/pages/publication_digital/widgets/left_option_title.dart';

import 'left_option_content.dart';

class LeftOption extends StatelessWidget {
  LeftOption({
    super.key,
    required this.itemId,
    required this.title,
    required this.epubController,
  });

  final int itemId;
  final String title;
  final EpubController epubController;

  final publicationDigitalController = Get.find<PublicationDigitalController>();

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return Dialog(
      alignment: Alignment.topLeft,
      insetPadding: EdgeInsets.only(
        top: 25.0, 
        left: 0.0,
        // right: 97.0,
        right: 50.0,
        bottom: bottomPadding
      ),
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.0),
          // bottomRight: Radius.circular(10.0)
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 8.0, left: 28.0, right: 25.0, bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            LeftOptionTitle(title: title),
            LeftOptionTab(),
            Expanded(
              child: LeftOptionContent(
                itemId: itemId,
                epubController: epubController
              )
            )
          ],
        ),
      ),
    );
  }
}