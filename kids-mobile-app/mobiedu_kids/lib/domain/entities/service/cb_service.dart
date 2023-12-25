import 'package:mobiedu_kids/domain/entities/service/item_child_service.dart';

class CbService{
  CbService({
    this.service_id,
    this.service_name,
    this.fee,
    this.service_usage_id,
    this.status
  });

  String? service_id;
  String? service_name;
  String? fee;
  String? service_usage_id;
  int? status;

  
  factory CbService.fromJson(Map<String, dynamic>? json) {
    return CbService(
      service_id: json?["service_id"] == null ? null : json?['service_id'] as String,
      service_name: json?["service_name"] == null ? null : json?['service_name'] as String,
      fee : json?["fee"] == null ? null : json?['fee'],
      service_usage_id: json?["service_usage_id"] == null ? null : json?['service_usage_id'] as String,
      status: json?["status"] == null ? null : json?['status'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
      'service_id': service_id,
      'service_name': service_name,
      'fee': fee,
      'service_usage_id' : service_usage_id,
      'status' : status
  };

  ItemChildService parseToItemChildService({
    String? service_id,
    String? service_name,
    String? fee,
    bool? check,
    bool? check_status,
    bool? checkClick
  }) {
    bool isCheck = check ?? (service_usage_id != null);
    bool isStatus = check_status ?? (status == 1);
    bool isClick = checkClick ?? (status == 1);
    return ItemChildService(
      service_id: this.service_id,
      service_name: this.service_name,
      fee: this.fee,
      check: check ?? isCheck,
      check_status: check_status ?? isStatus,
      checkClick: checkClick ?? isClick,
    );
  }
}