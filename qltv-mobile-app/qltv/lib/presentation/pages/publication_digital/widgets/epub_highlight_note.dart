import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/domain/entities/highlight.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_highlight_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/publication_digital_controller.dart';


void showEpubHighlightNote(BuildContext context, String option, int itemId, EpubController epubController, Highlight? highlight) {
  double widthScreen = MediaQuery.of(context).size.width;
  double heightScreen = MediaQuery.of(context).size.height;

  final publicationDigitalController = Get.find<PublicationDigitalController>();
  final epubHighlightController = Get.find<EpubHighlightController>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    // shape: const RoundedRectangleBorder(
    //   borderRadius: BorderRadius.vertical(
    //     top: Radius.circular(15.0),
    //   ),
    // ),
    backgroundColor: HexColor('E8EFF3'),
    builder: (BuildContext context) {
      return SizedBox(
        height: heightScreen - 100.0,
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            backgroundColor: HexColor('E8EFF3'),
            body: Column(
              children: [
                const SizedBox(height: 8.0),
                Opacity(
                  opacity: 0.25,
                  child: Container(
                    width: 42.0,
                    height: 3.0,
                    decoration: BoxDecoration(
                      color: HexColor('343232'),
                      borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  option == 'add'
                    ? 'take-note'.tr
                    : option == 'edit'
                      ? 'edit-note'.tr
                      : 'note'.tr,
                  style: GoogleFonts.kantumruy(
                    textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: HexColor('333333'))
                  ),
                ),
                const Divider(color: Colors.black12, thickness: 1.0),
                const SizedBox(height: 6.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            publicationDigitalController.highlightText.value,
                            style: GoogleFonts.kantumruy(
                              textStyle: TextStyle(fontSize: 14.0, height: 1.4, fontWeight: FontWeight.w400, color: HexColor('343232'))
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20.0, left: 16.0),
                            child: Text(
                              'title'.tr,
                              style: GoogleFonts.kantumruy(
                                textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: HexColor('333333'))
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextField(
                            controller: epubHighlightController.titleInputController,
                            textInputAction: TextInputAction.done,
                            keyboardType: option == 'view' ? TextInputType.none : TextInputType.text,
                            readOnly: option == 'view' ? true : false,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                              hintText: option == 'view' ? null : 'take-note'.tr,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.primary),
                                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.primary),
                                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                              ),
                            ),
                            maxLines: 3,
                            style: GoogleFonts.kantumruy(
                              textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: HexColor('333333'), decorationThickness: 0.0)
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 32.0, left: 16.0),
                            child: Text(
                              'content'.tr,
                              style: GoogleFonts.kantumruy(
                                textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: HexColor('333333'))
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextField(
                            controller: epubHighlightController.descriptionInputController,
                            textInputAction: TextInputAction.done,
                            keyboardType: option == 'view' ? TextInputType.none : TextInputType.text,
                            readOnly: option == 'view' ? true : false,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                              hintText: option == 'view' ? null : 'input-content'.tr,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.primary),
                                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.primary),
                                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                              ),
                            ),
                            maxLines: 6,
                            style: GoogleFonts.kantumruy(
                              textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: HexColor('333333'), decorationThickness: 0.0)
                            ),
                          ),
                          option != 'view'
                            ? Container(
                              width: widthScreen,
                              height: 36.0,
                              margin: const EdgeInsets.only(top: 20.0, bottom: 40.0),
                              child: ElevatedButton(
                                onPressed: epubHighlightController.isLoadingAddEdit.value
                                  ? null
                                  : () {
                                    handlePressSubmit(context, option, itemId, highlight, epubController, epubHighlightController, publicationDigitalController);
                                  },
                                style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                                  ),
                                  elevation: 0.0,
                                  backgroundColor: AppColors.primaryBlue,
                                  textStyle: GoogleFonts.kantumruy(
                                    textStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: Colors.white)
                                  )
                                ),
                                child: Text(option == 'add' ? 'take-note'.tr : 'edit-note'.tr)),
                            )
                            : Container()
                        ],
                      ),
                    ),
                ))
              ],
            ),
          ),
        ),
      );
    }
  ).then((value) => {
    publicationDigitalController.highlightText.value = '',
    epubHighlightController.titleInputController.clear(),
    epubHighlightController.descriptionInputController.clear()
  });
}

Future<void> handlePressSubmit(BuildContext context, String option, int itemId, Highlight? highlight, EpubController epubController, EpubHighlightController epubHighlightController, PublicationDigitalController publicationDigitalController) async {
  final title = epubHighlightController.titleInputController.text.trim();
  final highlightText = publicationDigitalController.highlightText.value.trim();
  final description = epubHighlightController.descriptionInputController.text.trim();
  const color = 'blue';
  final location = epubController.bookController!.currentController.location;
  final page = location.page;
  final highlightedRanges = publicationDigitalController.highlightedRanges;
  if (option == 'add') {
    await epubHighlightController.addHighlight(itemId, title, highlightText, description, color, page, highlightedRanges[0].startNodeIndex, highlightedRanges[0].endNodeIndex, highlightedRanges[0].startOffset, highlightedRanges[0].endOffset);
  } else {
    await epubHighlightController.updateHighlight(highlight?.id ?? 0, title, highlightText, description, color, page, highlight?.metadata?.startNodeIndex ?? 0, highlight?.metadata?.endNodeIndex ?? 0, highlight?.metadata?.startOffset ?? 0, highlight?.metadata?.endOffset ?? 0);
  }
  if (!(epubHighlightController.responseAddEdit.value?.error ?? false)) {
    await epubHighlightController.getListHighlight(itemId);
    if (!epubHighlightController.isLoading.value) {
      epubController.bookController?.setLocation(
        epubController.bookController!.currentController.location,
        forced: true,
      );
    }
    if (context.mounted) {
      Navigator.of(context).pop();
    }
    epubHighlightController.titleInputController.clear();
    epubHighlightController.descriptionInputController.clear();
    publicationDigitalController.highlightText.value = '';
  }
}
