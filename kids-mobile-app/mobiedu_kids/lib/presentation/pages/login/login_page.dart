import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/login/log_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/password/password_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_controller.dart';
import 'package:mobiedu_kids/presentation/pages/chose/chose_school.dart';
import 'package:mobiedu_kids/presentation/pages/login/forgot_password.dart';
import 'package:mobiedu_kids/presentation/pages/login/login_form_input_item.dart';
import 'package:mobiedu_kids/presentation/pages/login/reset_password.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final loginController = Get.find<LogController>();
  final store = Get.find<LocalStorageService>();

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
          resizeToAvoidBottomInset: loginController.isShowModalBottom.value,
          body: AnimatedContainer(
            curve: Curves.easeOutQuart,
            duration: const Duration(milliseconds: 500),
            padding: EdgeInsets.only(bottom: bottomPadding + 20.0, left: 28.0, right: 28.0),
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_splash.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        reverse: !loginController.isShowModalBottom.value,
                        padding: EdgeInsets.only(bottom: bottomInsets),
                        child: AutofillGroup(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/child.png',
                                width: 314.0,
                                height: 314.0,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 40.0),
                                child: LoginFormInputItem(
                                  label: "Email",
                                  code: 'username',
                                  inputController: loginController.usernameInputController
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20.0),
                                child: LoginFormInputItem(
                                  label: "Mật khẩu",
                                  code: 'password',
                                  inputController: loginController.passwordInputController
                                ),
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
                                            () => loginController.isSaveAccount.value ? 
                                            Icon(
                                              CupertinoIcons.checkmark_square_fill,
                                              color: AppColors.primary,
                                              size: 18.0
                                            ) : 
                                            Icon(
                                              CupertinoIcons.square,
                                              color: AppColors.primary,
                                              size: 18.0
                                            ),
                                          ),
                                          const SizedBox(width: 6.0),
                                          Text("Lưu mật khẩu",
                                            style: GoogleFonts.raleway(
                                              textStyle: GoogleFonts.raleway(
                                                textStyle:TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: 17.0,
                                                )
                                              )
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        loginController.isShowModalBottom.value = true;
                                        PasswordBinding().dependencies();
                                        await showModalBottomSheet<void>(
                                          showDragHandle: true,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius:BorderRadius.vertical(top: Radius.circular(25.0)),
                                          ),
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Obx(
                                              () => loginController.bottomStatus.value == 0 ? ForgotPasswordPage()
                                                : loginController.bottomStatus.value == 1 ? ResetPasswordPage() : 
                                                  Padding(
                                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                    child: SingleChildScrollView(
                                                      physics: const ClampingScrollPhysics(),
                                                      child: Column(
                                                        children: [
                                                          Stack(
                                                            alignment: AlignmentDirectional.center,
                                                            children: [
                                                              Image.asset('assets/images/Ellipse 2.png',
                                                                width: 150.0,
                                                                height: 150.0,
                                                                fit: BoxFit.cover,
                                                              ),
                                                              Image.asset('assets/images/Ellipse 1.png',
                                                                width: 100.0,
                                                                height: 100.0,
                                                                fit: BoxFit.cover,
                                                              ),
                                                              Image.asset('assets/images/verified.png',
                                                                width: 50.0,
                                                                height: 50.0,
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 50
                                                          ),
                                                          Center(
                                                            child: Text(
                                                              "Mật khẩu đã được thay đổi thành công",
                                                              overflow: TextOverflow.ellipsis,
                                                              style: GoogleFonts.raleway(
                                                                textStyle: const TextStyle(
                                                                  fontSize: 15.0,
                                                                  color: Colors.black
                                                                )
                                                              ),
                                                            ),
                                                          ),
                                                      const SizedBox(
                                                        height: 50,
                                                      ),
                                                      Container(
                                                        padding: const EdgeInsets.only(
                                                          left: 28,
                                                          right: 28,
                                                          bottom: 20
                                                        ),
                                                        child: CupertinoButton(
                                                          pressedOpacity: 0.65,
                                                          color: AppColors.pink,
                                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                          alignment: Alignment.centerLeft,
                                                          child: const Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Trở về trang chủ",
                                                                    style: TextStyle(color: Colors.white),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                        )
                                                      )
                                                    ],
                                                  ),
                                                )
                                              )
                                            );
                                          },
                                        ).whenComplete(() {loginController.bottomStatus.value = 0;}).then((value) => 
                                        {loginController.isShowModalBottom.value = false });
                                            loginController.emailInputController.text = '';
                                            loginController.otpInputController.text = '';
                                            loginController.newPasswordInputController.text = '';
                                            loginController.rePasswordInputController.text = '';
                                          },
                                          child: Text('Quên mật khẩu ?',
                                          style: GoogleFonts.raleway(
                                            textStyle: GoogleFonts.raleway(
                                              textStyle: TextStyle(
                                                color: AppColors.primary,
                                                fontSize: 17.0,
                                              )
                                            )
                                          )
                                        ),
                                      )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ),
                    )
                  ),
                  Container(
                    width: widthScreen,
                    height: 48.0,
                    margin: const EdgeInsets.only(top: 40.0),
                    child: Obx(() => ElevatedButton(
                      onPressed: loginController.isLoging.value ? null
                      : () {handlePressLogin(context);},
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        elevation: 0.0,
                        backgroundColor: AppColors.pink,
                        textStyle: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white
                          )
                        )
                      ),
                      child: const Text("Đăng nhập"),
                    )
                  ),
                ),
              ],
            )
          ),
        )),
      ),
    );
  }

  void handlePressLogin(BuildContext context) async {
    final splashController = Get.find<SplashScreenController>();
    final username = loginController.usernameInputController.text;
    final password = loginController.passwordInputController.text;
    if (username.isEmpty || password.isEmpty) {
      showAlertDialog(context, 'info'.tr, 'input-valid-message'.tr);
    } else {
      try {
        await loginController.login(username, password);
        if (loginController.responseData.value?.code == 200) {
          await splashController.managerHome();
          if (!loginController.isSaveAccount.value) {
            loginController.usernameInputController.clear();
            loginController.passwordInputController.clear();
          }
          showSnackbar(SnackbarType.success, 'log-in'.tr,
              loginController.responseData.value?.message ?? "");
          if ((splashController.responseManagerData.value?.data?.classes?.isEmpty ??true) &&(splashController.responseManagerData.value?.data?.schools?.isEmpty ??true)) 
            {
            if (splashController.responseManagerData.value?.data?.children?.isNotEmpty ??false) {
              store.setSchoolname = splashController.responseManagerData.value?.data?.children?[0].page_title ??"";
              store.setPagename = splashController.responseManagerData.value?.data?.children?[0].page_name ?? "";
              store.setGroupname = splashController.responseManagerData.value?.data?.children?[0].group_name ?? "";
              store.setGrouptitle = splashController.responseManagerData.value?.data?.children?[0].group_title ?? "";
              store.setGroupId = splashController.responseManagerData.value?.data?.children?[0].group_id ?? "";
              store.setChild = splashController.responseManagerData.value?.data?.children?[0];
            }
          } else {
            Get.off(() => ChoseSchool());
          }
        } else {
          Get.off(() => LoginPage());
          showSnackbar(SnackbarType.error, 'error'.tr,
              loginController.responseData.value?.message ?? "");
        }
      } catch (error) {
        loginController.setLogingComplete();
        showSnackbar(SnackbarType.error, 'error'.tr,
            loginController.responseData.value?.message ?? "");
      }
    }
  }
}
