import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/domain/entities/bookcase.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_bookmark_binding.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_highlight_binding.dart';
import 'package:qltv/presentation/controllers/publication_digital/publication_digital_controller.dart';
import 'package:qltv/presentation/pages/bookcase/widgets/progress_reading.dart';
import 'package:qltv/presentation/pages/publication_digital/publication_digital_page.dart';
import 'package:qltv/presentation/widgets/publication_image.dart';

class BookcaseGridViewItem extends StatelessWidget {
  const BookcaseGridViewItem({
    super.key,
    this.bookcase,
  });

  final Bookcase? bookcase;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        handlePressItem();
      },
      child: SizedBox(
        width: 100.0,
        child: Column(
          children: [
            PublicationImage(
              widthImage: 100.0, 
              heightImage: 144.0,
              imageUrl: bookcase?.metadata?.image_url ?? '',
              isShowDigital: true,
              isShowInfo: true,
              bookcase: bookcase,
            ),
            const SizedBox(height: 4.0),
            SizedBox(
              height: 40.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      bookcase?.title ?? '',
                      style: GoogleFonts.kantumruy(
                        textStyle: TextStyle(fontSize: 14.0, height: 1.4, fontWeight: FontWeight.w700, color: HexColor('343232'))
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis
                    )
                  )
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            ProgressReading(percentReading: bookcase?.progress?.progress ?? 0)
          ],
        ),
      ),
    );
  }
  
  void handlePressItem() {
    EpubHighlightBinding().dependencies();
    EpubBookmarkBinding().dependencies();
    Get.put(PublicationDigitalController());
    Get.to(() => PublicationDigitalPage(
      bookcase: bookcase
    ));
  }
}