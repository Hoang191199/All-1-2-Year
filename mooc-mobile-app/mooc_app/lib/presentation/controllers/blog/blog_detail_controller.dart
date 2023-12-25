import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/blog_details_info.dart';
import 'package:mooc_app/domain/usecases/blog_detail_use_case.dart';

class BlogDetailController extends GetxController {
  BlogDetailController(this.blogDetailUseCase);
  final BlogDetailUseCase blogDetailUseCase;
  var isLoadMore = false;
  var fetch = Rx<BlogDetailInfo?>(null);
  final isLoading = false.obs;
  final isInitialized = false.obs;


  fetchData(String slug) async {
    isLoading(true);
    final fetchList = await blogDetailUseCase.execute(slug);
    fetch.value = fetchList.data!;
    isInitialized.value = true;
    isLoading(false);
  }
}
