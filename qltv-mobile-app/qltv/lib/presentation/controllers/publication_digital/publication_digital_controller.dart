import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/domain/entities/bookcase.dart';
import 'package:qltv/domain/entities/color_background_setting_read.dart';
import 'package:qltv/domain/entities/epub/epub_book.dart';
import 'package:qltv/domain/entities/epub/epub_chapter_item.dart';
import 'package:qltv/domain/entities/epub/epub_inner_node.dart';
import 'package:qltv/domain/entities/epub/epub_location.dart';
import 'package:qltv/domain/entities/epub/epub_search_result.dart';
import 'package:qltv/domain/entities/epub/saved_note_range_data.dart';
import 'package:qltv/domain/entities/font_family_setting_read.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_handle.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_progress_binding.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_progress_controller.dart';
import 'package:qltv/presentation/pages/publication_digital/widgets/dialog_read_timer.dart';

class PublicationDigitalController extends GetxController {
  
  final isLoading = false.obs;
  final tapOptionIndex = 0.obs;
  final readPercent = 0.obs;
  final pageProgress = 0.obs;
  final totalPage = 0.obs;
  final isLoadingSearch = false.obs;
  final isShowOptionBar = true.obs;
  final isDragSlideHandling = false.obs;
  final allowUpdateProgress = true.obs;
  final pageProgressTemp = 0.obs;
  final isShowOptionHighlight = false.obs;

  final highlightText = ''.obs;
  var selectionRect = Rx<Rectangle?>(null);
  var highlightedRanges = RxList<SavedNoteRangeData>([]);

  final isPressItemOptionHighlight = false.obs;
  final typePressItemOptionHighlight = ''.obs;

  var timerCountdown = 0;
  final handleFlutterTTS = ''.obs;
  var indexCurrentTextAudio = 0;
  var contentTTSStr = '';
  var contentTTSArr = [];
  final wordsPerPage = 220.obs;
  final isOpenSearch = false.obs;
  late Timer timerRead;

  late FlutterTts flutterTts;

  late TextEditingController searchInputController;
  var searchData = RxList<EpubSearchResult>([]);

  var fontFamilySetting = Rx<FontFamilySettingRead>(FontFamilySettingRead(name: 'PTSerif', value: 'PTSerif', code: 'pt_serif'));
  var colorBackgroundSetting = Rx<ColorBackgroundSettingRead>(ColorBackgroundSettingRead(id: 1, color: '343232', background: 'default'));
  final fontSizeMultiplier = 1.0.obs;
  final isReLoadingStyle = false.obs;

  List<FontFamilySettingRead> listFontFamily = [
    FontFamilySettingRead(name: 'PTSerif', value: 'PTSerif', code: 'pt_serif'),
    FontFamilySettingRead(name: 'Literata', value: 'Literata', code: 'literata'),
    FontFamilySettingRead(name: 'Merriweather', value: 'Merriweather', code: 'merri_weather'),
    FontFamilySettingRead(name: 'RobotoMono', value: 'RobotoMono', code: 'roboto_mono'),
  ];

  List<ColorBackgroundSettingRead> listColorBackground = [
    ColorBackgroundSettingRead(id: 1, color: 'initial', background: 'default'),
    ColorBackgroundSettingRead(id: 2, color: '#333333', background: '#FFFDFD'),
    ColorBackgroundSettingRead(id: 3, color: '#333333', background: '#FEF8E1'),
    ColorBackgroundSettingRead(id: 4, color: '#E8EFF3', background: '#333333'),
  ];

  initialController(Bookcase bookcase, EpubController epubController) {
    const readTimer = 120;
    isLoading.value = true;
    isShowOptionBar.value = true;
    isShowOptionHighlight.value = false;
    isDragSlideHandling.value = false;
    allowUpdateProgress.value = true;
    searchInputController = TextEditingController(text: '');
    tapOptionIndex.value = 0;
    handleFlutterTTS.value = '';
    indexCurrentTextAudio = 0;
    timerCountdown = readTimer;
    fontFamilySetting.value = listFontFamily.firstWhere((element) => element.code == (bookcase.progress?.font_family ?? 'pt_serif'));
    colorBackgroundSetting.value = ColorBackgroundSettingRead(id: 1, color: '343232', background: 'default');
    fontSizeMultiplier.value = bookcase.progress?.font_size_multiplier ?? 1.0;
    if (bookcase.progress?.words_per_page != null) {
      wordsPerPage.value = bookcase.progress?.words_per_page ?? 220;
    } else {
      checkWordsPerPage();
    }

    totalPage.value = getTotalPages(epubController);
    readPercent.value = bookcase.progress == null ? 0 : (bookcase.progress?.progress ?? 0);
    pageProgress.value = ((readPercent.value / 100) * totalPage.value).round();

    isLoading.value = false;

    initialFlutterTTS();
    initialReadTimer(readTimer);
  }

