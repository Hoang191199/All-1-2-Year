import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/presentation/pages/login/login_page.dart';
import 'package:mooc_app/presentation/widgets/button_submit_form.dart';
import 'package:mooc_app/presentation/widgets/text_input.dart';

import '../../controllers/var_controller.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    final formKey = Get.put(VariableController());
    return Localizations(
      locale: const Locale('en', 'US'),
      delegates: const <LocalizationsDelegate<dynamic>>[
        DefaultWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate
      ],
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 84, 91, 131),
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.off(() => const LoginPage());
                    },
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20.0, top: 20.0),
                          child: const Icon(CupertinoIcons.arrow_left,
                              color: Colors.white),
                        )
                      ],
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 40.0),
                  child: const Text('ĐĂNG KÝ TÀI KHOẢN',
                      style: TextStyle(fontSize: 16.0, color: Colors.white)),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40.0),
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Form(
                    key: formKey.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextInput(
                            icon: Icon(CupertinoIcons.person,
                                color: Colors.white70),
                            labelText: 'Họ và tên'),
                        Container(
                          margin: const EdgeInsets.only(top: 30.0),
                          child: const TextInput(
                              icon: Icon(CupertinoIcons.mail,
                                  color: Colors.white70),
                              labelText: 'Email'),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 30.0),
                          child: const TextInput(
                              icon: Icon(CupertinoIcons.phone,
                                  color: Colors.white70),
                              labelText: 'Số điện thoại'),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 30.0),
                          child: const TextInput(
                              icon: Icon(CupertinoIcons.lock,
                                  color: Colors.white70),
                              labelText: 'Mật khẩu'),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 30.0),
                          child: const TextInput(
                              icon: Icon(CupertinoIcons.lock,
                                  color: Colors.white70),
                              labelText: 'Nhập lại mật khẩu'),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            height: 60.0,
                            width: widthScreen,
                            child: ButtonSubmitForm(
                              buttonText: 'ĐĂNG KÝ',
                              formKey: formKey.formKey,
                            )),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Bạn đã có tài khoản?',
                          style: TextStyle(color: Colors.white60)),
                      GestureDetector(
                        onTap: () {
                          Get.off(() => const LoginPage());
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 8.0),
                          child: const Text('Đăng nhập',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
