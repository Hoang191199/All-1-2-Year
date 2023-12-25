import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:qltv/domain/entities/bookcase.dart';
import 'package:qltv/domain/entities/epub/epub_consistent_inner_navigation.dart';
import 'package:qltv/domain/entities/epub/epub_inner_anchor.dart';
import 'package:qltv/domain/entities/epub/epub_inner_element.dart';
import 'package:qltv/domain/entities/epub/epub_inner_navigation.dart';
import 'package:qltv/domain/entities/epub/epub_inner_node.dart';
import 'package:qltv/domain/entities/epub/epub_inner_page.dart';
import 'package:qltv/domain/entities/epub/epub_inner_text_node.dart';
import 'package:qltv/domain/entities/epub/epub_location.dart';
import 'package:qltv/domain/entities/epub/epub_selection_data.dart';
import 'package:qltv/domain/entities/epub/epub_style_properties.dart';
import 'package:qltv/domain/entities/epub/saved_note.dart';
import 'package:qltv/domain/entities/epub/saved_note_range_data.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_render_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/publication_digital_controller.dart';
import 'package:qltv/presentation/widgets/circular_loading_indicator.dart';

class EpubRender extends StatefulWidget {
  EpubRender({
    super.key,
    required this.id,
    required this.maxPages,
    required this.onLoaded,
    required this.onReadyChanged,
    required this.onNotePressed,
    required this.onLinkPressed,
    required this.getPageFile,
    required this.onSelection,
    required this.epubController,
    required this.bookcase,
  });

  final int id;
  final int maxPages;
  final void Function(EpubRenderController) onLoaded;
  final void Function(bool isReady) onReadyChanged;
  final void Function(String) onNotePressed;
  final void Function(String) onLinkPressed;
  final String Function(int) getPageFile;
  final void Function(EpubSelectionData selection) onSelection;
  final EpubController epubController;
  final Bookcase? bookcase;

  final publicationDigitalController = Get.find<PublicationDigitalController>();

  @override
  State<EpubRender> createState() => _EpubRenderState();
}

class _EpubRenderState extends State<EpubRender> {
  late InAppWebViewController inAppWebViewController;
  late EpubRenderController controller;
  var currentLocation = EpubLocation(0, EpubInnerPage(0));
  bool _isReady = false;

  bool get isReady {
    return _isReady;
  }

