import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/response_data.dart';
import 'package:mooc_app/domain/usecases/active_course_use_case.dart';

class ActiveCourseController extends GetxController {
  ActiveCourseController(this.activeCourseUseCase);

  final ActiveCourseUseCase activeCourseUseCase;

  final isLoading = false.obs;
  var responseData = Rx<ResponseData?>(null);

  activeCourse(String activeCode) async {
    isLoading(true);
    final responseActive = await activeCourseUseCase.execute(activeCode);
    responseData.value = responseActive;
    isLoading(false);
  }

  setLoadingComplete() {
    isLoading(false);
  }
}