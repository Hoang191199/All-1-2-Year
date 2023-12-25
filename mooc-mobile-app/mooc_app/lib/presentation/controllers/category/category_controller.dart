import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/category.dart';
import 'package:mooc_app/domain/entities/category_response.dart';
import 'package:mooc_app/domain/usecases/category_use_case.dart';

class CategoryController extends GetxController {
  CategoryController(this.categoryUseCase);

  final CategoryUseCase categoryUseCase;
  var categoryResponse = Rx<CategoryResponse?>(null);
  var categoriesData = RxList<Category>([]);
  final page = 0.obs;
  final perpage = 10.obs;
  final isLoading = false.obs;

  @override
  void onInit() async {
    await fetchData();
    await fetchMore();
    super.onInit();
  }

  fetchData() async {
    isLoading(true);
    page.value = 0;
    final response =
        await categoryUseCase.execute(Tuple2(page.value, perpage.value));
    categoryResponse.value = response;
    categoriesData.assignAll(response.items ?? []);
  }

  fetchMore() async {
    final total = categoryResponse.value?.total ?? 0;
    if (total > perpage.value) {
      for (var i = page.value + 1; i < (total ~/ perpage.value) + 1; i++) {
        final res =
            await categoryUseCase.execute(Tuple2(page.value, perpage.value));
        categoryResponse.value = res;
        categoriesData.addAll(res.items ?? []);
      }
    }
    isLoading(false);
  }

  // flatten(res){
  //   if(res.items != null && res.children == null && res.items.length > 0 ) {
  //     temp.addAll(res.items);
  //     for (var i = 0; i < res.items.length; i++) {
  //       flatten(res.items[i]);
  //     }
  //   }
  //   else if(res.items == null && res.children != null && res.children.length > 0 ) {
  //     temp.addAll(res.children);
  //     for (var j = 0; j < res.children.length; j++) {
  //       flatten(res.items[j]);
  //     }
  //   }
  // }
}
