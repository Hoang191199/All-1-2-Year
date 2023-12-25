import 'package:mobiedu_kids/domain/entities/service/item_child_service.dart';

class ItemChild{
   ItemChild({
    this.child_id,
    this.child_name,
    this.service,
    this.child_picture
  });

  String? child_id;
  String? child_name;
  String? child_picture;
  List<ItemChildService>? service;
}