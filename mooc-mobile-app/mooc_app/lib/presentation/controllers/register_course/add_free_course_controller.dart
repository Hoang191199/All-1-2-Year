import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/response_data.dart';
import 'package:mooc_app/domain/usecases/add_free_course_use_case.dart';

class AddFreeCourseController extends GetxController {
  AddFreeCourseController(this.addFreeCourseUseCase);

  final AddFreeCourseUseCase addFreeCourseUseCase;

  final isLoading = false.obs;
  var responseData = Rx<ResponseData?>(null);

  addFreeCourse(int idCourse) async {
    isLoading(true);
    final responseRegister = await addFreeCourseUseCase.execute(Tuple2("course", idCourse));
    responseData.value = responseRegister;
    isLoading(false);
  }

  addFreePackage(int idPackage) async {
    isLoading(true);
    final responseRegister = await addFreeCourseUseCase.execute(Tuple2("package", idPackage));
    responseData.value = responseRegister;
    isLoading(false);
  }
}