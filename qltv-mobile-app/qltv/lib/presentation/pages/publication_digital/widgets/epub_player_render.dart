import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:qltv/domain/entities/bookcase.dart';
import 'package:qltv/domain/entities/epub/epub_book.dart';
import 'package:qltv/domain/entities/epub/epub_inner_anchor.dart';
import 'package:qltv/domain/entities/epub/epub_selection_data.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_bookmark_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_handle.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qltv/domain/entities/epub/epub_consistent_inner_navigation.dart';
import 'package:qltv/domain/entities/epub/epub_inner_page.dart';
import 'package:qltv/domain/entities/epub/epub_location.dart';
import 'package:qltv/domain/entities/epub/epub_style_properties.dart';
import 'package:qltv/domain/entities/epub/saved_note.dart';
import 'package:qltv/presentation/controllers/publication_digital/book_player_render_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_render_controller.dart';
import 'package:qltv/presentation/controllers/publication_digital/publication_digital_controller.dart';
import 'package:qltv/presentation/pages/publication_digital/widgets/epub_render.dart';

final isUrlRegex = RegExp("^(?:[a-z+]+:)?//", caseSensitive: false);

class EpubRenderContainer {
  EpubRenderContainer({
    required this.id,
    required this.epubRender,
  });

  final int id;
  final EpubRender epubRender;
  late EpubRenderController controller;
}

class EpubPlayerRender extends StatefulWidget {
  EpubPlayerRender({
    super.key,
    required this.bookcase,
    required this.epubController,
    this.controllerCreated,
    required this.initialStyle,
    required this.initialLocation,
    required this.savedNotes,
    this.onNotePressed,
    this.onSaveLocation,
    required this.onSelection,
  });

  final Bookcase? bookcase;
  final EpubController epubController;
  final void Function(BookPlayerRenderController controller)? controllerCreated;
  final EpubStyleProperties initialStyle;
  final EpubLocation initialLocation;
  final List<SavedNote> savedNotes;
  final void Function(SavedNote)? onNotePressed;
  final void Function(EpubLocation<int, EpubConsistentInnerNavigation> epubLocation)? onSaveLocation;
  final void Function(EpubSelectionData selection) onSelection;

  final publicationDigitalController = Get.find<PublicationDigitalController>();
  final epubBookmarkController = Get.find<EpubBookmarkController>();

  @override
  State<EpubPlayerRender> createState() => _EpubPlayerRenderState();
}

class _EpubPlayerRenderState extends State<EpubPlayerRender> with SingleTickerProviderStateMixin {
  List<EpubRenderContainer> epubRenders = [];
  final progress = ValueNotifier<double>(0);
  late EpubRenderController currentEpubRenderController;
  late AnimationController animationController;
  bool settingLocation = false;
  bool lastForced = false;
  bool canTransitionPages = false;
  bool dragging = false;
  double startDraggingProgress = 0;
  Offset draggingMoved = Offset.zero;
  bool dragAnimation = true;
  late Tween<double> transitionTween;
  int maxPages = 0;

  @override
  void initState() {
    super.initState();

    maxPages = widget.epubController.epubBook?.schema?.package?.spine?.items?.length ?? 0;

    animationController = AnimationController(vsync: this);
    transitionTween = Tween<double>(
      begin: 0,
      end: 1,
    );
    final animation = transitionTween.animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
    );

    animation.addListener(() {
      progress.value = animation.value;

      if (animation.isCompleted) {
        onDragAnimationEnd();
      }
    });

