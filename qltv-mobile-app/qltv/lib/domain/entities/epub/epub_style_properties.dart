import 'package:qltv/app/config/app_common.dart';
import 'package:qltv/domain/entities/epub/epub_margin.dart';
import 'package:qltv/domain/entities/epub/epub_style_themes.dart';

class EpubStyleProperties {
  EpubMargin margin;
  double fontSizeMultiplier;
  double lineHeightMultiplier;
  double weightMultiplier;
  int letterSpacingAdder;
  int wordSpacingAdder;
  String align;
  String fontFamily;
  String fontPath;
  EpubStyleThemes theme;
  String backgroundColor;
  String color;

  EpubStyleProperties({
    required this.margin,
    required this.fontSizeMultiplier,
    required this.lineHeightMultiplier,
    required this.letterSpacingAdder,
    required this.wordSpacingAdder,
    required this.weightMultiplier,
    required this.align,
    required this.fontFamily,
    required this.fontPath,
    required this.theme,
    required this.backgroundColor,
    required this.color,
  });

  EpubStyleProperties.fromJson(Map<String, dynamic> json)
    : margin = EpubMargin.fromJson(json['margin']),
      fontSizeMultiplier = json['fontSizeMultiplier'],
      lineHeightMultiplier = json['lineHeightMultiplier'],
      letterSpacingAdder = json['letterSpacingAdder'] ?? 0,
      wordSpacingAdder = json['wordSpacingAdder'] ?? 0,
      align = json['align'],
      fontFamily = json['fontFamily'],
      fontPath = json['fontPath'],
      weightMultiplier = json['weightMultiplier'] ?? 1,
      theme = enumFromIndex(
        EpubStyleThemes.values,
        json['theme'],
        def: EpubStyleThemes.dark,
      ),
      backgroundColor = json['backgroundColor'],
      color = json['color']
      ;

  Map<String, dynamic> toJson() {
    return {
      'margin': margin.toJson(),
      'fontSizeMultiplier': fontSizeMultiplier,
      'lineHeightMultiplier': lineHeightMultiplier,
      'letterSpacingAdder': letterSpacingAdder,
      'wordSpacingAdder': wordSpacingAdder,
      'align': align,
      'fontFamily': fontFamily,
      'fontPath': fontPath,
      'weightMultiplier': weightMultiplier,
      'theme': theme.index,
      'backgroundColor': backgroundColor,
      'color': color,
    };
  }
}