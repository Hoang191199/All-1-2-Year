import 'package:qltv/domain/entities/highlight_item.dart';

class Highlight {
  Highlight({
    this.id,
    this.item_id,
    this.user_id,
    this.type,
    this.metadata,
  });

  int? id;
  int? item_id;
  String? user_id;
  String? type;
  HighlightItem? metadata;

  factory Highlight.fromJson(Map<String, dynamic>? json) {
    return Highlight(
      id: json?["id"] == null ? null : json?['id'] as int,
      item_id: json?["item_id"] == null ? null : json?['item_id'] as int,
      user_id: json?["user_id"] == null ? null : json?['user_id'] as String,
      type: json?["type"] == null ? null : json?['type'] as String,
      metadata: json?['metadata'] == null ? null : HighlightItem.fromJson(json?['metadata']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'item_id': item_id,
    'user_id': user_id,
    'type': type,
    'metadata': metadata,
  };
}