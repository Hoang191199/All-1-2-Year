import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/search.dart';
import 'package:mooc_app/domain/usecases/search_use_case.dart';

class SearchFetchController extends GetxController {
  SearchFetchController(this.searchUseCase);

  final SearchUseCase searchUseCase;
  var isLoadMore = false;
  var search = Rx<Search?>(null);
  var search2 = Rx<Search?>(null);
  var search3 = Rx<Search?>(null);
  final isLoading = false.obs;
  final isInitialized = false.obs;

  @override
  void onInit() async {
    await fetchDataInit("");
    super.onInit();
    isInitialized(true);
  }

  fetchData(keyword) async {
    isLoading(true);
    search.value = null;
    final searchList = await searchUseCase.execute(keyword);
    search.value = searchList;
    isLoading(false);
  }

  fetchData2(keyword) async {
    isLoading(true);
    search2.value = null;
    final searchList = await searchUseCase.execute(keyword);
    search2.value = searchList;
    isLoading(false);
  }

  fetchDataInit(keyword) async {
    isLoading(true);
    search3.value = null;
    final searchList = await searchUseCase.execute(keyword);
    search3.value = searchList;
    isLoading(false);
  }
}
