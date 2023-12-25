import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/domain/entities/course_paging.dart';
import 'package:mooc_app/domain/usecases/course_list_use_case.dart';

class CourseListController extends GetxController {
  CourseListController(this.courseListUseCase, this.coursekwListUseCase);

  final CourseListUseCase courseListUseCase;
  final CourseListUseCase coursekwListUseCase;
  int currentPage = 0;
  int pageSize = 12;
  var isLoadMore = false;
  var paging = Rx<CoursePaging?>(null);
  var pagingkw = Rx<CoursePaging?>(null);

  final isLoading = false.obs;
  var coursesData = RxList<Course?>([]);
  var courseskwData = RxList<Course?>([]);

  @override
  void onInit() async {
    // fetchData('');
    super.onInit();
  }

  fetchData(String category) async {
    isLoading(true);
    currentPage = 0;
    coursesData.value = [];
    final courseList = await courseListUseCase.execute(Tuple3(category, currentPage, pageSize));
    coursesData.assignAll(courseList.item ?? []);
    paging.value = courseList;
    isLoading(false);
  }

  fetchkwData(String keyword) async {
    isLoading(true);
    currentPage = 0;
    courseskwData.value = [];
    final coursekwList = await coursekwListUseCase.execute2(Tuple3(keyword, currentPage, pageSize));
    courseskwData.assignAll(coursekwList.item ?? []);
    pagingkw.value = coursekwList;
    isLoading(false);
  }

  loadMore(String category) async {
    final total = paging.value?.total ?? 0;
    if (total / pageSize <= currentPage) return;
    if (isLoadMore) return;
    isLoadMore = true;
    currentPage += 1;
    final courseList = await courseListUseCase.execute(Tuple3(category, currentPage, pageSize));
    coursesData.addAll(courseList.item ?? []);
    paging.value?.total = courseList.total;
    isLoadMore = false;
  }

  loadkwMore(String keyword) async {
    final total = pagingkw.value?.total ?? 0;
    if (total / pageSize <= currentPage) return;
    if (isLoadMore) return;
    isLoadMore = true;
    currentPage += 1;
    final coursekwList = await coursekwListUseCase.execute2(Tuple3(keyword, currentPage, pageSize));
    courseskwData.addAll(coursekwList.item ?? []);
    pagingkw.value?.total = coursekwList.total;
    isLoadMore = false;
  }
}