import 'package:qltv/domain/entities/epub/epub_location.dart';
import 'package:qltv/domain/entities/epub/epub_style_properties.dart';
import 'package:qltv/presentation/controllers/publication_digital/epub_render_controller.dart';

class BookPlayerRenderController {
  final void Function() clearSelection;
  final void Function(EpubLocation, {bool forced}) setLocation;
  final EpubRenderController Function() _getCurrentController;
  final EpubStyleProperties style;
  final void Function(EpubStyleProperties) _setStyle;

  BookPlayerRenderController({
    required this.style,
    required void Function() onClearSelection,
    required void Function(EpubLocation epubLocation, {bool forced}) onSetLocation,
    required EpubRenderController Function() getCurrentController,
    required void Function(EpubStyleProperties) onStyle,
  })  : clearSelection = onClearSelection,
        setLocation = onSetLocation,
        _getCurrentController = getCurrentController,
        _setStyle = onStyle;

  EpubRenderController get currentController {
    return _getCurrentController();
  }

  updateStyle() {
    _setStyle(style);
  }
}