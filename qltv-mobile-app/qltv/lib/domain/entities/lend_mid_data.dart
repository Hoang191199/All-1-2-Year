import 'lend_details.dart';

class LendingMidData {
  LendingMidData({
    this.items,
    required this.id,
  });

  List<LendDetails>? items;
  int id;

  factory LendingMidData.fromJson(Map<String, dynamic>? json) {
    return LendingMidData(
      items: json?["items"] == null ? null : List<LendDetails>.from(json?["items"].map((x) => LendDetails.fromJson(x))),
      id: json?["id"] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    "items": items,
    "id": id,
  };
}