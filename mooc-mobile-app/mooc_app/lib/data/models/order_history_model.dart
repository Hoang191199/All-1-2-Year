import 'package:json_annotation/json_annotation.dart';
import 'package:mooc_app/domain/entities/order_history.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/paging_mooc.dart';
part 'order_history_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderHistoryModel extends Order{
  OrderHistoryModel({
    this.data,
    this.pagination,
    this.code,
  }): super(data: data,pagination: pagination);

  List<OrderHistory>? data;
  PagingMooc? pagination;
  int? code;
  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderHistoryModelToJson(this);
}