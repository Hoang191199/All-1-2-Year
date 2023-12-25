import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/domain/entities/response_data_object.dart';
import 'package:mooc_app/domain/usecases/course_detail_use_case.dart';

class CourseDetailController extends GetxController {
  CourseDetailController(this.courseDetailUseCase);

  final CourseDetailUseCase courseDetailUseCase;

  final isLoading = false.obs;
  var reponseCourseDetail = Rx<ResponseDataObject<Course>?>(null);
  var courseData = Rx<Course?>(null);
  
  fetchData(int idCourse, String slug) async {
    isLoading(true);
    await Future.delayed(const Duration(milliseconds: 200));
    final dataResponse = await courseDetailUseCase.execute(Tuple2(idCourse, slug));
    reponseCourseDetail.value = dataResponse;
    courseData.value = dataResponse.data;
    isLoading(false);
  }
}