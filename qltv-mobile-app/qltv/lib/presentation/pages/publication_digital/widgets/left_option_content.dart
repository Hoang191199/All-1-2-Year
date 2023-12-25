import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/publication_digital_controller.dart';
import 'package:qltv/presentation/pages/publication_digital/widgets/left_option_content_bookmark.dart';
import 'package:qltv/presentation/pages/publication_digital/widgets/left_option_content_highlight.dart';

import 'left_option_content_chapter.dart';

class LeftOptionContent extends StatelessWidget {
  LeftOptionContent({
    super.key,
    required this.itemId,
    required this.epubController,
  });

  final int itemId;
  final EpubController epubController;

  final publicationDigitalController = Get.find<PublicationDigitalController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => publicationDigitalController.tapOptionIndex.value == 0
        ? Container(
          margin: const EdgeInsets.only(top: 22.0, bottom: 20.0),
          child: LeftOptionContentChapter(epubController: epubController),
        )
        : publicationDigitalController.tapOptionIndex.value == 1
          ? Container(
            margin: const EdgeInsets.only(top: 16.0),
            child: LeftOptionContentBookmark(
              itemId: itemId,
              epubController: epubController,
            ),
          )
          : Container(
            margin: const EdgeInsets.only(top: 16.0),
            child: LeftOptionContentHighlight(
              epubController: epubController,
            ),
          )
    );
  }
}