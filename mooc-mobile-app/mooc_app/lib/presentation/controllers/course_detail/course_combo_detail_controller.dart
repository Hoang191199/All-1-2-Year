import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/course_combo.dart';
import 'package:mooc_app/domain/entities/course_combo_detail.dart';
import 'package:mooc_app/domain/usecases/course_combo_detail_use_case.dart';

class CourseComboDetailController extends GetxController {
  CourseComboDetailController(this.courseComboDetailUseCase);

  final CourseComboDetailUseCase courseComboDetailUseCase;

  var courseComboDetail = Rx<CourseComboDetail?>(null);
  final isLoading = false.obs;
  var courseComboData = Rx<CourseCombo?>(null);
  var courseFullSlug = Rx<CourseComboDetail?>(null);
  final isInitialized = false.obs;
  var courseFullSlugData = Rx<CourseCombo?>(null);

  fetchData(int id, String slug) async {
    isLoading(true);
    await Future.delayed(const Duration(milliseconds: 200));
    final dataResponse =
        await courseComboDetailUseCase.execute(Tuple2(id, slug));
    courseComboDetail.value = dataResponse;
    courseComboData.value = dataResponse.data;
    isLoading(false);
  }

    fetchDataCourseFullSlug(String slug) async {
    isLoading(true);
    await Future.delayed(const Duration(milliseconds: 200));
    final dataResponse = await courseComboDetailUseCase.execute2(slug);
    courseFullSlug.value = dataResponse;
    courseFullSlugData.value = dataResponse.data;
    isLoading(false);
  }
}
