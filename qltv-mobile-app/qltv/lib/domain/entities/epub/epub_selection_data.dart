import 'dart:math';

import 'package:qltv/domain/entities/epub/saved_note_range_data.dart';

class EpubSelectionData {
  EpubSelectionData({
    required this.text,
    required this.rangesData,
    required this.rect,
  });

  final String text;
  final List<SavedNoteRangeData> rangesData;
  final Rectangle rect;
}