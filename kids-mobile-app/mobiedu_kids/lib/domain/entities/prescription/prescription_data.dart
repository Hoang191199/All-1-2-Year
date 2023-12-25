import 'package:mobiedu_kids/domain/entities/prescription/medicines.dart';

class Prescriptions {
  Prescriptions({this.medicines});

  List<Medicines>? medicines;

  factory Prescriptions.fromJson(Map<String, dynamic>? json) {
    return Prescriptions(
      medicines: json?['medicines'] == null ? null : List<Medicines>.from(json?["medicines"].map((x) => Medicines.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'medicines': medicines,
      };
}
