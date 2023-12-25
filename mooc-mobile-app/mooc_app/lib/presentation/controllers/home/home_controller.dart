import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/home.dart';
import 'package:mooc_app/domain/usecases/home_use_case.dart';

class HomeController extends GetxController {
  HomeController(this.homeUseCase);

  final HomeUseCase homeUseCase;

  final isLoading = false.obs;
  var homeData = Rx<Home?>(null);

  @override
  void onInit() async {
    fetchData();
    super.onInit();
  }

  fetchData() async {
    isLoading(true);
    final data = await homeUseCase.execute();
    homeData.value = data;
    isLoading(false);
  }
}