  checkWordsPerPage() {
    if (['pt_serif', 'literata', 'merri_weather'].contains(fontFamilySetting.value.code)) {
      if (fontSizeMultiplier.value <= 0.9) {
        wordsPerPage.value = 225;
      } else if (fontSizeMultiplier.value == 1.0) {
        wordsPerPage.value = 220;
      } else if (fontSizeMultiplier.value == 1.1) {
        wordsPerPage.value = 215;
      } else if (fontSizeMultiplier.value == 1.2) {
        wordsPerPage.value = 210;
      } else if (fontSizeMultiplier.value == 1.3) {
        wordsPerPage.value = 205;
      } else if (fontSizeMultiplier.value == 1.4) {
        wordsPerPage.value = 200;
      } else if (fontSizeMultiplier.value == 1.5) {
        wordsPerPage.value = 195;
      }
    } else {
      if (fontSizeMultiplier.value == 0.8) {
        wordsPerPage.value = 170;
      } else if (fontSizeMultiplier.value == 0.9) {
        wordsPerPage.value = 160;
      } else if (fontSizeMultiplier.value == 1.0) {
        wordsPerPage.value = 150;
      } else if (fontSizeMultiplier.value == 1.1) {
        wordsPerPage.value = 140;
      } else if (fontSizeMultiplier.value == 1.2) {
        wordsPerPage.value = 130;
      } else if (fontSizeMultiplier.value == 1.3) {
        wordsPerPage.value = 120;
      } else if (fontSizeMultiplier.value == 1.4) {
        wordsPerPage.value = 110;
      } else if (fontSizeMultiplier.value == 1.5) {
        wordsPerPage.value = 100;
      }
    }
  }

