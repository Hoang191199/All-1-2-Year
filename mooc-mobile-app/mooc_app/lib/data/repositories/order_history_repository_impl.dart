import 'package:mooc_app/domain/entities/order.dart';

import '../../domain/repositories/order_history_repository.dart';
import '../models/order_history_model.dart';
import '../providers/network/apis/order_history_api.dart';

class OrderHistoryRepositoryImpl extends OrderHistoryRepository {
  @override
  Future<Order> fetchData(int page) async {
    final response = await OrderHistoryAPI.fetchData(page).request();
    return OrderHistoryModel.fromJson(response);
  }
}