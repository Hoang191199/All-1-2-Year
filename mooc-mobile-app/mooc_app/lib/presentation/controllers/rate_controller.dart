import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mooc_app/presentation/pages/init/init_page.dart';
import 'package:rate_my_app/rate_my_app.dart';

class RateController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late RateMyApp rateMyApp ;
  static const playStoreId = 'net.loigiai.elearning';
  // static const appstoreId = 'com.apple.mobilesafari';
  static const appstoreId = "1491556149";
  @override
  void onInit() {
    rateInitilization();
    super.onInit();
  }

  rateInitilization() {
    rateMyApp =
        RateMyApp(
          googlePlayIdentifier: playStoreId,
          appStoreIdentifier: appstoreId,
          minDays: 7,
          minLaunches: 10,
          remindDays: 7,
          remindLaunches: 10,
        );
  }
}
