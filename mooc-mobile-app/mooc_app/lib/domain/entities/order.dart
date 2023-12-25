import 'package:mooc_app/domain/entities/order_history.dart';
import 'package:mooc_app/domain/entities/paging_mooc.dart';

class Order{
  Order({
    this.status,
    this.data,
    this.pagination,
  });

  bool? status;
  List<OrderHistory>? data;
  PagingMooc? pagination;

  factory Order.fromJson(Map<String, dynamic>? json) {
    return Order(
      status: json?["status"] == null ? null : json?['status'] as bool,
      data:  json?["data"] == null ? null : List<OrderHistory>.from(json?["data"].map((x) => OrderHistory.fromJson(x))),
      pagination:  json?["pagination"] == null ? null : PagingMooc.fromJson(json?["pagination"]),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': status,
    'data': data,
    'pagination': pagination
  };
}