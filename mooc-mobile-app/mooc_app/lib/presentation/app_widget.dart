import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/config/app_colors.dart';

import 'package:mooc_app/presentation/controllers/network_controller.dart';
import 'package:mooc_app/presentation/controllers/auth/auth_binding.dart';
import 'package:mooc_app/presentation/pages/splash/splash_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppWidget extends GetView<GetXNetworkManager> {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetCupertinoApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi', ''),
      ],
      initialRoute: "/",
      initialBinding: AuthBinding(),
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


