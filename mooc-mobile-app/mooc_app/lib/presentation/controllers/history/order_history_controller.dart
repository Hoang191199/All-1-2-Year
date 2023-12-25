import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/order_history.dart';
import 'package:mooc_app/domain/entities/paging_mooc.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/usecases/order_history_use_case.dart';

class OrderHistoryController extends GetxController {
  OrderHistoryController(this.orderHistoryUseCase);
  final OrderHistoryUseCase orderHistoryUseCase;
  int currentPage = 0;
  int pageSize = 15;
  RxBool status = false.obs;
  var data = Rx<List<OrderHistory>?>([]);
  final isLoading = false.obs;
  var isLoadMore = false;
  var paging = Rx<PagingMooc?>(null);

  @override
  void onInit() async {
    fetchData();
    super.onInit();
  }

  fetchData() async {
    isLoading(true);
    final list = await orderHistoryUseCase.execute(currentPage);
    data.value = list.data;
    paging.value = list.pagination;
    isLoading(false);
  }

  loadMore() async {
    final total = paging.value?.total ?? 0;
    if (total / pageSize <= currentPage) return;
    if (isLoadMore) return;
    isLoadMore = true;
    currentPage += 1;
    final list = await orderHistoryUseCase.execute(currentPage);
    data.value?.addAll(list.data!);
    paging.value = list.pagination;
    isLoadMore = false;
  }
}
