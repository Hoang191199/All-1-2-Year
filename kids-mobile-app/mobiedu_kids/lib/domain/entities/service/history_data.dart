import 'package:mobiedu_kids/domain/entities/service/service_in_history.dart';

class HistoryData{
  HistoryData({
    this.history
  });

  List<ServiceInHistory>? history;

  factory HistoryData.fromJson(Map<String, dynamic>? json) {
    return HistoryData(
      history:json?['history'] == null ? null : List<ServiceInHistory>.from(json?["history"].map((x) => ServiceInHistory.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
      'history': history,
  };
}