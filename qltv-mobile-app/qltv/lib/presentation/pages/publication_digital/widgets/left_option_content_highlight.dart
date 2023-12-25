import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/domain/entities/epub/epub_inner_node.dart';
import 'package:qltv/domain/entities/epub/epub_location.dart';
import 'package:qltv/domain/entities/highlight.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_highlight_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/publication_digital_controller.dart';
import 'package:qltv/presentation/pages/publication_digital/widgets/epub_highlight_note.dart';

class LeftOptionContentHighlight extends StatelessWidget {
  LeftOptionContentHighlight({
    super.key,
    required this.epubController,
  });

  final EpubController epubController;

  final publicationDigitalController = Get.find<PublicationDigitalController>();
  final epubHighlightController = Get.find<EpubHighlightController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        shrinkWrap: true,
        itemCount: epubHighlightController.highlightsData.length,
        separatorBuilder: (context, index) => const SizedBox(height: 15.0),
        itemBuilder: (context, index) {
          final data = epubHighlightController.highlightsData[index];
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
                GestureDetector(
                  onTap: () {
                    handlePressEditHighlight(context, data);
                  },
                  child: Image.asset('assets/images/edit.png',
                    width: 24.0,
                    height: 24.0,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      handlePressHighlightItem(context, data);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data?.metadata?.title ?? '',
                          style: GoogleFonts.kantumruy(
                            textStyle: TextStyle(fontSize: 14.0, height: 1.4, fontWeight: FontWeight.w700, color: HexColor('333333'))
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4.0),
                        Text(
                          data?.metadata?.description ?? '',
                          style: GoogleFonts.kantumruy(
                            textStyle: TextStyle(fontSize: 14.0, height: 1.4, fontWeight: FontWeight.w400, color: HexColor('333333'))
                          ),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis
                        )
                      ],
                    ),
                  )
                ),
                const SizedBox(width: 10.0),
                GestureDetector(
                  onTap: () {
                    handlePressDeleteHighlight(data);
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
        }
      )
    );
  }
  
  void handlePressEditHighlight(BuildContext context, Highlight? highlight) {
    Navigator.of(context).pop();
    publicationDigitalController.highlightText.value = highlight?.metadata?.highlightText ?? '';
    epubHighlightController.titleInputController.text = highlight?.metadata?.title ?? '';
    epubHighlightController.descriptionInputController.text = highlight?.metadata?.description ?? '';
    showEpubHighlightNote(context, 'edit', highlight?.item_id ?? 0, epubController, highlight);
  }
  
  void handlePressHighlightItem(BuildContext context, Highlight? highlight) {
    EpubLocation<int, EpubInnerNode> location = EpubLocation(
      highlight?.metadata?.page ?? 0, 
      EpubInnerNode(
        highlight?.metadata?.startNodeIndex ?? 0,
        highlight?.metadata?.startOffset ?? 0
      )
    );
    epubController.bookController?.setLocation(location);
    Navigator.of(context).pop();
  }

  Future<void> handlePressDeleteHighlight(Highlight? highlight) async {
    await epubHighlightController.deleteHighlight(highlight?.id ?? 0);
    if (!(epubHighlightController.responseDelete.value?.error ?? false)) {
      await epubHighlightController.getListHighlight(highlight?.item_id ?? 0);
      if (!epubHighlightController.isLoading.value) {
        epubController.bookController?.setLocation(
          epubController.bookController!.currentController.location,
          forced: true,
        );
      }
    }
  }
}
