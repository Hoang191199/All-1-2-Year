import 'package:mobiedu_kids/domain/entities/meal.dart';

class DetailMenu {
  DetailMenu({
    this.details
  });

  List<Meal>? details;

  factory DetailMenu.fromJson(Map<String, dynamic>? json) {
    return DetailMenu(
      details:json?['details'] == null ? null : List<Meal>.from(json?["details"].map((x) => Meal.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'details': details,
  };
}