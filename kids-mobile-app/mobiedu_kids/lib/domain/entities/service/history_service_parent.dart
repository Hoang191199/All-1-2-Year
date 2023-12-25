import 'package:mobiedu_kids/domain/entities/service/cb_service.dart';

class HistoryServiceParent {
  HistoryServiceParent({
   this.history
  });

  List<CbService>? history;

  factory HistoryServiceParent.fromJson(Map<String, dynamic>? json) {
    return HistoryServiceParent(
      history:json?['history'] == null ? null : List<CbService>.from(json?["history"].map((x) => CbService.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
      'history': history,
  };
}