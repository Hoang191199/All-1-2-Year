import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/user_data.dart';
import 'package:mobiedu_kids/domain/usecases/log_use_case.dart';
import 'package:mobiedu_kids/presentation/pages/login/login_page.dart';

class LogController extends GetxController {
  LogController(this.loginUseCase, this.logoutUseCase);

  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final bottomStatus = 0.obs;
  final isShowModalBottom = false.obs;

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

  String? get username => localStorage.emailFromStorage;
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
    isSaveAccount.value = localStorage.emailFromStorage.isNotEmpty;
    newPasswordInputController.addListener(() {
      // isPassLeastEightChar.value = newPasswordInputController.text.length >= 8;
      // isPassLeastOneDigit.value =
      //     newPasswordInputController.text.contains(RegExp(r'[0-9]'));
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
    if (responseLogin.code == 200) {
      if (isSaveAccount.value) {
        TextInput.finishAutofillContext(shouldSave: true);
      }
      localStorage.userToStorage = responseLogin.data;
      localStorage.accessTokenToStorage = responseLogin.data?.user_token;
      // localStorage.usernameToStorage = isSaveAccount.value ? username : '';
      // localStorage.passwordToStorage = isSaveAccount.value ? password : '';
      localStorage.emailToStorage = username;
      localStorage.passwordToStorage = password;
      isLoggedIn.value = true;
      isLoggedIn.refresh();
    }
    isLoging(false);
  }

  logout() async {
    final responseLogout = await logoutUseCase.execute();
    if (responseLogout.code == 200 || responseLogout.code == 100) {
      localStorage.userToStorage = null;
      localStorage.accessTokenToStorage = '';
      localStorage.passwordToStorage = '';
      localStorage.emailToStorage = '';
      isLoggedIn.value = false;
      isLoggedIn.refresh();
      Get.off(() => LoginPage());
    }
    // localStorage.userToStorage = null;
    // localStorage.accessTokenToStorage = '';
    // localStorage.passwordToStorage = '';
    // localStorage.usernameToStorage = '';
    // isLoggedIn.value = false;
    // isLoggedIn.refresh();
    // Get.off(() => LoginPage());
  }

  setLogingComplete() {
    isLoging(false);
  }

  changeSaveAccount() {
    isSaveAccount.value = !(isSaveAccount.value);
  }
}
