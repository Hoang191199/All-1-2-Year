import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:mooc_app/app/services/local_storage.dart';
import 'package:mooc_app/domain/entities/profile_data.dart';
import 'package:mooc_app/app/config/app_common.dart';
import 'package:mooc_app/app/config/app_constants.dart';
import 'package:mooc_app/domain/entities/user_sso.dart';
import '../../../domain/usecases/update_profile_use_case.dart';
import '../auth/auth_controller.dart';

class UpdateProfileController extends GetxController {
  UpdateProfileController(this.updateprofileUseCase);
  final auth = Get.find<AuthController>();
  final store = Get.find<LocalStorageService>();
  final UpdateProfileUseCase updateprofileUseCase;
  var profile = Rx<ProfileData?>(null);
  var available = Rx<UserSSO?>(null);
  final isLoading = false.obs;

  updateData(String fullname, String email, String? phone, String? dob,
      String? avatar, String address, String gender, String city) async {
    isLoading(true);
    final body = await updateprofileUseCase.execute(
        Tuple8(fullname, email, phone, dob, avatar, address, gender, city));
    if (body.code == 401) {
      auth.logout();
      showSnackbar(SnackbarType.notice, "Đăng xuất", "Hết phiên đăng nhập");
      Get.back();
    } else if (body.error == false) {
      available.value = store.userFromStorage;
      store.userToStorage = null;
      store.userToStorage = UserSSO(
          accessToken: available.value?.accessToken,
          notificationToken: available.value?.notificationToken,
          id: available.value?.id,
          fullname: fullname,
          phone: phone,
          email: email,
          dob: dob,
          avatar: avatar,
          address: address,
          gender: gender,
          city: city);
      showSnackbar(
          SnackbarType.success, "Thành công", "Đã cập nhật thành công hồ sơ");
    } else {
      showSnackbar(
          SnackbarType.error, "Thất bại", "Cập nhật hồ sơ không thành công");
    }
    isLoading(false);
  }
}
