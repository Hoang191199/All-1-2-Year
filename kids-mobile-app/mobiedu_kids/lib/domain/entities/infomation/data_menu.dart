import 'package:mobiedu_kids/domain/entities/infomation/detail_menu.dart';

class MenuClass {
  MenuClass({
    this.menu_child
  });

  DetailMenu? menu_child;

  factory MenuClass.fromJson(Map<String, dynamic>? json) {
    return MenuClass(
       menu_child:json?['menu_child'] == null ? null : DetailMenu.fromJson(json?['menu_child']),
    );
  }

  Map<String, dynamic> toJson() => {
    'menu_child': menu_child,
  };
}