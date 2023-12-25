import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/profile_data.dart';
import 'package:mooc_app/domain/entities/profile_mooc_data.dart';
import 'package:mooc_app/presentation/controllers/auth/auth_controller.dart';
import 'package:get/get.dart';
import '../../../app/config/app_common.dart';
import '../../../app/config/app_constants.dart';
import '../../../domain/entities/profile_mooc.dart';
import '../../../domain/usecases/fetch_profile_use_case.dart';
import '../../../domain/usecases/update_profile_use_case.dart';

class FetchProfileController extends GetxController {
  FetchProfileController(this.fetchprofileUseCase);
  final auth = Get.find<AuthController>();
  final FetchProfileUseCase fetchprofileUseCase;
  var profile = Rx<ProfileMoocData?>(null);
  final isLoading = false.obs;
  final isInitialized = false.obs;

  @override
  void onInit() async {
    await fetchDataInit();
    super.onInit();
    isInitialized.value = true;
  }

  fetchDataInit() async {
    isLoading(true);
      profile.value = null;
      final proList = await fetchprofileUseCase.execute();
      profile.value = proList;
      if (proList.code == 401 && auth.token != "" && auth.token != null) {
        auth.logout();
        showSnackbar(
            SnackbarType.notice, "Đăng xuất", "Hết phiên đăng nhập");
      }
    isLoading(false);
  }
}
