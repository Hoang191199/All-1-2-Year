import 'package:mobiedu_kids/domain/entities/menu_history_details.dart';

class MenuHistory {
  MenuHistory({
    this.menu_history,
  });

  List<MenuHistoryDetails>? menu_history;
  factory MenuHistory.fromJson(Map<String, dynamic>? json) {
    return MenuHistory(
      menu_history: json?["menu_history"] == null
          ? null
          : List<MenuHistoryDetails>.from(
              json?["menu_history"].map((x) => MenuHistoryDetails.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'menu_history': menu_history,
      };
}
