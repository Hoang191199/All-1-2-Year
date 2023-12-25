import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/config/app_common.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';
import 'package:qltv/presentation/controllers/password/password_controller.dart';
import 'package:qltv/presentation/pages/login/login_page.dart';
import 'package:qltv/presentation/widgets/login_form_input_item.dart';
import 'package:qltv/app/config/app_constants.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({
    super.key,
    required this.email,
  });

  final String email;

  final loginController = Get.find<LoginController>();
  final pwd = Get.find<PasswordController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return WillPopScope(
      onWillPop: () async {
        Get.back();
        loginController.clearResetPasswordInfo();
        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          resizeToAvoidBottomInset: false,
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
                          Text('reset-password'.tr,
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
                        'reset-password-description'.tr,
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
                          label: 'input-otp'.tr,
                          code: 'otp',
                          inputController: loginController.otpInputController),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: LoginFormInputItem(
                          label: 'input-new-password'.tr,
                          code: 'new_password',
                          inputController:
                              loginController.newPasswordInputController),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0, left: 24.0),
                      child: Row(
                        children: [
                          Obx(() => loginController.isPassLeastOneDigit.value
                              ? Icon(CupertinoIcons.checkmark,
                                  size: 14.0, color: HexColor('167820'))
                              : const Icon(CupertinoIcons.xmark,
                                  size: 14.0, color: Colors.red)),
                          const SizedBox(width: 10.0),
                          Text('constraint-1'.tr,
                              style: GoogleFonts.kantumruy(
                                  textStyle: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black)))
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0, left: 24.0),
                      child: Row(
                        children: [
                          Obx(() => loginController.isPassLeastEightChar.value
                              ? Icon(CupertinoIcons.checkmark,
                                  size: 14.0, color: HexColor('167820'))
                              : const Icon(CupertinoIcons.xmark,
                                  size: 14.0, color: Colors.red)),
                          const SizedBox(width: 10.0),
                          Text('constraint-2'.tr,
                              style: GoogleFonts.kantumruy(
                                  textStyle: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black)))
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: LoginFormInputItem(
                          label: 'reinput-password'.tr,
                          code: 're_password',
                          inputController:
                              loginController.rePasswordInputController),
                    ),
                    Obx(() => loginController.isSameNewPass.value
                        ? Container()
                        : Container(
                            margin: const EdgeInsets.only(top: 5.0, left: 24.0),
                            child: Row(children: [
                              const Icon(CupertinoIcons.xmark,
                                  size: 14.0, color: Colors.red),
                              const SizedBox(width: 10.0),
                              Text('password-unmatch'.tr,
                                  style: GoogleFonts.kantumruy(
                                      textStyle: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)))
                            ]),
                          ))
                  ],
                )),
                Container(
                  width: widthScreen,
                  height: 48.0,
                  margin: const EdgeInsets.only(top: 40.0),
                  child: ElevatedButton(
                    onPressed: () {
                      handlePressSave(context);
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
                    child: Text('save'.tr),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handlePressSave(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 200));
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
        if (loginController.isPassLeastOneDigit.value &&
            loginController.isPassLeastEightChar.value) {
          if (rePassword.isEmpty) {
            if (context.mounted) {
              showAlertDialog(
                  context, 'info'.tr, 'reinput-password-message'.tr);
            }
          } else {
            if (newPassword != rePassword) {
              if (context.mounted) {
                showAlertDialog(
                    context, 'info'.tr, 'password-unmatch'.tr);
              }
            } else {
              if (context.mounted) {
                await pwd.putOTP(email, otp, newPassword);
                if (pwd.responsechangedData.value?.message == "Ok" &&
                    pwd.responsechangedData.value?.error == false) {
                  showSnackbar(SnackbarType.success, "success".tr,
                      "update-password-success".tr);
                  loginController.clearResetPasswordInfo();
                  Get.off(() => LoginPage());
                } else if (pwd.responsechangedData.value?.message ==
                        "Otp không đúng hoặc đã hết hạn" &&
                    pwd.responsechangedData.value?.error == true) {
                  showSnackbar(
                      SnackbarType.error, "error".tr, "otp-expired".tr);
                } else {
                  showSnackbar(
                      SnackbarType.error, "error".tr, "error-message".tr);
                }
              }
            }
          }
        } else {
          if (context.mounted) {
            showAlertDialog(context, 'info'.tr, 'password-valid-message'.tr);
          }
        }
      }
    }
  }
}
