import 'package:mobiedu_kids/domain/entities/shuttle/late_pickup.dart';
class Shuttle {
  Shuttle({
    this.late_pickup,
    this.picked_up,
    this.pickup_class_id,
    this.pickup_class_name,
    this.pickup_id,

    });

  List<LatePickup>? late_pickup;
  int? picked_up;
  String? pickup_class_id;
  String? pickup_class_name;
  String? pickup_id;

  factory Shuttle.fromJson(Map<String, dynamic>? json) {
    return Shuttle(
      late_pickup:json?['late_pickup'] == null ? null : List<LatePickup>.from(json?["late_pickup"].map((x) => LatePickup.fromJson(x))),
      picked_up: json?["picked_up"] == null ? null : json?['picked_up'] as int,
      pickup_class_id: json?["pickup_class_id"] == null ? null : json?['pickup_class_id'] as String,
      pickup_class_name: json?["pickup_class_name"] == null ? null : json?['pickup_class_name'] as String,
      pickup_id: json?["pickup_id"] == null ? null : json?['pickup_id'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
      'late_pickup': late_pickup,
      'picked_up': picked_up,
      'pickup_class_id': pickup_class_id,
      'pickup_class_name': pickup_class_name,
      'pickup_id': pickup_id,
  };
}
