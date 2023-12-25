import 'package:mobiedu_kids/domain/entities/service/cb_service.dart';

class ServicesCountbased {
  ServicesCountbased({
   this.services_countbased
  });

  List<CbService>? services_countbased;

  factory ServicesCountbased.fromJson(Map<String, dynamic>? json) {
    return ServicesCountbased(
      services_countbased:json?['services_countbased'] == null ? null : List<CbService>.from(json?["services_countbased"].map((x) => CbService.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
      'services_countbased': services_countbased,
  };
}