import 'package:get/get.dart';
import 'package:qltv/app/config/app_common.dart';
import 'package:qltv/app/config/app_constants.dart';
import 'package:qltv/app/services/local_storage.dart';
import 'package:qltv/domain/entities/profile_info.dart';
import 'package:qltv/domain/entities/reader_data.dart';
import 'package:qltv/domain/entities/reader_info.dart';
import 'package:qltv/domain/entities/user_data.dart';
import 'package:qltv/domain/usecases/profile_use_case.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find<ProfileController>();
  ProfileController(this.profileUseCase);
  final ProfileUseCase profileUseCase;
  final store = Get.find<LocalStorageService>();
  var proAvailable = Rx<UserData?>(null);
  var readAvailable = Rx<ReaderData?>(null);
  var profile = Rx<ProfileInfo?>(null);
  var reader = Rx<ReaderInfo?>(null);
  var mess = RxString("");
  var error = RxBool(true);
  var upErr = RxBool(true);
  final isLoading = false.obs;
  final isInitialized = false.obs;

  @override
  void onInit() async {
    await fetchProfile();
    super.onInit();
    isInitialized.value = true;
  }

  fetchProfile() async {
    isLoading(true);
    profile.value = null;
    final pro = await profileUseCase.execute();
    profile.value = pro.data;
    await fetchReader(pro.data?.id ?? 0);
    if (error.value == false && pro.error == false) {
      List<String> list = [];
      if (reader.value?.userSite?.metadata?.subject_groups != null) {
        List<int> items = List.generate(
            reader.value?.userSite?.metadata?.subject_groups!.length ?? 0,
            (i) => i);
        for (var i in items) {
          list.add(
              "${reader.value?.userSite?.metadata?.subject_groups?[i].title}");
        }
      }
      String subject = list.join(", ");
      store.readerToStorage = null;
      store.readerToStorage = ReaderData(
        id: pro.data?.id,
        fullname: reader.value?.userSite?.metadata?.fullname,
        phone: reader.value?.phone,
        email: reader.value?.email,
        role: reader.value?.userSite?.role,
        gender: profile.value?.gender,
        birthday: profile.value?.birthday,
        subject: subject,
        start_years: reader.value?.userSite?.metadata?.start_year,
        end_years: reader.value?.userSite?.metadata?.end_year,
        avatar_url: reader.value?.userSite?.metadata?.avatar_url,
        code: reader.value?.userSite?.code,
        expired_date: reader.value?.userSite?.metadata?.expired_date,
        organizations: reader.value?.userSite?.metadata?.organization,
      );
      proAvailable.value = store.userFromStorage;
      store.userToStorage = null;
      store.userToStorage = UserData(
          id: proAvailable.value?.id,
          fullname: reader.value?.userSite?.metadata?.fullname,
          phone: reader.value?.phone,
          email: reader.value?.email,
          role: proAvailable.value?.role,
          gender: profile.value?.gender,
          birthday: profile.value?.birthday,
          default_site_id: proAvailable.value?.default_site_id,
          avatar_url: reader.value?.userSite?.metadata?.avatar_url,
          accessToken: proAvailable.value?.accessToken,
          refreshToken: proAvailable.value?.refreshToken);
    }
    isLoading(false);
    update();
  }

  fetchReader(int id) async {
    reader.value = null;
    error.value = true;
    mess.value = "";
    final pro = await profileUseCase.executeRd(id);
    reader.value = pro.data;
    mess.value = pro.message ?? "";
    error.value = pro.error ?? true;
  }

  updateProfile(String fullname, String email, String phone, String birthday,
      int gender, String description, String avatar_url) async {
    final pro = await profileUseCase.executeUp(
        fullname, email, phone, birthday, gender, description, avatar_url);
    upErr.value = pro.error ?? true;
    if (upErr.value == false) {
      proAvailable.value = store.userFromStorage;
      store.userToStorage = null;
      store.userToStorage = UserData(
          id: proAvailable.value?.id,
          fullname: fullname,
          phone: phone,
          email: email,
          role: proAvailable.value?.role,
          gender: gender,
          birthday: birthday,
          default_site_id: proAvailable.value?.default_site_id,
          avatar_url: avatar_url,
          accessToken: proAvailable.value?.accessToken,
          refreshToken: proAvailable.value?.refreshToken);
      readAvailable.value = store.readerFromStorage;
      store.readerToStorage = null;
      store.readerToStorage = ReaderData(
        id: readAvailable.value?.id,
        fullname: fullname,
        phone: phone,
        email: email,
        role: readAvailable.value?.role,
        gender: gender,
        birthday: birthday,
        subject: readAvailable.value?.subject,
        start_years: readAvailable.value?.start_years,
        end_years: readAvailable.value?.end_years,
        avatar_url: avatar_url,
        code: readAvailable.value?.code,
        expired_date: readAvailable.value?.expired_date,
        organizations: readAvailable.value?.organizations,
      );
      showSnackbar(
          SnackbarType.success, "success".tr, "update-profile-success".tr);
    } else {
      showSnackbar(SnackbarType.error, "failure".tr, "error-message".tr);
    }
    update();
  }
}
