import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/coupon_code_response_data.dart';
import 'package:mooc_app/domain/entities/response_data_object.dart';
import 'package:mooc_app/domain/usecases/coupon_code_use_case.dart';

class CouponCodeController extends GetxController {
  CouponCodeController(this.couponCodeUseCase);

  final CouponCodeUseCase couponCodeUseCase;

  final isLoading = false.obs;
  var responseData = Rx<ResponseDataObject<CouponCodeResponseData>?>(null);
  var couponCodeData = Rx<CouponCodeResponseData?>(null);

  applyCouponCode(String paymentType, String address, List<int> idCourses, int idPackage, String couponCode) async {
    isLoading(true);
    final responseApply = await couponCodeUseCase.execute(Tuple5(paymentType, address, idCourses, idPackage, couponCode));
    responseData.value = responseApply;
    couponCodeData.value = responseApply.data;
    isLoading(false);
  }

  setLoadingComplete() {
    isLoading(false);
  }
}