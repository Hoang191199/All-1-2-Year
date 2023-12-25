import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/domain/entities/bookcase.dart';
import 'package:qltv/domain/entities/epub/epub_book.dart';
import 'package:qltv/domain/entities/epub/epub_inner_page.dart';
import 'package:qltv/domain/entities/epub/epub_location.dart';
import 'package:qltv/domain/entities/epub/epub_margin.dart';
import 'package:qltv/domain/entities/epub/epub_style_properties.dart';
import 'package:qltv/domain/entities/epub/epub_style_themes.dart';
import 'package:qltv/domain/entities/epub/saved_note.dart';
import 'package:qltv/presentation/controllers/bookcase/bookcase_binding.dart';
import 'package:qltv/presentation/controllers/bookcase/bookcase_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_bookmark_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_handle.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_highlight_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/publication_digital_controller.dart';
import 'package:qltv/presentation/pages/publication_digital/widgets/dialog_audio_tts.dart';
import 'package:qltv/presentation/pages/publication_digital/widgets/epub_highlight_note.dart';
import 'package:qltv/presentation/pages/publication_digital/widgets/epub_player_render.dart';
import 'package:qltv/presentation/pages/publication_digital/widgets/epub_progress_bottom.dart';
import 'package:qltv/presentation/pages/publication_digital/widgets/epub_search.dart';
import 'package:qltv/presentation/pages/publication_digital/widgets/epub_setting.dart';
import 'package:qltv/presentation/pages/publication_digital/widgets/left_option.dart';
import 'package:qltv/presentation/widgets/circular_loading_indicator.dart';

class PublicationEpub extends StatefulWidget {
  PublicationEpub({
    super.key,
    required this.bookcase,
  });

  final Bookcase? bookcase;

  final publicationDigitalController = Get.find<PublicationDigitalController>();
  final epubBookmarkController = Get.find<EpubBookmarkController>();
  final epubHighlightController = Get.find<EpubHighlightController>();

  @override
  State<PublicationEpub> createState() => _PublicationEpubState();
}