  set isReady(bool ready) {
    setState(() {
      _isReady = ready;
    });
    controller.isReady = ready;
    widget.onReadyChanged(ready);
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: defaultTargetPlatform == TargetPlatform.iOS ? 1 : isReady ? 1 : 0,
          child: InAppWebView(
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                transparentBackground: true,
                disableContextMenu: true
              ),
              android: AndroidInAppWebViewOptions(
                useHybridComposition: false
              ),
            ),
            onWebViewCreated: (controller) async {
              inAppWebViewController = controller;

              inAppWebViewController.addJavaScriptHandler(
                handlerName: "load",
                callback: onLoad,
              );

              inAppWebViewController.addJavaScriptHandler(
                handlerName: "ready",
                callback: onReady,
              );
              
              inAppWebViewController.addJavaScriptHandler(
                handlerName: "notePress",
                callback: (args) {
                  widget.onNotePressed(args[0] as String);
                },
              );

              inAppWebViewController.addJavaScriptHandler(
                handlerName: "link",
                callback: (args) {
                  widget.onLinkPressed(args[0] as String);
                },
              );

              inAppWebViewController.addJavaScriptHandler(
                handlerName: "selection",
                callback: (args) {
                  widget.onSelection(
                    EpubSelectionData(
                      text: args[0] as String,
                      rangesData: (args[1] as List).map((rangeDataJson) => SavedNoteRangeData.fromJson(rangeDataJson)).toList(),
                      rect: Rectangle(
                        (args[2] as int).toDouble(),
                        (args[3] as int).toDouble(),
                        (args[4] as int).toDouble(),
                        (args[5] as int).toDouble(),
                      ),
                    ),
                  );
                },
              );

              await controller.loadUrl(
                urlRequest: URLRequest(
                  url: Uri.parse("http://localhost:8080")
                )
              );
            },
            contextMenu: ContextMenu(
              menuItems: [],
              options: ContextMenuOptions(
                hideDefaultSystemContextMenuItems: true
              )
            ),
          ),
        ),
        if (!isReady)
          const Center(
            child: CircularLoadingIndicator()
          ),
        defaultTargetPlatform == TargetPlatform.iOS
          ? GestureDetector(
            behavior: HitTestBehavior.deferToChild
          )
          : GestureDetector(
            behavior: HitTestBehavior.translucent,
            onLongPress: () {
              widget.publicationDigitalController.isShowOptionBar.value = !widget.publicationDigitalController.isShowOptionBar.value;
            },
          ),
        Obx(
          () => widget.publicationDigitalController.isDragSlideHandling.value
            ? Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: CircularLoadingIndicator()
              ),
            )
            : Container()
        )
      ],
    );
  }

  void onLoad(List<dynamic> args) {
    controller = EpubRenderController(
      onLocation: onLocation,
      getLocation: () => currentLocation,
      onStyle: onStyle,
      onCss: onCss,
      onClearSelection: () {
        runJSFunction("clearSelection", []);
      },
    );
    widget.onLoaded(controller);
  }

  void onReady(args) {
    currentLocation = EpubLocation(currentLocation.page, EpubInnerPage(args[0] as int));
    controller.innerPages = args[1] as int;
    controller.passedAnchors = (args[2] as List<dynamic>).map((e) => e.toString()).toList();

    final consistentInnerNavigationJson = args[3] as Map<String, dynamic>;

    controller.consistentLocation = EpubLocation(
      currentLocation.page,
      EpubInnerNavigation.fromJson(consistentInnerNavigationJson) as EpubConsistentInnerNavigation,
    );

    isReady = true;

    if (args[1] < 1) {
      runJSFunction(
        "page",
        [widget.getPageFile(widget.bookcase?.progress?.page ?? 0), widget.bookcase?.progress?.inner_page ?? 0, true, []],
      );
    }
  }

  void onLocation(
    EpubLocation<int, EpubInnerNavigation> newLocation,
    bool forced,
    List<SavedNote> Function(int page)? getNotes,
  ) {
              
    isReady = false;
    
    List<Map<String, Object>> notesToJson(int page) {
      return (getNotes?.call(page) ?? [])
        .map(
          (note) => {
            "id": note.id,
            "ranges": note.rangesData.map((range) => range.toJson()).toList(),
            "color": note.color,
            "hasDescription": note.description.isNotEmpty
          },
        )
        .toList();
    }

    if (newLocation.innerNav is EpubInnerPage) {
      var page = newLocation.page;
      var innerPage = (newLocation.innerNav as EpubInnerPage).page;
      if (controller.innerPages != null && innerPage >= controller.innerPages!) {
        page++;
        innerPage = 0;
        controller.innerPages = null;
      }

      if (innerPage < 0) {
        page--;
        innerPage = -1;
        controller.innerPages = null;
      }

      page = page.clamp(0, widget.maxPages - 1);

      newLocation = EpubLocation(page, EpubInnerPage(innerPage));

      runJSFunction(
        "page",
        [widget.getPageFile(page), innerPage, forced, notesToJson(page)],
      );
    } else if (newLocation.innerNav is EpubInnerAnchor) {
      runJSFunction(
        "pageAnchor",
        [
          widget.getPageFile(newLocation.page),
          (newLocation.innerNav as EpubInnerAnchor).anchor,
          forced,
          notesToJson(newLocation.page),
        ],
      );
    } else if (newLocation.innerNav is EpubInnerTextNode) {
      final innerNav = newLocation.innerNav as EpubInnerTextNode;
      runJSFunction(
        "pageTextNode",
        [
          widget.getPageFile(newLocation.page),
          innerNav.textNodeIndex,
          innerNav.characterIndex,
          forced,
          notesToJson(newLocation.page),
        ],
      );
    } else if (newLocation.innerNav is EpubInnerNode) {
      final innerNav = newLocation.innerNav as EpubInnerNode;
      runJSFunction(
        "pageNode",
        [
          widget.getPageFile(newLocation.page),
          innerNav.nodeIndex,
          innerNav.characterIndex,
          forced,
          notesToJson(newLocation.page),
        ],
      );
    } else if (newLocation.innerNav is EpubInnerElement) {
      runJSFunction(
        "pageTextNode",
        [
          widget.getPageFile(newLocation.page),
          (newLocation.innerNav as EpubInnerElement).elementIndex,
          forced,
          notesToJson(newLocation.page),
        ],
      );
    } else {
      throw Exception("unknown innerNav type.");
    }
    
    currentLocation = EpubLocation(newLocation.page, EpubInnerPage(0));
  }

  void onStyle(EpubStyleProperties style) {
    runJSFunction("style", [
      style,
    ]);
  }

  void onCss(String css) {
    runJSFunction("css", [
      controller.css,
    ]);
  }

  void runJSFunction(String name, List<Object> arguments) {
    String stringArguments = arguments.map((arg) => jsonEncode(arg)).join(',');
    inAppWebViewController.evaluateJavascript(
      source: "window.$name($stringArguments);",
    );
  }
}