import 'package:get/get.dart';

class CarouselSlideController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final current = 0.obs;

  @override
  void onInit() async {
    await carouselInitilization();
    super.onInit();
  }

  carouselInitilization() async {
    current.value = 0;
  }
}
