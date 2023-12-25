import 'package:mobiedu_kids/domain/entities/growths_details.dart';

class Growths {
  Growths({
    this.growths,
  });

  List<GrowthsDetails>? growths;

  factory Growths.fromJson(Map<String, dynamic>? json) {
    return Growths(
      growths: json?['growths'] == null
          ? null
          : List<GrowthsDetails>.from(
              json?["growths"].map((x) => GrowthsDetails.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'growths': growths,
      };
}
