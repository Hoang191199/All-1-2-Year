import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/app/services/local_storage.dart';
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/entities/user_data.dart';
import 'package:qltv/domain/usecases/login_use_case.dart';
import 'package:qltv/presentation/pages/login/login_page.dart';

class LoginController extends GetxController {
  LoginController(this.loginUseCase);

  final LoginUseCase loginUseCase;

  final localStorage = Get.find<LocalStorageService>();

  late TextEditingController usernameInputController;
  late TextEditingController passwordInputController;
  late TextEditingController emailInputController;
  late TextEditingController otpInputController;
  late TextEditingController newPasswordInputController;
  late TextEditingController rePasswordInputController;

  final isLoging = false.obs;
  final isLoggedIn = false.obs;

  UserData? get userLogin => localStorage.userFromStorage;
  String? get accessToken => localStorage.accessTokenFromStorage;

  String? get username => localStorage.usernameFromStorage;
  String? get password => localStorage.passwordFromStorage;

  var responseData = Rx<ResponseDataObject<UserData>?>(null);
  var userData = Rx<UserData?>(null);
  final isSaveAccount = false.obs;

  final isPassLeastOneDigit = false.obs;
  final isPassLeastEightChar = false.obs;
  final isSameNewPass = true.obs;

  @override
  void onInit() {
    usernameInputController = TextEditingController(
        text: username == null || (username?.isEmpty ?? false) ? '' : username);
    passwordInputController = TextEditingController(
        text: username == null || (password?.isEmpty ?? false) ? '' : password);
    emailInputController = TextEditingController(text: '');
    otpInputController = TextEditingController(text: '');
    newPasswordInputController = TextEditingController(text: '');
    rePasswordInputController = TextEditingController(text: '');
    isLoggedIn.value = localStorage.userFromStorage != null;
    isSaveAccount.value = localStorage.usernameFromStorage.isNotEmpty;
    newPasswordInputController.addListener(() {
      isPassLeastEightChar.value = newPasswordInputController.text.length >= 8;
      isPassLeastOneDigit.value =
          newPasswordInputController.text.contains(RegExp(r'[0-9]'));
      checkSamePass();
    });
    rePasswordInputController.addListener(() {
      checkSamePass();
    });
    super.onInit();
  }

  checkSamePass() {
    if (newPasswordInputController.text.isEmpty &&
        rePasswordInputController.text.isEmpty) {
      isSameNewPass.value = true;
    } else if (newPasswordInputController.text.isNotEmpty &&
        rePasswordInputController.text.isNotEmpty) {
      if (newPasswordInputController.text == rePasswordInputController.text) {
        isSameNewPass.value = true;
      } else {
        isSameNewPass.value = false;
      }
    } else {
      isSameNewPass.value = false;
    }
  }

  login(String username, String password) async {
    isLoging(true);
    final responseLogin =
        await loginUseCase.execute(Tuple2(username, password));
    responseData.value = responseLogin;
    userData.value = responseLogin.data;
    if (!(responseLogin.error ?? false)) {
      if (responseLogin.data?.role == UserRole.teacher ||
          responseLogin.data?.role == UserRole.student) {
        localStorage.userToStorage = responseLogin.data;
        localStorage.accessTokenToStorage = responseLogin.data?.accessToken;
        // localStorage.usernameToStorage = isSaveAccount.value ? username : '';
        // localStorage.passwordToStorage = isSaveAccount.value ? password : '';
        localStorage.usernameToStorage = username;
        localStorage.passwordToStorage = password;
        isLoggedIn.value = true;
        isLoggedIn.refresh();
      }
    }
    isLoging(false);
  }

  logout() {
    localStorage.userToStorage = null;
    localStorage.accessTokenToStorage = '';
    isLoggedIn.value = false;
    isLoggedIn.refresh();
    Get.off(() => LoginPage());
  }

  setLogingComplete() {
    isLoging(false);
  }

  changeSaveAccount() {
    isSaveAccount.value = !(isSaveAccount.value);
  }

  clearResetPasswordInfo() {
    otpInputController.text = '';
    newPasswordInputController.text = '';
    rePasswordInputController.text = '';
  }
}
