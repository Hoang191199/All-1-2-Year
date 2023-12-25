import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/course.dart';

import '../../../domain/usecases/search_recommmend_use_case.dart';

class RecommendController extends GetxController {
  RecommendController(this.searchRCMUseCase);

  final SearchRCMUseCase searchRCMUseCase;
  var isLoadMore = false;
  var search = Rx<Course?>(null);
  var search2 = Rx<Course?>(null);
  var search3 = Rx<Course?>(null);
  final isLoading = false.obs;

  @override
  void onInit() async {
    fetchDataInit();
    super.onInit();
  }

  fetchData() async {
    isLoading(true);
    search.value = null;
    final searchList = await searchRCMUseCase.execute();
    search.value = searchList;
    isLoading(false);
  }

  fetchData2() async {
    isLoading(true);
    search2.value = null;
    final searchList = await searchRCMUseCase.execute();
    search2.value = searchList;
    isLoading(false);
  }

  fetchDataInit() async {
    isLoading(true);
    search3.value = null;
    final searchList = await searchRCMUseCase.execute();
    search3.value = searchList;
    isLoading(false);
  }
}
