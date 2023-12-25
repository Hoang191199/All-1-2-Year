import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/login_info.dart';
import 'package:mooc_app/presentation/controllers/auth/auth_controller.dart';

import '../../../app/config/app_common.dart';
import '../../../app/config/app_constants.dart';
import '../../../domain/entities/paging_mooc.dart';
import '../../../domain/usecases/login_history_usecase.dart';

class LoginHistoryController extends GetxController {
  LoginHistoryController(this.loginHistoryUseCase);
  final LoginHistoryUseCase loginHistoryUseCase;
  final auth = Get.find<AuthController>();
  var paging = Rx<PagingMooc?>(null);
  var loginData = Rx<List<LogInfo>>([]);
  final isLoading = false.obs;

  fetchData(page) async {
    isLoading(true);
    paging.value = null;
    loginData.value = [];
    final response = await loginHistoryUseCase.execute(page);
    paging.value = response.pagination;
    loginData.value = response.data!;
    if(response.code == 401){
      auth.logout();
      showSnackbar(SnackbarType.notice, "Hết phiên đăng nhập", "Vui lòng đăng nhập lại");
    }
    isLoading(false);
  }
}
