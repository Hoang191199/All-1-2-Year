import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:qltv/app/config/app_colors.dart';
import 'package:qltv/app/config/app_internationalized.dart';
import 'package:qltv/app/services/local_storage.dart';
import 'package:qltv/presentation/controllers/login/login_binding.dart';
import 'package:qltv/presentation/controllers/network_controller.dart';
import 'package:qltv/presentation/pages/splash/splash_page.dart';

class AppWidget extends GetView<GetXNetworkManager> {
  AppWidget({super.key});

  final store = Get.find<LocalStorageService>();
  @override
  Widget build(BuildContext context) {
    return GetCupertinoApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      translations: Internationalized(),
      locale: (store.checkLocale.length == 2)
          ? Locale(store.checkLocale[0], store.checkLocale[1])
          : Get.deviceLocale,
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      initialRoute: "/",
      initialBinding: LoginBinding(),
      home: const SplashPage(),
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primaryBlue,
      ),
      color: Colors.white,
      // getPages: [
      //   GetPage(name: HomePage.routeName, page: () => const HomePage()),
      //   GetPage(name: SignInPage.routeName, page: () => const SignInPage()),
      // ],
    );
  }
}
