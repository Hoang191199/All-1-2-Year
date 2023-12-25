import 'package:qltv/domain/entities/items_borrow.dart';

class Borrow {
  Borrow({
    this.id,
    this.site_id,
    this.title,
    this.status,
    this.created_at,
    this.items,
    this.note,
    this.reject_message,
    this.get_date
  });

  int? id;
  int? site_id;
  String? title;
  int? status;
  String? created_at;
  List<ItemsBorrow>? items;
  String? note;
  String? reject_message;
  String? get_date;
  

  factory Borrow.fromJson(Map<String, dynamic>? json) {
    return Borrow(
      id: json?["id"] == null ? null : json?['id'] as int,
      site_id: json?["site_id"] == null ? null : json?['site_id'] as int,
      title: json?["title"] == null ? null : json?['title'] as String,
      status: json?["status"] == null ? null : json?['status'] as int,
      created_at: json?["created_at"] == null ? null : json?['created_at'] as String,
      get_date: json?["get_date"] == null ? null : json?['get_date'] as String,
      items: json?["items"] == [] ? [] : List<ItemsBorrow>.from(json?["items"].map((x) => ItemsBorrow.fromJson(x))),
      note: json?["note"] == null ? null : json?['note'] as String,
      reject_message: json?["reject_message"] == null ? null : json?['reject_message'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'site_id': site_id,
        'title': title,
        'status': status,
        'created_at': created_at,
        'items': items,
        'note': note,
        'reject_message': reject_message,
        'get_date': get_date,
      };
}
