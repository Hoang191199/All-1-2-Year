import 'package:get/get.dart';
import 'package:rate_my_app/rate_my_app.dart';

class RateController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late RateMyApp rateMyApp;
  static const playStoreId = 'com.inet.qltv';
  // static const appstoreId = 'com.apple.mobilesafari';
  static const appstoreId = "com.inet.qltv";
  @override
  void onInit() {
    rateInitilization();
    super.onInit();
  }

  rateInitilization() {
    rateMyApp = RateMyApp(
      googlePlayIdentifier: playStoreId,
      appStoreIdentifier: appstoreId,
    );
  }
}
