import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/presentation/controllers/login/log_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/password/password_controller.dart';
import 'package:mobiedu_kids/presentation/pages/login/login_form_input_item_alt.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({
    super.key,
  });

  final loginController = Get.find<LogController>();
  final passwordController = Get.find<PasswordController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Center(
              child: Text(
                "Đặt lại mật khẩu",
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: AppColors.primary,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700
                  )
                ),
              ),
            ),
            Center(
              child: Text(
                "Nhập mã xác nhận và nhập mật khẩu mới",
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.raleway(
                  textStyle: const TextStyle(
                    fontSize: 15.0, 
                    color: Colors.black
                  )
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: LoginFormInputItem2(
                label: "Nhập mã xác nhận",
                code: 'otp',
                inputController: loginController.otpInputController
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: LoginFormInputItem2(
                label: "Nhập mật khẩu mới",
                code: 'new_password',
                inputController: loginController.newPasswordInputController
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: LoginFormInputItem2(
                label: "Nhập lại mật khẩu",
                code: 're_password',
                inputController: loginController.rePasswordInputController
              ),
            ),
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.only(left: 28, right: 28, bottom: 20),
              child: CupertinoButton(
                pressedOpacity: 0.65,
                color: AppColors.pink,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                alignment: Alignment.centerLeft,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Lưu",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                onPressed: () {
                  handlePressSave(context);
                },
              )
            )
          ],
        ),
      )
    );
  }

  Future<void> handlePressSave(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 200));
    var email = loginController.emailInputController.text.trim();
    var otp = loginController.otpInputController.text.trim();
    var newPassword = loginController.newPasswordInputController.text.trim();
    var rePassword = loginController.rePasswordInputController.text.trim();
    if (otp.isEmpty) {
      if (context.mounted) {
        showAlertDialog(context, 'info'.tr, 'input-otp-message'.tr);
      }
    } else {
      if (newPassword.isEmpty) {
        if (context.mounted) {
          showAlertDialog(context, 'info'.tr, 'input-new-password-message'.tr);
        }
      } else {
        if (rePassword.isEmpty) {
          if (context.mounted) {
            showAlertDialog(context, 'info'.tr, 'reinput-password-message'.tr);
          }
        } else {
          if (newPassword != rePassword) {
            if (context.mounted) {
              showAlertDialog(context, 'info'.tr, 'password-unmatch-valid'.tr);
            }
          } else {
            if (context.mounted) {
              await passwordController.retrieve(email, otp, newPassword, rePassword);
              if (passwordController.responsechangedData.value?.code == 200) {
                showSnackbar(
                  SnackbarType.success,
                  "success".tr,
                  'Mã thông báo được gửi đến email của bạn'
                );
                loginController.bottomStatus.value = 2;
              } else {
                showSnackbar(
                  SnackbarType.error,
                  "error".tr,
                  'Vui lòng thử lại!'
                );
              }
            }
          }
        }
      }
    }
    loginController.emailInputController.text = '';
    loginController.otpInputController.text = '';
    loginController.newPasswordInputController.text = '';
    loginController.rePasswordInputController.text = '';
  }
}
