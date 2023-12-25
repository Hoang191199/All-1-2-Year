import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/domain/entities/response_data.dart';
import 'package:mobiedu_kids/domain/usecases/password_use_case.dart';

class PasswordController extends GetxController {
  PasswordController(this.forgetpasswordUseCase, this.retrievepasswordUseCase);

  final ForgetPasswordUseCase forgetpasswordUseCase;
  final RetrievePasswordUseCase retrievepasswordUseCase;

  var responseforgotData = Rx<ResponseData?>(null);
  var responsechangedData = Rx<ResponseData?>(null);

  retrieve(String email, String otp, String newpass, String rePass) async {
    final response = await retrievepasswordUseCase
        .execute(Tuple4(email, otp, newpass, rePass));
    responsechangedData.value = response;
  }

  forget(String email) async {
    final response = await forgetpasswordUseCase.execute(email);
    responseforgotData.value = response;
  }
}
