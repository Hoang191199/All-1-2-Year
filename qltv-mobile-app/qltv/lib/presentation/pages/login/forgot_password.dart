import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/config/app_common.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';
import 'package:qltv/presentation/controllers/password/password_controller.dart';
import 'package:qltv/presentation/pages/login/reset_password.dart';
import 'package:qltv/presentation/widgets/login_form_input_item.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final loginController = Get.find<LoginController>();
  final pwd = Get.find<PasswordController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Container(
          padding: EdgeInsets.only(
              top: statusBarHeight,
              bottom: bottomPadding + 20.0,
              left: 16.0,
              right: 16.0),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                  child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Divider(
                                color: HexColor('D9E9F2'),
                                thickness: 2.0,
                                indent: 0.0,
                                endIndent: 10.0)),
                        Text('forget-password'.tr,
                            style: GoogleFonts.kantumruy(
                                textStyle: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryBlue))),
                        Expanded(
                            child: Divider(
                                color: HexColor('D9E9F2'),
                                thickness: 2.0,
                                indent: 10.0,
                                endIndent: 0.0)),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      'input-mail-description'.tr,
                      style: GoogleFonts.kantumruy(
                          textStyle: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40.0),
                    child: LoginFormInputItem(
                        label: 'input-mail'.tr,
                        code: 'email',
                        inputController: loginController.emailInputController),
                  ),
                ],
              )),
              Container(
                width: widthScreen,
                height: 48.0,
                margin: const EdgeInsets.only(top: 40.0),
                child: ElevatedButton(
                  onPressed: () {
                    handlePressConfirm(context);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      elevation: 0.0,
                      backgroundColor: AppColors.primaryBlue,
                      textStyle: GoogleFonts.kantumruy(
                          textStyle: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white))),
                  child: Text('confirm'.tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handlePressConfirm(BuildContext context) async {
    var email = loginController.emailInputController.text.trim();
    if (!isValidEmail(email)) {
      showAlertDialog(context, 'info'.tr, 'input-mail-valid'.tr);
    } else {
      await pwd.forget(email);
      if (pwd.responseforgotData.value?.message == "Gửi otp thành công" &&
          pwd.responseforgotData.value?.error == false) {
        showSnackbar(SnackbarType.success, "success".tr, "otp-sent".tr);
        Get.to(() => ResetPasswordPage(email: email));
      } else if (pwd.responseforgotData.value?.message ==
              "Tài khoản không tồn tại" &&
          pwd.responseforgotData.value?.error == true) {
        showSnackbar(SnackbarType.error, "error".tr, "account-non-exist".tr);
      } else {
        showSnackbar(SnackbarType.error, "error".tr, "error-message".tr);
      }
    }
    loginController.emailInputController.text = '';
  }
}
