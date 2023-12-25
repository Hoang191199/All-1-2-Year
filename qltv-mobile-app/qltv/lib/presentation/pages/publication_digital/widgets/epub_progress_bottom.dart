import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/domain/entities/epub/epub_inner_page.dart';
import 'package:qltv/domain/entities/epub/epub_location.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/publication_digital_controller.dart';
import 'package:qltv/presentation/pages/publication_digital/widgets/custom_track_shape.dart';

class EpubProgressBottom extends StatelessWidget {
  EpubProgressBottom({
    super.key,
    required this.epubController,
  });

  final EpubController epubController;

  final publicationDigitalController = Get.find<PublicationDigitalController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 17.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    sliderTheme: SliderThemeData(
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
                      trackHeight: 4.0,
                      trackShape: CustomTrackShape()
                    )
                  ),
                  child: Obx(
                    () => publicationDigitalController.isDragSlideHandling.value
                      ? Slider(
                        min: 0,
                        max: publicationDigitalController.totalPage.value.toDouble(),
                        // divisions: publicationDigitalController.getTotalPages(epubController),
                        value: publicationDigitalController.pageProgressTemp.toDouble(),
                        activeColor: AppColors.primaryBlue,
                        inactiveColor: HexColor('DFD9D9'),
                        onChanged: (value) {},
                      )
                      : Slider(
                        min: 0,
                        max: publicationDigitalController.totalPage.value.toDouble(),
                        // divisions: publicationDigitalController.getTotalPages(epubController),
                        value: publicationDigitalController.pageProgress.toDouble(),
                        activeColor: AppColors.primaryBlue,
                        inactiveColor: HexColor('DFD9D9'),
                        onChanged: (value) {
                          final pageProgress = value.floor();
                          publicationDigitalController.pageProgress.value = pageProgress;
                          publicationDigitalController.pageProgressTemp.value = pageProgress;
                        },
                        onChangeEnd: (value) {
                          handleDragSlider(value);
                        }
                      )
                  )
                )
              ),
              SizedBox(
                width: 40.0,
                child: Obx(
                  () => Text(
                    '${publicationDigitalController.readPercent.value}%',
                    style: GoogleFonts.kantumruy(
                      textStyle: TextStyle(fontSize: 10.0, height: 1.7, fontWeight: FontWeight.w400, color: HexColor('7B858B'))
                    ),
                    textAlign: TextAlign.end
                  )
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        Obx(
          () => Text(
            publicationDigitalController.isDragSlideHandling.value
              ? '${publicationDigitalController.pageProgressTemp.value} / ${publicationDigitalController.totalPage.value} ${'page'.tr}'
              : '${publicationDigitalController.pageProgress.value} / ${publicationDigitalController.totalPage.value} ${'page'.tr}',
            style: GoogleFonts.kantumruy(
              textStyle: TextStyle(fontSize: 10.0, height: 1.7, fontWeight: FontWeight.w400, color: HexColor('7B858B'))
            ),
          )
        )
      ],
    );
  }

  Future<void> handleDragSlider(double value) async {
    publicationDigitalController.isDragSlideHandling.value = true;
    publicationDigitalController.allowUpdateProgress.value = false;
    final pageProgress = value.floor();
    publicationDigitalController.pageProgress.value = pageProgress;
    var page = 0;
    var currentEstimatedWordsRead = pageProgress * publicationDigitalController.wordsPerPage.value;
    final readSpineItems = (epubController.epubBook?.wordsPerSpineItem ?? []).reduce((value, element) => element + value);
    final wordsPerSpineItem = epubController.epubBook?.wordsPerSpineItem;
    if (currentEstimatedWordsRead >= readSpineItems) {
      page = (wordsPerSpineItem?.length ?? 0) - 1;
    } else {
      for (var i = 0; i < (wordsPerSpineItem?.length ?? 0); i++) {
        if (currentEstimatedWordsRead > (wordsPerSpineItem?[i] ?? 0)) {
          currentEstimatedWordsRead = currentEstimatedWordsRead - (wordsPerSpineItem?[i] ?? 0);
        } else {
          page = i;
          break;
        }
      }
    }
    EpubLocation<int, EpubInnerPage> consistentLocationTemp = EpubLocation(page, EpubInnerPage(0));
    epubController.bookController?.setLocation(consistentLocationTemp);
    var secondWait = 1;
    if ((wordsPerSpineItem?[page] ?? 0) <= 5000) {
      secondWait = 1;
    } else if (5000 < (wordsPerSpineItem?[page] ?? 0) && (wordsPerSpineItem?[page] ?? 0) <= 10000) {
      secondWait = 2;
    } else if (10000 < (wordsPerSpineItem?[page] ?? 0) && (wordsPerSpineItem?[page] ?? 0) <= 30000) {
      secondWait = 3;
    } else if (30000 < (wordsPerSpineItem?[page] ?? 0) && (wordsPerSpineItem?[page] ?? 0) <= 50000) {
      secondWait = 4;
    } else {
      secondWait = 5;
    }
    await Future.delayed(Duration(seconds: secondWait));
    final innerPages = epubController.bookController?.currentController.innerPages ?? 0;
    var innerPage = 0;
    if (value.floor() == publicationDigitalController.totalPage.value) {
      innerPage = innerPages - 1;
    } else {
      innerPage = (page == 0 && wordsPerSpineItem?[page] == 0) ? 0 : (currentEstimatedWordsRead / (wordsPerSpineItem?[page] ?? 0) * innerPages).round();
    }
    EpubLocation<int, EpubInnerPage> consistentLocation = EpubLocation(page, EpubInnerPage(innerPage));
    epubController.bookController?.setLocation(consistentLocation);
    publicationDigitalController.allowUpdateProgress.value = true;
    await Future.delayed(const Duration(seconds: 1));
    publicationDigitalController.isDragSlideHandling.value = false;
  }
}