    const renders = 3;
    final tempControllers = <int, EpubRenderController>{};
    for (int i = 0; i < renders; i++) {
      epubRenders.add(EpubRenderContainer(
        id: i,
        epubRender: EpubRender(
          id: i,
          maxPages: maxPages,
          onLoaded: (controller) {
            tempControllers[i] = controller;
            if (tempControllers.entries.length == renders) {
              for (var render in epubRenders) {
                render.controller = tempControllers[render.id]!;
              }
              onAllLoaded();
            }
          },
          onReadyChanged: (bool isReady) {
            onReadyChanged();
          },
          onNotePressed: (String noteId) {
            widget.onNotePressed?.call(widget.savedNotes.firstWhere((savedNote) => savedNote.id.toString() == noteId));
          },
          onLinkPressed: (String link) {
            if (isUrlRegex.hasMatch(link)) {
              launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
            } else {
              final parts = link.split("#");
              setLocation(EpubLocation(
                parts[0],
                EpubInnerAnchor(parts.length > 1 ? parts[1] : ""),
              ));
            }
          },
          getPageFile: getPageFile,
          onSelection: widget.onSelection,
          epubController: widget.epubController,
          bookcase: widget.bookcase,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return GestureDetector(
      onHorizontalDragStart: (details) {
        void horizontalDragStart() {
          if (!canTransitionPages) {
            return;
          }
          clearSelection();
          dragging = true;
          canTransitionPages = false;
          startDraggingProgress = progress.value;
          draggingMoved = Offset.zero;
        }
        if (defaultTargetPlatform == TargetPlatform.iOS) {
          if (widget.publicationDigitalController.highlightText.isEmpty) {
            horizontalDragStart();
          }
        } else {
          horizontalDragStart();
        }
      },
      onHorizontalDragUpdate: (details) {
        void horizontalDragUpdate() {
          if (!dragging) {
            return;
          }
          draggingMoved += details.delta;
          if (dragAnimation == true) {
            double x = (-draggingMoved.dx / 392).clamp(-1, 1);
            progress.value = _clampProgress(startDraggingProgress + (x.abs()) * x.sign);
          }
        }
        if (defaultTargetPlatform == TargetPlatform.iOS) {
          if (widget.publicationDigitalController.highlightText.isEmpty) {
            horizontalDragUpdate();
          }
        } else {
          horizontalDragUpdate();
        }
      },
      onHorizontalDragEnd: (details) {
        void horizontalDragEnd() {
          if (!dragging) {
            return;
          }
          dragging = false;
          double offset = progress.value.roundToDouble() - startDraggingProgress;
          double side = (progress.value - startDraggingProgress).sign;

          if (details.velocity.pixelsPerSecond.dx.abs() > 30) {
            offset = -details.velocity.pixelsPerSecond.dx.sign;
            if (side != 0 && side != offset) offset = 0;
          }

          canTransitionPages = true;
          animateToPage(
            offset: offset,
            autoStartDraggingProgress: false,
          );
        }
        if (defaultTargetPlatform == TargetPlatform.iOS) {
          if (widget.publicationDigitalController.highlightText.isEmpty) {
            horizontalDragEnd();
          }
        } else {
          horizontalDragEnd();
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Stack(
          children: epubRenders.map((render) {
            return ValueListenableBuilder<double>(
              key: ValueKey(render.id),
              valueListenable: progress,
              builder: (context, value, child) {
                double location = ((render.id - value) % 3 - 1);
                double xPos;
                if (location >= 0 && location <= 1) {
                  xPos = 0;
                } else {
                  xPos = location;
                }
                return Positioned(
                  left: xPos * widthScreen,
                  child: SizedBox(
                    width: widthScreen,
                    height: heightScreen - statusBarHeight - 25.0 - 40.0 - 10.0 - bottomPadding - 20.0 - 60.0,
                    child: Stack(
                      children: [
                        Container(
                          // color: Colors.white,
                          width: double.infinity,
                          height: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/background.png"),
                              fit: BoxFit.cover,
                            ),
                          )
                        ),
                        Opacity(
                          opacity: location > 0 && location <= 1
                            ? max(0.1, value % 1)
                            : 1,
                          child: child!,
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: render.epubRender,
            );
          }).toList(),
        ),
      ),
    );
  }

  void onReadyChanged() {
    final allReady = canTransitionPages = epubRenders.every((renderer) => renderer.controller.isReady);
    if (allReady) {
      if (widget.onSaveLocation != null) {
        widget.onSaveLocation!(currentEpubRenderController.consistentLocation);
      }
    }

    if (settingLocation && currentEpubRenderController.isReady) {
      canTransitionPages = false;
      settingLocation = false;
      updatePages();
      lastForced = false;
    }
  }

  void onDragAnimationEnd() {
    updatePages();
  }

  void updatePages() {
    progress.value = progress.value.roundToDouble() % 3;

    final currentEpubRenderer = epubRenders.firstWhere((renderer) => renderer.id == (progress.value.round() + 1) % 3);
    final rightRenderer = epubRenders.firstWhere((renderer) => renderer.id == (progress.value.round() + 2) % 3);
    final leftRenderer = epubRenders.firstWhere((renderer) => renderer.id == (progress.value.round() + 3) % 3);

    // Layering
    setState(() {
      epubRenders = [
        rightRenderer,
        currentEpubRenderer,
        leftRenderer,
      ];
    });

    currentEpubRenderController = currentEpubRenderer.controller;

    final currentLocation = currentEpubRenderController.location;
    final currentInnerPages = currentEpubRenderController.innerPages;

    final sides = [leftRenderer.controller, rightRenderer.controller];
    for (var i = 0; i < sides.length; i++) {
      final controller = sides[i];
      controller.innerPages = currentInnerPages;
      controller.setLocation(
        EpubLocation(
          currentLocation.page,
          EpubInnerPage(currentLocation.innerNav.page + (i * 2 - 1)),
        ),
        lastForced,
        (page) => widget.savedNotes.where((note) => note.page == page).toList(),
      );
    }

    if (currentInnerPages! < 1 && currentEpubRenderer.id == 1) {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        widget.publicationDigitalController.reloadCurrentPage(
          widget.epubController, 
          EpubLocation(widget.bookcase?.progress?.page ?? 0, EpubInnerPage(widget.bookcase?.progress?.inner_page ?? 0))
        );
      });
    } else {
      widget.epubBookmarkController.checkPageBookmark(widget.epubController);

      if (widget.publicationDigitalController.allowUpdateProgress.value) {
        widget.publicationDigitalController.sentProgressRead(widget.epubController, widget.bookcase?.id ?? 0);
      }
    }
  }

  void animateToPage({
    required double offset,
    double? startValue,
    bool? autoStartDraggingProgress,
  }) {
    if (!canTransitionPages) {
      return;
    }

    double prog = progress.value;

    clearSelection();
    if (autoStartDraggingProgress != false) {
      startDraggingProgress = prog.roundToDouble();
    }
    canTransitionPages = false;

    animationController.reset();
    transitionTween.begin = startValue ?? prog;
    transitionTween.end = _clampProgress(prog.roundToDouble() + offset);
    animationController.duration = Duration(
      milliseconds: (max((transitionTween.end! - transitionTween.begin!).abs(), 0.3) * 300).round(),
    );
    animationController.forward();
  }

  double _clampProgress(double progress) {
    final location = currentEpubRenderController.location;
    return progress.clamp(
      startDraggingProgress - (location.page == 0 && location.innerNav.page == 0 ? 0 : 1),
      startDraggingProgress + (location.page == maxPages - 1 && location.innerNav.page == (currentEpubRenderController.innerPages! - 1)
        ? 0
        : 1),
    );
  }

  void onAllLoaded() {
    if (widget.controllerCreated != null) {
      widget.controllerCreated!(BookPlayerRenderController(
        onClearSelection: clearSelection,
        onSetLocation: setLocation,
        getCurrentController: () => currentEpubRenderController,
        onStyle: (style) {
          for (var renderer in epubRenders) {
            renderer.controller.styleProperties = style;
            renderer.controller.updateStyle();
          }
        },
        style: widget.initialStyle,
      ));
    }

    currentEpubRenderController = epubRenders.firstWhere((renderer) => renderer.id == 1).controller;

    for (var renderer in epubRenders) {
      renderer.controller.styleProperties = widget.initialStyle;
      renderer.controller.updateCss();
      renderer.controller.updateStyle();
    }

    setLocation(widget.initialLocation);
  }

  void clearSelection() {
    for (var renderer in epubRenders) {
      renderer.controller.clearSelection();
    }
  }

  void setLocation(
    EpubLocation epubLocation, {
    bool forced = false,
  }) {
    int page;
    if (epubLocation.page is String) {
      String filePath = p.normalize(epubLocation.page as String);

      page = getFilesFromEpubSpine(widget.epubController.epubBook ?? EpubBook()).indexWhere((element) => element.fileName == Uri.decodeFull(filePath));
      // page = getFilesFromEpubSpine(widget.epubController.epubBook ?? EpubBook()).indexWhere((element) => element.fileName?.replaceAll('(', '%28').replaceAll(')', '%29') == filePath);

      if (page == -1) {
        throw Exception("Page file not found in spine.");
      }
    } else {
      page = epubLocation.page as int;
    }

    settingLocation = true;
    currentEpubRenderController.setLocation(
      EpubLocation(page, epubLocation.innerNav),
      forced,
      (page) => widget.savedNotes.where((note) => note.page == page).toList(),
    );
    lastForced = forced;
  }

  String getPageFile(int page) {
    return getFilesFromEpubSpine(widget.epubController.epubBook ?? EpubBook())[page].fileName ?? '';
  }
}
