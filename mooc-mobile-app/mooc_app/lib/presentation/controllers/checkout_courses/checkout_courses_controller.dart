import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/response_data.dart';
import 'package:mooc_app/domain/usecases/checkout_courses_use_case.dart';
import 'package:mooc_app/domain/usecases/validate_checkout_use_case.dart';

class CheckoutCoursesController extends GetxController {
  CheckoutCoursesController(
    this.checkoutCoursesUseCase,
    this.validateCheckoutUseCase
  );

  final CheckoutCoursesUseCase checkoutCoursesUseCase;
  final ValidateCheckoutUseCase validateCheckoutUseCase;

  final method = ''.obs;
  final isLoading = false.obs;
  var responseData = Rx<ResponseData?>(null);
  var responseValidate = Rx<ResponseData?>(null);

  changeMethod(String type) {
    method.value = type;
  }
  
  checkoutCourses(String fullname, String phone, String email, String paymentType, String address, List<int> idCourses, int idPackage, String couponCode) async {
    isLoading(true);
    final responseCheckout = await checkoutCoursesUseCase.execute(Tuple8(fullname, phone, email, paymentType, address, idCourses, idPackage, couponCode));
    responseData.value = responseCheckout;
    isLoading(false);
  }

  setLoadingComplete() {
    isLoading(false);
  }

  validateCheckout(String dataValidateCheckout) async {
    final response = await validateCheckoutUseCase.execute(dataValidateCheckout);
    responseValidate.value = response;
  }
}