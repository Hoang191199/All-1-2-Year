import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/domain/entities/course_paging.dart';
import 'package:mooc_app/domain/usecases/course_recommend_use_case.dart';

class CourseRecommendController extends GetxController {
  CourseRecommendController(this.courseRecommendUseCase);

  final CourseRecommendUseCase courseRecommendUseCase;

  int currentPage = 0;
  int pageSize = 12;
  var isLoadMore = false;
  var paging = Rx<CoursePaging?>(null);

  final isLoading = false.obs;
  var coursesData = RxList<Course>([]);

  @override
  void onInit() async {
    fetchData(0, 6);
    super.onInit();
  }

  fetchData(int? page, int? limit) async {
    isLoading(true);
    final response = await courseRecommendUseCase.execute(Tuple2(page ?? currentPage, limit ?? pageSize));
    coursesData.assignAll(response.item ?? []);
    paging.value = response;
    isLoading(false);
  }

  loadMore() async {
    final total = paging.value?.total ?? 0;
    if (total / pageSize <= currentPage) return;
    if (isLoadMore) return;
    isLoadMore = true;
    currentPage += 1;
    final response = await courseRecommendUseCase.execute(Tuple2(currentPage, pageSize));
    coursesData.addAll(response.item ?? []);
    paging.value?.total = response.total;
    isLoadMore = false;
  }
}