import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/complete_lesson_response_data.dart';
import 'package:mooc_app/domain/entities/response_data_object.dart';
import 'package:mooc_app/domain/usecases/course_lesson_use_case.dart';

class CourseLessonController extends GetxController {
  CourseLessonController(this.courseLessonUseCase);

  final CourseLessonUseCase courseLessonUseCase;

  final isLoading = false.obs;
  var responseData = Rx<ResponseDataObject<CompleteLessonResponseData>?>(null);

  completeLesson(int idLesson, int idCourse, int viewPercent) async {
    isLoading(true);
    final response = await courseLessonUseCase.execute(Tuple3(idLesson, idCourse, viewPercent));
    responseData.value = response;
    isLoading(false);
  }
}