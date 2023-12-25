import 'package:mooc_app/domain/entities/order.dart';

abstract class OrderHistoryRepository {
  Future<Order> fetchData(int page);
}