import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_international.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/login/log_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/network_controller.dart';
import 'package:mobiedu_kids/presentation/pages/splash/splash_page.dart';

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
        Locale('vi', 'VN'),
        Locale('en', 'US'),
      ],
      initialRoute: "/",
      initialBinding: LogBinding(),
      home: const SplashPage(),
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        // primaryColor: AppColors.primaryBlue,
        textTheme: CupertinoTextThemeData(
          dateTimePickerTextStyle: TextStyle(fontSize: 18),
        ),
      ),
      color: Colors.white,
    );
  }
}
