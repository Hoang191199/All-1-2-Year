import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/domain/entities/bookmark.dart';
import 'package:qltv/domain/entities/epub/epub_book.dart';
import 'package:qltv/domain/entities/epub/epub_inner_page.dart';
import 'package:qltv/domain/entities/epub/epub_location.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_bookmark_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_handle.dart';

class LeftOptionContentBookmark extends StatelessWidget {
  LeftOptionContentBookmark({
    super.key,
    required this.itemId,
    required this.epubController,
  });

  final int itemId;
  final EpubController epubController;

  final epubBookmarkController = Get.find<EpubBookmarkController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        shrinkWrap: true,
        itemCount: epubBookmarkController.bookmarksData.length,
        separatorBuilder: (context, index) => const SizedBox(height: 15.0),
        itemBuilder: (context, index) {
          final data = epubBookmarkController.bookmarksData[index];
          final chapter = linkSpineFileToChapter(
            epubController.epubBook ?? EpubBook(),
            data?.metadata?.page ?? 0,
            getFilesFromEpubSpine(epubController.epubBook ?? EpubBook()),
            null
          )?.title ?? '';
          return Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: HexColor('FFFDFD'),
              borderRadius: const BorderRadius.all(Radius.circular(15.0))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      handlePressBookmarkItem(context, data);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chapter,
                          style: GoogleFonts.kantumruy(
                            textStyle: TextStyle(fontSize: 14.0, height: 1.4, fontWeight: FontWeight.w700, color: HexColor('333333'))
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4.0),
                        Text(
                          data?.metadata?.content ?? '',
                          style: GoogleFonts.kantumruy(
                            textStyle: TextStyle(fontSize: 14.0, height: 1.4, fontWeight: FontWeight.w400, color: HexColor('333333'))
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis
                        )
                      ],
                    ),
                  )
                ),
                const SizedBox(width: 10.0),
                GestureDetector(
                  onTap: epubBookmarkController.isLoadingDelete.value
                    ? null
                      : () {
                      handlePressDeleteBookmark(data);
                    },
                  child: Image.asset('assets/images/trash.png',
                    width: 24.0,
                    height: 24.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          );
        }));
  }

  void handlePressBookmarkItem(BuildContext context, Bookmark? bookmark) {
    EpubLocation<int, EpubInnerPage> location = EpubLocation(
      bookmark?.metadata?.page ?? 0, 
      EpubInnerPage(bookmark?.metadata?.inner_page ?? 0)
    );
    epubController.bookController?.setLocation(location);
    Navigator.of(context).pop();
  }

  Future<void> handlePressDeleteBookmark(Bookmark? bookmark) async {
    await epubBookmarkController.deleteBookmark(bookmark?.id ?? 0);
    if (!(epubBookmarkController.responseDelete.value?.error ?? false)) {
      epubBookmarkController.isPageBookmark.value = false;
      await epubBookmarkController.getListBookmarks(itemId);
    }
  }
}
