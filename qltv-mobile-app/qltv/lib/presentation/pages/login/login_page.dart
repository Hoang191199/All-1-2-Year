import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/config/app_common.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/app/extensions/color.dart';
import 'package:qltv/presentation/controllers/bookcase/bookcase_controller.dart';
import 'package:qltv/presentation/controllers/brrow/borrow_controller.dart';
import 'package:qltv/presentation/controllers/carousel_controller.dart';
import 'package:qltv/presentation/controllers/home/home_controller.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';
import 'package:qltv/presentation/controllers/password/password_binding.dart';
import 'package:qltv/presentation/controllers/profile/profile_controller.dart';
import 'package:qltv/presentation/controllers/search/search_controller.dart'
    as search;
import 'package:qltv/presentation/pages/init/init_page.dart';
import 'package:qltv/presentation/pages/login/forgot_password.dart';
import 'package:qltv/presentation/widgets/login_form_input_item.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    double bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
            backgroundColor: AppColors.background,
            resizeToAvoidBottomInset: false,
            body: Container(
              padding: EdgeInsets.only(
                  bottom: bottomPadding + 20.0, left: 28.0, right: 28.0),
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                  child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    reverse: true,
                    padding: EdgeInsets.only(bottom: bottomInsets),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/login.png',
                          width: 314.0,
                          height: 314.0,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                      color: HexColor('D9E9F2'),
                                      thickness: 2.0,
                                      indent: 0.0,
                                      endIndent: 10.0)),
                              Text('log-in'.tr,
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
                          margin: const EdgeInsets.only(top: 40.0),
                          child: LoginFormInputItem(
                              label: 'username'.tr,
                              code: 'username',
                              inputController:
                                  loginController.usernameInputController),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          child: LoginFormInputItem(
                              label: 'password'.tr,
                              code: 'password',
                              inputController:
                                  loginController.passwordInputController),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  loginController.changeSaveAccount();
                                },
                                child: Row(
                                  children: [
                                    Obx(
                                      () => loginController.isSaveAccount.value
                                          ? Icon(
                                              CupertinoIcons
                                                  .checkmark_square_fill,
                                              color: AppColors.primaryBlue,
                                              size: 18.0)
                                          : Icon(CupertinoIcons.square,
                                              color: AppColors.primaryBlue,
                                              size: 18.0),
                                    ),
                                    const SizedBox(width: 6.0),
                                    Text('save-password'.tr,
                                        style: GoogleFonts.kantumruy(
                                            textStyle: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryBlue,
                                                fontStyle: FontStyle.italic))),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  PasswordBinding().dependencies();
                                  Get.to(() => ForgotPasswordPage());
                                },
                                child: Text('${'forget-password'.tr} ?',
                                    style: GoogleFonts.kantumruy(
                                        textStyle: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.primaryBlue,
                                            fontStyle: FontStyle.italic))),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
                  Container(
                    width: widthScreen,
                    height: 48.0,
                    margin: const EdgeInsets.only(top: 40.0),
                    child: Obx(() => ElevatedButton(
                          onPressed: loginController.isLoging.value
                              ? null
                              : () {
                                  handlePressLogin(context);
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
                          child: Text('log-in'.tr),
                        )),
                  ),
                ],
              )),
            )),
      ),
    );
  }

  Future<void> handlePressLogin(BuildContext context) async {
    final username = loginController.usernameInputController.text;
    final password = loginController.passwordInputController.text;
    if (username.isEmpty || password.isEmpty) {
      showAlertDialog(context, 'info'.tr, 'input-valid-message'.tr);
    } else {
      try {
        await loginController.login(username, password);
        if (!(loginController.responseData.value?.error ?? false)) {
          if (loginController.userData.value?.role == UserRole.teacher ||
              loginController.userData.value?.role == UserRole.student) {
            if (!loginController.isSaveAccount.value) {
              loginController.usernameInputController.clear();
              loginController.passwordInputController.clear();
            }
            showSnackbar(
                SnackbarType.success, 'log-in'.tr, 'log-in-success'.tr);
            Get.delete<ProfileController>();
            Get.delete<HomeController>();
            Get.delete<BookcaseController>();
            Get.delete<BorrowController>();
            Get.delete<search.SearchController>();
            Get.delete<CarouselSlideController>();
            Get.off(() => InitPage());
          } else {
            showSnackbar(SnackbarType.error, 'log-in'.tr, 'auth-forbidden'.tr);
          }
        } else {
          showSnackbar(
              SnackbarType.error,
              'log-in'.tr,
              getMessageData(loginController.responseData.value?.message) ??
                  'log-in-failure'.tr);
        }
      } catch (error) {
        loginController.setLogingComplete();
        showSnackbar(SnackbarType.error, 'error'.tr, 'error-message'.tr);
      }
    }
  }

  String? getMessageData(String? message) {
    if (message?.isEmpty ?? false) {
      return null;
    } else {
      if (message == 'Tài khoản không tồn tại') {
        return 'log-in-not-exist'.tr;
      } else if (message == 'Mật khẩu hoặc tài khoản không chính xác') {
        return 'log-in-incorrect'.tr;
      } else {
        return null;
      }
    }
  }
}