  initialFlutterTTS() async {
    flutterTts = FlutterTts();

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await flutterTts.setSharedInstance(true);

      await flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.playback,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers
        ],
        IosTextToSpeechAudioMode.voicePrompt
      );
    }
  }

  initialReadTimer(int time) {
    timerRead = Timer.periodic(const Duration(seconds: 1), (timer) {
      timerCountdown--;
      if (timerCountdown == 0) {
        timer.cancel();
        Get.dialog(DialogReadTimer(readTimer: time));
      }
    });
  }

  Future<void> resetDataController() async {
    searchInputController.clear();
    totalPage.value = 0;
    pageProgress.value = 0;
    readPercent.value = 0;
    timerRead.cancel();
    tapOptionIndex.value = 0;
    await flutterTts.stop();
    handleFlutterTTS.value = HandleAudio.stop;
  }

  int getTotalPages(EpubController epubController) {
    return ((epubController.epubBook?.wordsPerSpineItem ?? []).reduce((value, element) => element + value) / wordsPerPage.value).round();
  }

  int getBookPageProgress(EpubController epubController) {
    return isFinished(epubController)
      ? totalPage.value
      : (currentEstimatedWordsRead(epubController) / wordsPerPage.value).round();
  }

  bool isFinished(EpubController epubController) {
    return (epubController.epubBook?.consistentLocation?.page ?? 0) >= ((epubController.epubBook?.wordsPerSpineItem?.length ?? 0) - 1) && ((epubController.epubBook?.progressSpine ?? 0.0) >= 1);
  }

  double currentEstimatedWordsRead(EpubController epubController) {
    if (isFinished(epubController)) {
      return (epubController.epubBook?.wordsPerSpineItem ?? []).reduce((value, element) => element + value).toDouble();
    }

    final readSpineItems = (epubController.epubBook?.wordsPerSpineItem ?? []).take(epubController.epubBook?.consistentLocation?.page ?? 0);
    return (readSpineItems.isNotEmpty 
      ? readSpineItems.reduce((value, element) => value + element)
      : 0) + (epubController.epubBook?.wordsPerSpineItem ?? [])[epubController.epubBook?.consistentLocation?.page ?? 0] * (epubController.epubBook?.progressSpine ?? 0.0);
  }

  double readProgress(EpubController epubController) {
    return isFinished(epubController)
      ? 1
      : (currentEstimatedWordsRead(epubController) / (epubController.epubBook?.wordsPerSpineItem ?? []).reduce((value, element) => element + value));
  }

  changeTapOptionIndex(int indexTap) async {
    tapOptionIndex.value = indexTap;
  }

  changeEpubChapterItem(EpubController epubController, EpubChapterItem chapter) {
    epubController.bookController?.setLocation(chapter.location);
  }

  changeEpubPage(EpubController epubController) {
    pageProgress.value = getBookPageProgress(epubController);
    readPercent.value = (readProgress(epubController) * 100).floor();
  }

  searchInEpub(EpubController epubController) {
    isLoadingSearch.value = true;
    final searchStr = searchInputController.text;
    if (searchStr.isNotEmpty) {
      final data = epubController.getListEpubSearchResult(searchStr);
      searchData.assignAll(data);
    } else {
      searchData.value = [];
    }
    isLoadingSearch.value = false;
  }

  startEpubAudio(EpubController epubController) async {
    await flutterTts.stop();

    await flutterTts.setLanguage(epubController.epubBook?.language ?? 'vi');

    final location = epubController.bookController!.currentController.location;
    final filesFromEpubSpine = getFilesFromEpubSpine(epubController.epubBook ?? EpubBook());

    final document = parse(filesFromEpubSpine[location.page].content);
    var contentChapterStr = document.body!.text;
    // if (contentChapterStr.trim().isEmpty) {
    //   contentChapterStr = parse(filesFromEpubSpine[location.page + 1].content).body!.text;
    // }

    final consistentLocation = epubController.epubBook?.consistentLocation;
    if (consistentLocation?.innerNav is EpubInnerNode) {
      final innerNav = consistentLocation?.innerNav as EpubInnerNode;
      final documentElement = document.getElementsByTagName("html").first;

      final allDocumentNodes = epubController.nodesUnder(documentElement, nodeType: -1, leaveHoles: false);
      final currentNode = allDocumentNodes[innerNav.nodeIndex + 3];
      final indexTextContent = contentChapterStr.indexOf(currentNode?.text ?? '');
      contentTTSStr = contentChapterStr.substring(indexTextContent).substring(innerNav.characterIndex);
      contentTTSArr = contentTTSStr.split('.');
    } else {
      contentTTSArr = contentChapterStr.split('.');
    }

    indexCurrentTextAudio = 0;

    handleFlutterTTS.value = HandleAudio.playing;

    await flutterTts.speak(contentTTSArr[indexCurrentTextAudio]);
    flutterTts.setCompletionHandler(() async {
      if (handleFlutterTTS.value != HandleAudio.stop) {
        indexCurrentTextAudio++;
        if (indexCurrentTextAudio < contentTTSArr.length) {
          await flutterTts.speak(contentTTSArr[indexCurrentTextAudio]);
        } else {
          await flutterTts.stop();
          handleFlutterTTS.value = HandleAudio.stop;
        }
      }
    });
  }

  playEpubAudio(EpubController epubController) async {
    handleFlutterTTS.value = HandleAudio.playing;
    await flutterTts.speak(contentTTSArr[indexCurrentTextAudio]);
  }

  pauseEpubAudio() async {
    await flutterTts.pause();
    handleFlutterTTS.value = HandleAudio.pause;
  }

  stopEpubAudio() async {
    await flutterTts.stop();
    handleFlutterTTS.value = HandleAudio.stop;
    indexCurrentTextAudio = 0;
  }

  sentProgressRead(EpubController epubController, int itemId) {
    EpubProgressBinding().dependencies();
    final epubProgressController = Get.find<EpubProgressController>();
    final progress = readPercent.value;
    final chapter = linkSpineFileToChapter(
      epubController.epubBook ?? EpubBook(),
      epubController.bookController!.currentController.location.page,
      getFilesFromEpubSpine(epubController.epubBook ?? EpubBook()),
      null
    )?.title ?? '';
    final location = epubController.bookController!.currentController.location;
    final page = location.page;
    final innerPage = location.innerNav.page;
    epubProgressController.sentProgressRead(itemId, progress, chapter, wordsPerPage.value, fontFamilySetting.value.code, fontSizeMultiplier.value, page, innerPage);
  }

  reloadCurrentPage(EpubController epubController, EpubLocation epubLocation) {
    epubController.bookController?.setLocation(epubLocation, forced: true);
  }
}
