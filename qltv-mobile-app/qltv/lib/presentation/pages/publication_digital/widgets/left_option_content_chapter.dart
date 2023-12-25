import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/domain/entities/epub/epub_book.dart';
import 'package:qltv/domain/entities/epub/epub_chapter.dart';
import 'package:qltv/domain/entities/epub/epub_chapter_item.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_handle.dart';
import 'package:qltv/presentation/controllers/publication_digital/publication_digital_controller.dart';

class LeftOptionContentChapter extends StatefulWidget {
  LeftOptionContentChapter({
    super.key,
    required this.epubController,
  });

  final EpubController epubController;

  final publicationDigitalController = Get.find<PublicationDigitalController>();

  @override
  State<LeftOptionContentChapter> createState() => _LeftOptionContentChapterState();
}

class _LeftOptionContentChapterState extends State<LeftOptionContentChapter> with AutomaticKeepAliveClientMixin {
  final currentChapterKey = GlobalKey();

  late final List<EpubChapterItem> chapters;
  late final EpubChapter? currentChapter;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (currentChapterKey.currentContext != null) {
        Scrollable.ensureVisible(
          currentChapterKey.currentContext!,
          alignment: 0.5,
        );
      }
    });

    chapters = widget.epubController.epubBook?.chapters?.map((e) => EpubChapterItem.fromEpubChapter(e, 0)).toList() ?? [];

    currentChapter = linkSpineFileToChapter(
      widget.epubController.epubBook ?? EpubBook(),
      widget.epubController.bookController!.currentController.location.page,
      getFilesFromEpubSpine(widget.epubController.epubBook ?? EpubBook()),
      widget.epubController.bookController!.currentController.passedAnchors
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      shrinkWrap: true,
      itemCount: chapters.length,
      separatorBuilder: (context, index) => const SizedBox(height: 20.0), 
      itemBuilder: (context, index) => GestureDetector(
        key: currentChapter == chapters[index].original ? currentChapterKey : null,
        onTap: () {
          handlePressChapterItem(chapters[index]);
        },
        child: Container(
          height: 20.0,
          margin: EdgeInsets.only(left: chapters[index].level * 20.0),
          child: Text(
            chapters[index].title,
            style: GoogleFonts.kantumruy(
              textStyle: TextStyle(
                fontSize: 14.0, height: 1.4, 
                fontWeight: currentChapter == chapters[index].original 
                  ? FontWeight.w700 
                  : FontWeight.w400, 
                color: currentChapter == chapters[index].original ? AppColors.primaryBlue : Colors.black
              )
            ),
          ),
        ),
      ), 
    );
  }
  
  void handlePressChapterItem(EpubChapterItem chapter) {
    widget.publicationDigitalController.changeEpubChapterItem(widget.epubController, chapter);
    Navigator.of(context).pop();
  }
  
}