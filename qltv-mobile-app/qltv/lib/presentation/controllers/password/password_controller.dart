import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:qltv/domain/entities/response_data.dart';
import 'package:qltv/domain/usecases/password_use_case.dart';
import 'package:qltv/domain/usecases/put_otp_use_case.dart';

class PasswordController extends GetxController {
  PasswordController(this.forgetUseCase, this.putotpUseCase);

  final ForgotPasswordUseCase forgetUseCase;
  final PutOTPUseCase putotpUseCase;

  var responseforgotData = Rx<ResponseData?>(null);
  var responsechangedData = Rx<ResponseData?>(null);

  putOTP(String email, String otp, String newpass) async {
    final response = await putotpUseCase.execute(Tuple3(email, otp, newpass));
    responsechangedData.value = response;
  }

  forget(String email) async {
    final response = await forgetUseCase.execute(email);
    responseforgotData.value = response;
  }
}
