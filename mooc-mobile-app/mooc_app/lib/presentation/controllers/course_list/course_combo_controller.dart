import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/course_combo.dart';
import 'package:mooc_app/domain/entities/course_combo_paging.dart';
import 'package:mooc_app/domain/usecases/course_combo_use_case.dart';

class CourseComboController extends GetxController {
  CourseComboController(this.courseComboUseCase, this.courseSearchData);

  final CourseComboUseCase courseComboUseCase;
  final CourseComboUseCase courseSearchData;
  int currentPage = 0;
  int pageSize = 12;
  var isLoadMore = false;
  var paging = Rx<CourseComboPaging?>(null);

  final isLoading = false.obs;
  var coursesData = RxList<CourseCombo?>([]);
  
  @override
  void onInit() async {
    // fetchData('');
    super.onInit();
  }

  fetchSearchData(String keyword) async {
    isLoading(true);
    currentPage = 0;
    coursesData.value = [];
    final courseSearchList = await courseSearchData.execute2(Tuple3(keyword, currentPage, pageSize));
    coursesData.assignAll(courseSearchList.item);
    paging.value = courseSearchList;
    isLoading(false);
  }

  fetchData() async {
    isLoading(true);
    final courseList = await courseComboUseCase.execute(Tuple3('',currentPage, pageSize));
    coursesData.assignAll(courseList.item);
    paging.value = courseList;
    isLoading(false);
  }

  loadMore() async {
    final total = paging.value?.total ?? 0;
    if (total / pageSize <= currentPage) return;
    if (isLoadMore) return;
    isLoadMore = true;
    currentPage += 1;
    final courseList =
        await courseComboUseCase.execute(Tuple3('',currentPage, pageSize));
    coursesData.addAll(courseList.item);
    paging.value?.total = courseList.total;
    isLoadMore = false;
  }
}
