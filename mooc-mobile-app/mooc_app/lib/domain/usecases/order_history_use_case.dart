import 'package:mooc_app/domain/entities/order.dart';

import '../../app/core/usecases/pram_usecase.dart';
import '../entities/course_list.dart';
import '../repositories/order_history_repository.dart';

class OrderHistoryUseCase extends ParamUseCase<Order, int> {
  OrderHistoryUseCase(this.orderHistoryRepository);

  final OrderHistoryRepository orderHistoryRepository;

  @override
  Future<Order> execute(params) {
    return orderHistoryRepository.fetchData(params);
  }
}
