import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/presentation/controllers/var_controller.dart';
import 'package:mooc_app/presentation/pages/forgot_password/forgot_password_page.dart';
import 'package:mooc_app/presentation/pages/register/register_page.dart';
import 'package:mooc_app/presentation/widgets/button_submit_form.dart';
import 'package:mooc_app/presentation/widgets/text_input.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final formKey = GlobalKey<FormState>();

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
                    Get.back();
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20.0, top: 80.0),
                        child: const Icon(CupertinoIcons.clear, color: Colors.white),
                      )
                    ],
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40.0),
                  child: const Text('MOOC APP', style: TextStyle(fontSize: 42.0, color: Colors.white, fontWeight: FontWeight.w900)),
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
                          icon: Icon(CupertinoIcons.mail, color: Colors.white70), 
                          labelText: 'Email/Số điện thoại đăng nhập'
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 30.0),
                          child: const TextInput(
                            icon: Icon(CupertinoIcons.lock, color: Colors.white70), 
                            labelText: 'Mật khẩu'
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          width: widthScreen,
                          child: ButtonSubmitForm(
                            buttonText: 'ĐĂNG NHẬP',
                            formKey: formKey.formKey,
                          )
                        ),
                      ],
                    ) 
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const ForgotPasswordPage());
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: const Text('Quên mật khẩu?', style: TextStyle(color: Colors.white60)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Divider(color: Colors.white60, thickness: 1.0, indent: 20.0, endIndent: 30.0)
                      ),
                      Text('Hoặc', style: TextStyle(color: Colors.white60)),
                      Expanded(
                        child: Divider(color: Colors.white60, thickness: 1.0, indent: 30.0, endIndent: 20.0)
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Bạn chưa có tài khoản?', style: TextStyle(color: Colors.white60)),
                      GestureDetector(
                        onTap: () {
                          Get.off(() => const RegisterPage());
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 8.0),
                          child: const Text('Đăng ký mới', style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ) 
          ),
        ),
      ),
    );
  }
}