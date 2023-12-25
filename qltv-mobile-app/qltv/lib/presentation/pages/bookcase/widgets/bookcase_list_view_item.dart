import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/domain/entities/bookcase.dart';
import 'package:qltv/presentation/controllers/bookcase/bookcase_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_bookmark_binding.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_highlight_binding.dart';
import 'package:qltv/presentation/controllers/publication_digital/publication_digital_controller.dart';
import 'package:qltv/presentation/pages/bookcase/widgets/progress_reading.dart';
import 'package:qltv/presentation/pages/publication_digital/publication_digital_page.dart';
import 'package:qltv/presentation/widgets/publication_image.dart';

class BookcaseListViewItem extends StatelessWidget {
  BookcaseListViewItem({
    super.key,
    required this.type,
    this.bookcase,
  });

  final String type;
  final Bookcase? bookcase;

  final bookcaseController = Get.find<BookcaseController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        handlePressItem();
      },
      child: Row(
        children: [
          PublicationImage(
            widthImage: 100.0, 
            heightImage: 144.0,
            imageUrl: bookcase?.metadata?.image_url ?? '',
            isShowDigital: true,
            isShowInfo: true,
            bookcase: bookcase,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Container(
              constraints: const BoxConstraints(minHeight: 144),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // type == 'last_seen' ? const SizedBox(height: 10.0) : const SizedBox(),
                      Text(
                        bookcase?.title ?? '',
                        style: GoogleFonts.kantumruy(
                          textStyle: TextStyle(
                            fontSize: type == 'last_seen' ? 16.0 : 22.0, 
                            height: type == 'last_seen' ? 1.56 : 1.36, 
                            fontWeight: FontWeight.w700, 
                            color: HexColor('333333')
                          )
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        type == 'last_seen' ? bookcase?.progress?.chapter ?? '' : '${bookcase?.authors ?? ''} (${bookcase?.publication_year ?? 0})',
                        style: GoogleFonts.kantumruy(
                          textStyle: TextStyle(fontSize: 14.0, height: 1.4, fontWeight: FontWeight.w400, color: HexColor('333333'))
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis
                      ),
                    ],
                  ),
                  ProgressReading(percentReading: bookcase?.progress?.progress ?? 0),
                ],
              ),
            ) 
          )
        ],
      ),
    );
  }
  
  void handlePressItem() {
    EpubHighlightBinding().dependencies();
    EpubBookmarkBinding().dependencies();
    Get.put(PublicationDigitalController());
    Get.to(() => PublicationDigitalPage(
      bookcase: bookcase,
    ));
  }
}