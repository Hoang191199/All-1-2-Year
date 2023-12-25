import 'package:qltv/domain/entities/epub/epub_consistent_inner_navigation.dart';
import 'package:qltv/domain/entities/epub/epub_inner_anchor.dart';
import 'package:qltv/domain/entities/epub/epub_inner_navigation.dart';
import 'package:qltv/domain/entities/epub/epub_inner_page.dart';
import 'package:qltv/domain/entities/epub/epub_location.dart';
import 'package:qltv/domain/entities/epub/epub_margin.dart';
import 'package:qltv/domain/entities/epub/epub_style_properties.dart';
import 'package:qltv/domain/entities/epub/epub_style_themes.dart';
import 'package:qltv/domain/entities/epub/saved_note.dart';

class EpubRenderController {
  final void Function(EpubLocation<int, EpubInnerNavigation>, bool forced, List<SavedNote> Function(int page)?) setLocation;
  final EpubLocation<int, EpubInnerPage> Function() getLocation;
  final void Function(EpubStyleProperties) _updateStyle;
  final void Function(String) _updateCss;
  final void Function() clearSelection;

  var styleProperties = EpubStyleProperties(
    margin: EpubMargin(
      side: 0.0,
      top: 0.0,
      bottom: 0.0,
    ),
    fontSizeMultiplier: 1.0,
    lineHeightMultiplier: 1.2,
    weightMultiplier: 1,
    letterSpacingAdder: 0,
    wordSpacingAdder: 0,
    align: 'start',
    fontFamily: 'Arial',
    fontPath: '',
    theme: EpubStyleThemes.light,
    backgroundColor: 'default',
    color: 'initial',
  );
  EpubLocation<int, EpubConsistentInnerNavigation> consistentLocation = EpubLocation(
    0,
    EpubInnerAnchor(""),
  );
  String css = "";
  int? innerPages;
  bool isReady = false;
  List<String> passedAnchors = [];

  EpubRenderController({
    required void Function(EpubLocation<int, EpubInnerNavigation>, bool forced, List<SavedNote> Function(int page)?) onLocation,
    required this.getLocation,
    required void Function(EpubStyleProperties) onStyle,
    required void Function(String) onCss,
    required void Function() onClearSelection,
  })  : setLocation = onLocation,
        _updateStyle = onStyle,
        _updateCss = onCss,
        clearSelection = onClearSelection;

  EpubLocation<int, EpubInnerPage> get location => getLocation();

  void updateStyle() {
    _updateStyle(styleProperties);
  }

  void updateCss() {
    _updateCss(css);
  }
}