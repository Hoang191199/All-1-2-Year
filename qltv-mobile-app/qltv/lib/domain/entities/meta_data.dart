import 'package:qltv/domain/entities/punishment.dart';

class LendingMetaData {
  LendingMetaData({
  this.loss_date,
  this.old_status,
  this.punishment,
  this.real_return_date
  });

  String? loss_date;
  String? old_status;
  Punishment? punishment;
  String? real_return_date;

  factory LendingMetaData.fromJson(Map<String, dynamic>? json) {
    return LendingMetaData(
      loss_date :json?["loss_date"] == null ? null : json?["loss_date"] as String,
      old_status :json?["old_status"] == null ? null : json?["old_status"] as String,
      punishment: json?["punishment"] == null ? null : Punishment.fromJson(json?["punishment"]),
      real_return_date : json?["real_return_date"] == null ? null : json?["real_return_date"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    "loss_date" : loss_date,
    "old_status": old_status,
    "punishment": punishment,
    "real_return_date": real_return_date
  };
}