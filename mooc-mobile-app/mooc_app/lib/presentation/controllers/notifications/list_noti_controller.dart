import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/noti_mooc.dart';
import 'package:mooc_app/domain/entities/paging_mooc.dart';
import 'package:mooc_app/domain/usecases/list_noti_mooc_use_case.dart';

class ListNotiController extends GetxController {
  ListNotiController(this.listNotiMoocUseCase);
  final ListNotiMoocUseCase listNotiMoocUseCase;
  int currentPage = 1;
  int pageSize = 10;
  var isLoadMore = false;
  var paging = Rx<PagingMooc?>(null);
  var code = Rx<int?>(null);
  var error = Rx<bool?>(null);
  final isLoading = false.obs;
  var listNotiMoocData = RxList<NotiMooc>([]);

  @override
  void onInit() async {
    // await fetchListData();
    super.onInit();
  }

  fetchData() async {
    isLoading(true);
    currentPage = 1;
    listNotiMoocData.value = [];
    final response = await listNotiMoocUseCase.execute(Tuple2(currentPage, pageSize));
    paging.value = response.pagination;
    listNotiMoocData.assignAll(response.data ?? []);
    code.value = response.code;
    error.value = response.error;
    isLoading(false);
  }

  loadMore() async {
    final total = paging.value?.total ?? 0;
    if (total / pageSize <= currentPage) return;
    if (isLoadMore) return;
    isLoadMore = true;
    currentPage += 1;
    final response = await listNotiMoocUseCase.execute(Tuple2(currentPage, pageSize));
    paging.value = response.pagination;
    listNotiMoocData.addAll(response.data ?? []);
    isLoadMore = false;
  }
}
