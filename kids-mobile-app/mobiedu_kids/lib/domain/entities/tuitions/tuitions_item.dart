import 'package:mobiedu_kids/domain/entities/tuitions/data_tuition_detail.dart';

class TuitionItems {
  TuitionItems({
    this.status,
    this.description,
    this.total_amount,
    this.total_deduction,
    this.debt_amount,
    this.paid_amount,
    this.pre_month,
    this.tuition_detail,
    this.month,
    this.bank_account
  });

  String? status;
  String? description;
  String? total_amount;
  String? total_deduction;
  String? debt_amount;
  String? paid_amount;
  String? pre_month;
  List<DataTuitionDetail>? tuition_detail;
  String? month;
  String? bank_account;


  factory TuitionItems.fromJson(Map<String, dynamic>? json) {
    return TuitionItems(
      status: json?["status"] == null ? null : json?['status'] as String,
      description: json?["description"] == null ? null : json?['description'] as String,
      total_amount: json?["total_amount"] == null ? null : json?['total_amount'] as String,
      paid_amount: json?["paid_amount"] == null ? null : json?['paid_amount'] as String,
      pre_month: json?["pre_month"] == null ? null : json?['pre_month'] as String,
      tuition_detail:json?['tuition_detail'] == null ? null : List<DataTuitionDetail>.from(json?["tuition_detail"].map((x) => DataTuitionDetail.fromJson(x))),
      month: json?["month"] == null ? null : json?['month'] as String,
      debt_amount: json?["debt_amount"] == null ? null : json?['debt_amount'] as String,
      total_deduction: json?["total_deduction"] == null ? null : json?['total_deduction'] as String,
      bank_account: json?["bank_account"] == null ? null : json?['bank_account'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'description': description,
    'total_amount': total_amount,
    'paid_amount': paid_amount,
    'pre_month': pre_month,
    'tuition_detail': tuition_detail,
    'month': month,
    'debt_amount': debt_amount,
    'total_deduction': total_deduction,
    'bank_account': bank_account
  };
}
