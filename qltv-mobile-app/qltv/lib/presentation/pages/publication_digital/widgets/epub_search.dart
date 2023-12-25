import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/domain/entities/epub/epub_book.dart';
import 'package:qltv/domain/entities/epub/epub_chapter.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_handle.dart';
import 'package:qltv/presentation/controllers/publication_digital/publication_digital_controller.dart';
import 'package:qltv/presentation/widgets/circular_loading_indicator.dart';
import 'package:qltv/presentation/widgets/search_no_data.dart';

void showEpubSearch(BuildContext context, EpubController epubController) {
  double heightScreen = MediaQuery.of(context).size.height;
  double statusBarHeight = MediaQuery.of(context).padding.top;

  final publicationDigitalController = Get.find<PublicationDigitalController>();
  
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15.0),
      ),
    ),
    backgroundColor: AppColors.background,
    builder: (BuildContext context) {
      return SizedBox(
        height: heightScreen - statusBarHeight - 25.0 - 40.0,
        child: Column(
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
              'search-inbook'.tr,
              style: GoogleFonts.kantumruy(
                textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: HexColor('343232'))
              ),
            ),
            const Divider(color: Colors.black12, thickness: 1.0),
            const SizedBox(height: 6.0),
            Container(
              height: 36.0,
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              margin: const EdgeInsets.only(bottom: 10.0),
              alignment: Alignment.topCenter,
              child: CupertinoSearchTextField(
                controller: publicationDigitalController.searchInputController,
                backgroundColor: HexColor('FFFDFD'),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                itemSize: 16.0,
                itemColor: HexColor('7B858B'),
                placeholder: 'input-search'.tr,
                style: GoogleFonts.kantumruy(
                  textStyle: TextStyle(fontSize: 14.0, height: 1.4, fontWeight: FontWeight.w400, color: HexColor('7B858B'), decorationThickness: 0.0)
                ),
                onSuffixTap: () {
                  publicationDigitalController.searchInputController.clear();
                  publicationDigitalController.searchInEpub(epubController);
                },
                onSubmitted: (value) async {
                  publicationDigitalController.searchInEpub(epubController);
                },
              ),
            ),
            publicationDigitalController.searchInputController.text.isEmpty
              ? Container()
              : Obx(() => publicationDigitalController.isLoadingSearch.value
                ? const Center(
                  child: CircularLoadingIndicator(),
                )
                : publicationDigitalController.searchData.isEmpty
                  ? const Expanded(child: SearchNoData())
                  : Expanded(
                    child: ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 28.0),
                      shrinkWrap: true,
                      itemCount: publicationDigitalController.searchData.length,
                      separatorBuilder: (context, index) => const Divider(color: Colors.black12, thickness: 1.0),
                      itemBuilder: (context, index) {
                        final data = publicationDigitalController.searchData[index];
                        final chapters = epubController.epubBook?.chapters;
                        final chapter = chapters?.firstWhere((element) => 
                          element.contentFileName == (getFilesFromEpubSpine(epubController.epubBook ?? EpubBook())[data.location.page].fileName ?? ''),
                          orElse: () => EpubChapter()).title;
                        return ListTile(
                          title: Text(chapter ?? ''),
                          subtitle: Text(data.nearbyText),
                          onTap: () {
                            epubController.bookController?.setLocation(data.location);
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    )
                  )
                )
          ],
        ),
      );
    },
  ).then((_) => publicationDigitalController.isOpenSearch.value = false);
}
