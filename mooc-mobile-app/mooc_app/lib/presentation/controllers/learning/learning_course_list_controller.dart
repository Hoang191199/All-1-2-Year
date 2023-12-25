import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/paid_course_details.dart';
import 'package:mooc_app/domain/entities/response_data_array_object.dart';
import 'package:mooc_app/domain/usecases/learning_course_list_use_case.dart';

class LearningCourseListController extends GetxController {
  LearningCourseListController(this.learningCourseListUseCase);

  final LearningCourseListUseCase learningCourseListUseCase;
  // final auth = Get.find<AuthController>();
  int currentPage = 0;
  int pageSize = 10;
  final isLoading = false.obs;
  var isLoadMore = false;
  var responseData = Rx<ResponseDataArrayObject<PaidCourseDetails>?>(null);
  var coursesData = RxList<PaidCourseDetails?>([]);

  fetchData() async {
    isLoading(true);
    currentPage = 0;
    coursesData.value = [];
    final response = await learningCourseListUseCase.execute(Tuple2(currentPage, pageSize));
    responseData.value = response;
    coursesData.assignAll(response.data ?? []);
    isLoading(false);
  }

  loadMore() async {
    final total = responseData.value?.pagination?.total ?? 0;
    if (total / pageSize <= currentPage) return;
    if (isLoadMore) return;
    isLoadMore = true;
    currentPage += 1;
    final response = await learningCourseListUseCase.execute(Tuple2(currentPage, pageSize));
    responseData.value = response;
    coursesData.addAll(response.data ?? []);
    isLoadMore = false;
  }

}