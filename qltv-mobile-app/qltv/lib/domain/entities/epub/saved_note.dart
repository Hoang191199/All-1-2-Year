import 'package:qltv/domain/entities/epub/saved_note_color.dart';
import 'package:qltv/domain/entities/epub/saved_note_range_data.dart';

class SavedNote {
  // final String id;
  final int id;
  final String highlightedText;
  // SavedNoteColor color;
  String color;
  String description;
  final int page;
  final List<SavedNoteRangeData> rangesData;

  SavedNote({
    required this.id,
    required this.highlightedText,
    required this.color,
    required this.page,
    required this.rangesData,
    String? description,
  }) : description = description ?? "";

  factory SavedNote.fromJson(Map<String, dynamic> json) {
    return SavedNote(
      id: json['id'] as int,
      highlightedText: json['highlightedText'] as String,
      // color: SavedNoteColor.values[json["color"]],
      color: json['color'] as String,
      page: json['page'] as int,
      rangesData: (json['rangesData'] as List)
        .map((e) => SavedNoteRangeData.fromJson(e as Map<String, dynamic>))
        .toList(),
      description: json['description'] as String,
    );
  }

  factory SavedNote.fromJsonDefault(Map<String, dynamic> json, SavedNote def) {
    try {
      return SavedNote.fromJson(json);
    } catch (e) {
      return def;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'highlightedText': highlightedText,
      'color': color,
      'page': page,
      'rangesData': rangesData.map((e) => e.toJson()).toList(),
      'description': description,
    };
  }
}