import 'package:mobiedu_kids/domain/entities/menus_details.dart';

class Menus {
  Menus({
    this.menus,
  });

  List<MenusDetails>? menus;
  factory Menus.fromJson(Map<String, dynamic>? json) {
    return Menus(
      menus: json?["menus"] == null
          ? null
          : List<MenusDetails>.from(json?["menus"].map((x) => MenusDetails.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'menus': menus,
      };
}
