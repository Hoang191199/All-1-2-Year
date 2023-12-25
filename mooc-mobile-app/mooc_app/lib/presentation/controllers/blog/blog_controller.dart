import 'package:get/get.dart';

import '../../../domain/entities/blog_info.dart';
import '../../../domain/entities/paging_mooc.dart';
import '../../../domain/usecases/blog_use_case.dart';

class BlogController extends GetxController {
  BlogController(this.blogUseCase);
  final BlogUseCase blogUseCase;
  var isLoadMore = false;
  int currentPage = 0;
  int pageSize = 10;
  var fetch = Rx<List<BlogInfo>?>([]);
  var paging = Rx<PagingMooc?>(null);
  final isLoading = false.obs;
  final isInitialized = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchData();
  }

  fetchData() async {
    isLoading(true);
    fetch.value = [];
    final fetchList = await blogUseCase.execute(currentPage);
    fetch.value = fetchList.data;
    isInitialized.value = true;
    isLoading(false);
  }

  loadMore() async {
    final total = paging.value?.total ?? 0;
    if (total / pageSize <= currentPage) return;
    if (isLoadMore) return;
    isLoadMore = true;
    currentPage += 1;
    final fetchList = await blogUseCase.execute(currentPage);
    fetch.value?.addAll(fetchList.data!);
    paging.value = fetchList.pagination;
    isLoadMore = false;
  }
}