class _PublicationEpubState extends State<PublicationEpub> {
  late EpubController epubController;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    if (widget.bookcase?.metadata?.epub_file_path?.isNotEmpty ?? false) {
      epubController = EpubController(widget.bookcase?.metadata?.epub_file_path ?? '', widget.bookcase?.progress);
    } else {
      epubController = EpubController(widget.bookcase?.metadata?.file_path ?? '', widget.bookcase?.progress);
    }
    await epubController.initialize();
    await widget.epubBookmarkController.getListBookmarks(widget.bookcase?.id ?? 0);
    await widget.epubHighlightController.getListHighlight(widget.bookcase?.id ?? 0);
    widget.publicationDigitalController.initialController(widget.bookcase!, epubController);
    setState(() {});
  }

  @override
  void dispose() {
    epubController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (epubController.epubBook == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: const Center(
            child: CircularLoadingIndicator(),
          ),
        ),
      );
    }

    double widthScreen = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Container(
          padding: EdgeInsets.only(top: statusBarHeight, bottom: bottomPadding + 20.0),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 25.0),
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      handlePressBack();
                                    },
                                    icon: Icon(CupertinoIcons.back, color: HexColor('7B858B')),
                                    iconSize: 24.0,
                                  ),
                                  Obx(
                                    () => widget.publicationDigitalController.isShowOptionBar.value && !widget.publicationDigitalController.isLoading.value
                                      ? IconButton(
                                          onPressed: () {
                                            handlePressLeftOption(context);
                                          },
                                          icon: Icon(CupertinoIcons.list_bullet, color: HexColor('7B858B')))
                                      : Container()
                                  ),
                                ],
                              ),
                              Obx(
                                () => widget.publicationDigitalController.isShowOptionBar.value && !widget.publicationDigitalController.isLoading.value
                                  ? Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          handlePressHeadPhone();
                                        },
                                        icon: Obx(
                                          () => [HandleAudio.playing, HandleAudio.pause].contains(widget.publicationDigitalController.handleFlutterTTS.value)
                                            ? Icon(CupertinoIcons.headphones, color: HexColor('F1B821'))
                                            : Icon(CupertinoIcons.headphones, color: HexColor('7B858B'))
                                        )
                                      ),
                                      IconButton(
                                        onPressed: widget.epubBookmarkController.isLoadingAdd.value
                                          ? null
                                          : () {
                                            handlePressBookmark();
                                          },
                                        icon: Obx(
                                          () => widget.epubBookmarkController.isPageBookmark.value
                                            ? Icon(CupertinoIcons.bookmark_fill, color: HexColor('F1B821'))
                                            : Icon(CupertinoIcons.bookmark, color: HexColor('7B858B'))
                                        )
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          handlePressSearch(context);
                                        },
                                        icon: Obx(
                                          () => widget.publicationDigitalController.isOpenSearch.value
                                            ? Icon(CupertinoIcons.search, color: HexColor('F1B821'))
                                            : Icon(CupertinoIcons.search, color: HexColor('7B858B'))
                                        )
                                      ),
                                      Transform.rotate(
                                        angle: 90 * pi / 180,
                                        child: IconButton(
                                          onPressed: () {
                                            handlePressSetting(context);
                                          },
                                          icon: Icon(Icons.settings_outlined, color: HexColor('7B858B'))
                                        ),
                                      )
                                    ],
                                  )
                                  : Container()
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: EpubPlayerRender(
                            bookcase: widget.bookcase,
                            epubController: epubController,
                            controllerCreated: (controller) {
                              epubController.bookController = controller;
                            },
                            initialStyle: EpubStyleProperties(
                              margin: EpubMargin(side: 28.0, top: 0.0, bottom: 0.0),
                              fontSizeMultiplier: widget.publicationDigitalController.fontSizeMultiplier.value,
                              lineHeightMultiplier: 1.2,
                              weightMultiplier: 1,
                              letterSpacingAdder: 0,
                              wordSpacingAdder: 0,
                              align: 'start',
                              fontFamily: widget.publicationDigitalController.fontFamilySetting.value.value, // 'Default'
                              fontPath: '',
                              theme: EpubStyleThemes.light,
                              backgroundColor: widget.publicationDigitalController.colorBackgroundSetting.value.background,
                              color: widget.publicationDigitalController.colorBackgroundSetting.value.color,
                            ),
                            initialLocation: EpubLocation(
                              widget.bookcase?.progress?.page ?? 0,
                              EpubInnerPage(widget.bookcase?.progress?.inner_page ?? 0)
                            ),
                            savedNotes: widget.epubHighlightController.savedNotes,
                            onNotePressed: (savedNote) async {
                              handlePressSavedNote(savedNote);
                            },
                            onSaveLocation: onSaveLocation,
                            onSelection: (selection) {
                              if (selection.text.isNotEmpty) {
                                if (selection.rect.left < 0) {
                                  epubController.bookController?.clearSelection();
                                } else {
                                  widget.publicationDigitalController.highlightText.value = selection.text;
                                  widget.publicationDigitalController.selectionRect.value = selection.rect;
                                  widget.publicationDigitalController.highlightedRanges.value = selection.rangesData;

                                  widget.publicationDigitalController.isShowOptionHighlight.value = true;
                                }
                              } else {
                                widget.publicationDigitalController.highlightText.value = '';
                                widget.publicationDigitalController.isShowOptionHighlight.value = false;
                              }
                              // if (defaultTargetPlatform == TargetPlatform.iOS) {
                              //   widget.publicationDigitalController.isShowOptionBar.value = !widget.publicationDigitalController.isShowOptionBar.value;
                              // }
                            },
                          )
                        )
                      ],
                    ),
                    Obx(
                      () => widget.publicationDigitalController.isShowOptionHighlight.value
                        ? Positioned(
                          top: ((widget.publicationDigitalController.selectionRect.value?.top ?? 0) + 25.0 + 40.0 + 10.0 - 14.0).toDouble(),
                          left: (
                            (widget.publicationDigitalController.selectionRect.value?.left ?? 0) 
                            + ((widget.publicationDigitalController.selectionRect.value?.width ?? 0) < 14.0 && (widget.publicationDigitalController.selectionRect.value?.left ?? 0) <= 28.0
                              ? 0
                              : ((widget.publicationDigitalController.selectionRect.value?.width ?? 0) / 2) - 7.0)
                          ).toDouble(),
                          child: Transform.rotate(
                            angle: 180 * pi / 180,
                            child: Icon(CupertinoIcons.triangle_fill, size: 14.0, color: AppColors.primaryBlue),
                          )
                        )
                        : Container()),
                    Obx(
                      () => widget.publicationDigitalController.isShowOptionHighlight.value
                        ? Positioned(
                          top: ((widget.publicationDigitalController.selectionRect.value?.top ?? 0) + 25.0 + 40.0 + 10.0 - 60.0).toDouble(),
                          width: widthScreen,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 28.0),
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue,
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(8.0),
                                topRight: const Radius.circular(8.0),
                                bottomLeft: (widget.publicationDigitalController.selectionRect.value?.width ?? 0) < 14.0 && (widget.publicationDigitalController.selectionRect.value?.left ?? 0) <= 28.0
                                  ? const Radius.circular(4.0)
                                  : const Radius.circular(8.0),
                                bottomRight: (widget.publicationDigitalController.selectionRect.value?.width ?? 0) < 14.0 && ((widget.publicationDigitalController.selectionRect.value?.left ?? 0) > 28.0)
                                  ? const Radius.circular(4.0)
                                  : const Radius.circular(8.0),
                              ),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: widthScreen - 28.0 - 28.0 - 10.0 - 10.0
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    itemOptionBottom('Sao chép', 'copy'),
                                    itemOptionBottom('Highlight', 'highlight'),
                                    itemOptionBottom('Ghi chú', 'note'),
                                    itemOptionBottom('Hủy', 'cancel'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        : Container()
                      )
                    ],
                  )
              ),
              Container(
                margin: const EdgeInsets.only(top: 22.0),
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: EpubProgressBottom(epubController: epubController),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemOptionBottom(String text, String type) {
    return GestureDetector(
      onTap: widget.publicationDigitalController.isPressItemOptionHighlight.value
        ? null
        : () {
          handlePressItemOptionBottom(type);
        },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: (widget.publicationDigitalController.isPressItemOptionHighlight.value && widget.publicationDigitalController.typePressItemOptionHighlight.value == type) 
            ? Colors.blue[600]
            : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          text, 
          style: GoogleFonts.kantumruy(
            textStyle: const TextStyle(fontSize: 14.0, height: 1.4, fontWeight: FontWeight.w400, color: Colors.white)
          )
        )
      ),
    );
  }

  Future<void> handlePressItemOptionBottom(String type) async {
    widget.publicationDigitalController.isPressItemOptionHighlight.value = true;
    widget.publicationDigitalController.typePressItemOptionHighlight.value = type;
    await Future.delayed(const Duration(milliseconds: 100), () async {
      switch (type) {
        case 'copy':
          Clipboard.setData(ClipboardData(text: widget.publicationDigitalController.highlightText.value));
          break;
        case 'highlight':
          epubController.bookController?.clearSelection();
          final itemId = widget.bookcase?.id ?? 0;
          const title = '';
          final highlightText = widget.publicationDigitalController.highlightText.value.trim();
          const description = '';
          const color = 'blue';
          final location = epubController.bookController!.currentController.location;
          final page = location.page;
          final highlightedRanges = widget.publicationDigitalController.highlightedRanges;
          await widget.epubHighlightController.addHighlight(itemId, title, highlightText, description, color, page, highlightedRanges[0].startNodeIndex, highlightedRanges[0].endNodeIndex, highlightedRanges[0].startOffset, highlightedRanges[0].endOffset);
          if (!(widget.epubHighlightController.responseAddEdit.value?.error ?? false)) {
            await widget.epubHighlightController.getListHighlight(itemId);
            if (!widget.epubHighlightController.isLoading.value) {
              epubController.bookController?.setLocation(
                epubController.bookController!.currentController.location,
                forced: true,
              );
            }
            widget.publicationDigitalController.highlightText.value = '';
          }
          break;
        case 'note':
          epubController.bookController?.clearSelection();
          widget.epubHighlightController.titleInputController.clear();
          widget.epubHighlightController.descriptionInputController.clear();
          showEpubHighlightNote(context, 'add', widget.bookcase?.id ?? 0, epubController, null);
          break;
        case 'cancel':
          epubController.bookController?.clearSelection();
          break;
        default:
          break;
      }
    });
    widget.publicationDigitalController.isPressItemOptionHighlight.value = false;
  }

  Future<void> handlePressBack() async {
    // Get.delete<PublicationDigitalController>();
    Get.back();

    await widget.publicationDigitalController.resetDataController();

    BookcaseBinding().dependencies();
    final bookcaseController = Get.find<BookcaseController>();
    await bookcaseController.fetchData();
    await bookcaseController.fetchDataLastseen();
  }

  Future<void> handlePressLeftOption(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return LeftOption(
          itemId: widget.bookcase?.id ?? 0,
          title: widget.bookcase?.title ?? '',
          epubController: epubController
        );
      }
    );
  }

  void onSaveLocation(consistentLocation) {
    final innerPages = epubController.bookController?.currentController.innerPages ?? 0;

    final location = epubController.bookController!.currentController.location;
    epubController.epubBook?.progressSpine = location.page >= getFilesFromEpubSpine(epubController.epubBook ?? EpubBook()).length - 1 && location.innerNav.page >= innerPages - 1
      ? 1
      : location.innerNav.page / innerPages;

    epubController.epubBook?.consistentLocation = consistentLocation;
    widget.publicationDigitalController.changeEpubPage(epubController);
  }

  void handlePressHeadPhone() {
    if ([HandleAudio.playing, HandleAudio.pause].contains(widget.publicationDigitalController.handleFlutterTTS.value)) {
      Get.dialog(DialofAudioTTS(epubController: epubController));
    } else {
      widget.publicationDigitalController.startEpubAudio(epubController);
    }
  }

  Future<void> handlePressBookmark() async {
    if (!widget.epubBookmarkController.isPageBookmark.value) {
      final location = epubController.bookController!.currentController.location;
      await widget.epubBookmarkController.addBookmark(widget.bookcase?.id ?? 0, location.page, location.innerNav.page, epubController);
      if (!(widget.epubBookmarkController.responseAdd.value?.error ?? false)) {
        widget.epubBookmarkController.isPageBookmark.value = true;
        await widget.epubBookmarkController.getListBookmarks(widget.bookcase?.id ?? 0);
      }
    }
  }

  void handlePressSearch(BuildContext context) {
    widget.publicationDigitalController.isOpenSearch.value = true;
    showEpubSearch(context, epubController);
  }

  void handlePressSetting(BuildContext context) {
    showEpubSetting(context, epubController, refeshPublicationEpub);
  }

  void handlePressSavedNote(SavedNote savedNote) {
    final highlight = widget.epubHighlightController.highlightsData.firstWhere((data) => data?.id == savedNote.id);
    widget.publicationDigitalController.highlightText.value = highlight?.metadata?.highlightText ?? '';
    widget.epubHighlightController.titleInputController.text = highlight?.metadata?.title ?? '';
    widget.epubHighlightController.descriptionInputController.text = highlight?.metadata?.description ?? '';
    showEpubHighlightNote(context, 'view', highlight?.item_id ?? 0, epubController, highlight);
  }

  void refeshPublicationEpub() {
    setState(() {});
  }
}
