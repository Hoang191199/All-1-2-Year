import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/domain/entities/color_background_setting_read.dart';
import 'package:qltv/domain/entities/font_family_setting_read.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/publication_digital_controller.dart';
import 'package:qltv/presentation/pages/publication_digital/widgets/custom_track_shape.dart';

final publicationDigitalController = Get.find<PublicationDigitalController>();

void showEpubSetting(BuildContext context, EpubController epubController, Function refeshPublicationEpub) {
  double widthScreen = MediaQuery.of(context).size.width;
  double heightScreen = MediaQuery.of(context).size.height;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: HexColor('E8EFF3'),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15.0),
      ),
    ),
    builder: (BuildContext context) {
      return SizedBox(
        width: widthScreen,
        height: heightScreen - 60.0,
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
              'reading-setting'.tr,
              style: GoogleFonts.kantumruy(
                textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: HexColor('333333'))
              ),
            ),
            const Divider(color: Colors.black12, thickness: 1.0),
            const SizedBox(height: 6.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15.0))
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              'font-f-change'.tr,
                              style: GoogleFonts.kantumruy(
                                textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: HexColor('333333'))
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 12.0),
                        SizedBox(
                          width: widthScreen - 28.0 - 28.0,
                          height: 100.0,
                          child: DraggableScrollableSheet(
                            initialChildSize: 1,
                            maxChildSize: 1,
                            builder: (context, scrollController) {
                              return ListView.separated(
                                // controller: scrollController,
                                physics: const ClampingScrollPhysics(),
                                padding: const EdgeInsets.all(0.0),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                separatorBuilder: (context, index) => const SizedBox(width: 10.0),
                                itemCount: publicationDigitalController.listFontFamily.length,
                                itemBuilder: (context, index) {
                                  final fontFamily = publicationDigitalController.listFontFamily[index];
                                  return GestureDetector(
                                    onTap: () {
                                      handlePressFontFamily(fontFamily, epubController);
                                    },
                                    child: Obx(
                                      () => Container(
                                        padding: const EdgeInsets.all(12.0),
                                        width: 120.0,
                                        decoration: BoxDecoration(
                                          color: publicationDigitalController.fontFamilySetting.value.code == fontFamily.code 
                                            ? HexColor('D9E9F2') 
                                            : Colors.transparent,
                                          borderRadius: const BorderRadius.all(Radius.circular(15.0))
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Aa', 
                                              style: TextStyle(fontFamily: fontFamily.value, fontSize: 32.0, height: 1.6, fontWeight: FontWeight.w400, color: HexColor('333333'))
                                            ),
                                            Text(
                                              fontFamily.name, 
                                              style: TextStyle(fontFamily: fontFamily.value, fontSize: 14.0, height: 1.4, fontWeight: FontWeight.w400, color: HexColor('333333'))
                                            ),
                                          ],
                                        ),
                                      )
                                    ),
                                  );
                                }, 
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15.0))
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'font-s'.tr,
                              style: GoogleFonts.kantumruy(
                                textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: HexColor('333333'))
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          height: 20.0,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              sliderTheme: SliderThemeData(
                                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
                                trackHeight: 4.0,
                                trackShape: CustomTrackShape()
                              )
                            ), 
                            child: Obx(
                              () => Slider(
                                min: 0.8,
                                max: 1.5,
                                label: publicationDigitalController.fontSizeMultiplier.value.toString(),
                                divisions: 7,
                                value: publicationDigitalController.fontSizeMultiplier.value,
                                activeColor: AppColors.primaryBlue,
                                inactiveColor: HexColor('DFD9D9'),
                                onChanged: (value) {
                                  publicationDigitalController.fontSizeMultiplier.value = value;
                                },
                                onChangeEnd: (value) {
                                  handleChangeEndFontSize(value, epubController);
                                }
                              )
                            )
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '0.8', 
                              style: GoogleFonts.kantumruy(
                                textStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: HexColor('333333'))
                              )
                            ),
                            Text(
                              '1.5',
                              style: GoogleFonts.kantumruy(
                                textStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: HexColor('333333'))
                              )
                            )
                          ]
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15.0))
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'bg-color'.tr,
                              style: GoogleFonts.kantumruy(
                                textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: HexColor('333333'))
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 12.0),
                        SizedBox(
                          width: widthScreen - 28.0 - 28.0,
                          height: 50.0,
                          child: DraggableScrollableSheet(
                            initialChildSize: 1,
                            maxChildSize: 1,
                            builder: (context, scrollController) {
                              return ListView.separated(
                                // controller: scrollController,
                                physics: const ClampingScrollPhysics(),
                                padding: const EdgeInsets.all(0.0),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                separatorBuilder: (context, index) => const SizedBox(width: 20.0),
                                itemCount: publicationDigitalController.listColorBackground.length,
                                itemBuilder: (context, index) {
                                  final colorBackground = publicationDigitalController.listColorBackground[index];
                                  return GestureDetector(
                                    onTap: () {
                                      handlePressColorBackground(colorBackground, epubController);
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
                                          decoration: BoxDecoration(
                                            image: colorBackground.background == 'default'
                                              ? const DecorationImage(
                                                image: AssetImage("assets/images/background.png"),
                                                fit: BoxFit.cover,
                                              )
                                              : null,
                                            color: colorBackground.background != 'default'
                                              ? HexColor(colorBackground.background)
                                              : Colors.transparent,
                                            border: Border.all(color: HexColor('D9E9F2')),
                                            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                                          child: Center(
                                            child: SizedBox(
                                              width: 8.0,
                                              child: Text(
                                                'A',
                                                style: GoogleFonts.kantumruy(
                                                  textStyle: TextStyle(
                                                    fontSize: 14.0,
                                                    height: 1.4,
                                                    fontWeight: FontWeight.w400,
                                                    color: colorBackground.color == 'initial'
                                                      ? HexColor('343232')
                                                      : HexColor(colorBackground.color.substring(1))
                                                  )
                                                )
                                              ),
                                            ),
                                          ),
                                        ),
                                        Obx(
                                          () => publicationDigitalController.colorBackgroundSetting.value.id == colorBackground.id
                                            ? const Positioned(
                                              top: 0.0,
                                              right: 0.0,
                                              child: Icon(CupertinoIcons.check_mark_circled_solid, size: 14.0, color: Colors.green)
                                            )
                                            : Container()
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        )
                      ],
                    )
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
  ).then((value) {
    epubController.bookController!.updateStyle();
    if (publicationDigitalController.isReLoadingStyle.value) {
      handleReload(epubController, refeshPublicationEpub);
      publicationDigitalController.isReLoadingStyle.value = false;
    }
  });
}

void handleChangeEndFontSize(double value, EpubController epubController) {
  publicationDigitalController.isReLoadingStyle.value = true;
  publicationDigitalController.fontSizeMultiplier.value = value;
  epubController.bookController?.style.fontSizeMultiplier = value;
}

void handlePressFontFamily(FontFamilySettingRead fontFamily, EpubController epubController) {
  publicationDigitalController.isReLoadingStyle.value = true;
  publicationDigitalController.fontFamilySetting.value = fontFamily;
  epubController.bookController?.style.fontFamily = fontFamily.value;
}

void handleReload(EpubController epubController, Function refeshPublicationEpub) {
  publicationDigitalController.checkWordsPerPage();
  refeshPublicationEpub();
  publicationDigitalController.totalPage.value = publicationDigitalController.getTotalPages(epubController);
  publicationDigitalController.pageProgress.value = ((publicationDigitalController.readPercent.value / 100) * publicationDigitalController.totalPage.value).round();
  epubController.bookController?.setLocation(
    epubController.bookController!.currentController.location,
    forced: true,
  );
}

void handlePressColorBackground(ColorBackgroundSettingRead colorBackground, EpubController epubController) {
  publicationDigitalController.colorBackgroundSetting.value = colorBackground;
  epubController.bookController?.style.backgroundColor = colorBackground.background;
  epubController.bookController?.style.color = colorBackground.color;
}
