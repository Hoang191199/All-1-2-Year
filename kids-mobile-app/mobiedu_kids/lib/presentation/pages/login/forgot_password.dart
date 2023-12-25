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

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

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
              child: Text("Quên mật khẩu",
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
                "Nhập email để nhận mã xác nhận",
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
                label: "Nhập email",
                code: 'email',
                inputController: loginController.emailInputController
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
                          "Gửi",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                onPressed: () {
                  handlePressConfirm(context);
                },
              )
            )
          ],
        ),
      )
    );
  }

  void handlePressConfirm(BuildContext context) async {
    var email = loginController.emailInputController.text.trim();
    if (!isValidEmail(email)) {
      showAlertDialog(context, 'info'.tr, 'input-mail-valid'.tr);
    } else {
      try {
        await passwordController.forget(email);
        if (passwordController.responseforgotData.value?.code == 200) {
          showSnackbar(SnackbarType.success, "success".tr, passwordController.responseforgotData.value?.message ?? "");
          loginController.bottomStatus.value = 1;
        } else {
          showSnackbar(SnackbarType.error, "error".tr, passwordController.responseforgotData.value?.message ?? "");
        }
      } catch (error) {
        loginController.setLogingComplete();
        showSnackbar(SnackbarType.error, 'error'.tr, passwordController.responseforgotData.value?.message ?? "");
      }
    }
  }
}
