import 'package:dartz/dartz.dart';
import 'package:mooc_app/app/core/usecases/pram_usecase.dart';
import 'package:mooc_app/domain/entities/coupon_code_response_data.dart';
import 'package:mooc_app/domain/entities/response_data_object.dart';
import 'package:mooc_app/domain/repositories/course_repository.dart';

class CouponCodeUseCase extends ParamUseCase<ResponseDataObject<CouponCodeResponseData>, Tuple5<String, String, List<int>, int, String> > {
  CouponCodeUseCase(this.courseRepository);

  final CourseRepository courseRepository;

  @override
  Future<ResponseDataObject<CouponCodeResponseData>> execute(Tuple5 params) {
    return courseRepository.applyCouponCode(params.value1, params.value2, params.value3, params.value4, params.value5);
  }
  
}