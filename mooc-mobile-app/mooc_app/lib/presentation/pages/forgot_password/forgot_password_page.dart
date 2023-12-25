import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooc_app/presentation/controllers/var_controller.dart';
import 'package:mooc_app/presentation/widgets/button_submit_form.dart';
import 'package:mooc_app/presentation/widgets/text_input.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

//   @override
//   State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
// }
//
// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
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
                        child: const Icon(CupertinoIcons.arrow_left, color: Colors.white),
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
                  child: const Text('LẤY LẠI MẬT KHẨU', style: TextStyle(fontSize: 16.0, color: Colors.white)),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: const Text(
                    'Nhập địa chỉ email bạn đã đăng ký, chúng tôi sẽ giúp bạn lấy lại mật khẩu', 
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center
                  ),
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
                          labelText: 'Địa chỉ Email bạn đã đăng ký'
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          height: 60.0,
                          width: widthScreen,
                          child: ButtonSubmitForm(
                            buttonText: 'GỬI MẬT KHẨU CHO TÔI',
                            formKey: formKey.formKey,
                          )
                        ),
                      ],
                    ),
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