import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/child.dart';
import 'package:mobiedu_kids/domain/entities/child_details.dart';
import 'package:mobiedu_kids/domain/entities/child_info.dart';
import 'package:mobiedu_kids/domain/entities/children_data.dart';
import 'package:mobiedu_kids/domain/entities/parent_details.dart';
import 'package:mobiedu_kids/domain/entities/picker_info.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/usecases/child_use_case.dart';

class ChildController extends GetxController {
  static ChildController get to => Get.find<ChildController>();
  ChildController(
      this.getChildUseCase,
      this.detailChildUseCase,
      this.addChildUseCase,
      this.infoChildUseCase,
      this.editChildUseCase,
      this.uploadAvatarUseCase,
      this.searchUserUseCase,
      this.searchCodeUseCase,
      this.detailChildParentUseCase,
      this.editChildParentUseCase,
      this.overViewUseCase);

  final GetChildUseCase getChildUseCase;
  final DetailChildUseCase detailChildUseCase;
  final DetailChildParentUseCase detailChildParentUseCase;
  final AddChildUseCase addChildUseCase;
  final InfoChildUseCase infoChildUseCase;
  final EditChildUseCase editChildUseCase;
  final EditChildParentUseCase editChildParentUseCase;
  final UploadAvatarUseCase uploadAvatarUseCase;
  final SearchUserUseCase searchUserUseCase;
  final SearchCodeUseCase searchCodeUseCase;
  final OverViewUseCase overViewUseCase;

  late TextEditingController lastname;
  late TextEditingController firstname;
  late TextEditingController nickname;
  late TextEditingController birthday;
  late TextEditingController parent_phone;
  late TextEditingController parent_name;
  late TextEditingController parent_email;
  late TextEditingController password;
  late TextEditingController address;
  late TextEditingController begin_at;
  late TextEditingController description;
  late TextEditingController search;
  late TextEditingController code;
  late TextEditingController blood_type;
  late TextEditingController hobby;
  late TextEditingController allergy;
  var listStudent = RxList<ChildInfo?>([]);
  var child_info = Rx<ChildDetails?>(null);
  var child_info_parent = Rx<ChildrenData?>(null);
  var picker_info = RxList<PickerInfo?>([]);
  final currentStudent = 0.obs;
  late TextEditingController textSMS;
  final store = Get.find<LocalStorageService>();
  final isLoading = false.obs;
  final isdetailLoading = false.obs;
  final ispickerLoading = false.obs;
  final isSearching = false.obs;
  final action = false.obs;
  final validateName = false.obs;
  final validatePassWord = false.obs;
  final validateNameDetail = false.obs;
  final validatePassWordDetail = false.obs;
  var dateNow = Rx<DateTime>(DateTime.now());
  var parents = RxList<ParentDetails?>([]);
  var parents_parent = RxList<ParentDetails?>([]);
  var searchParents = RxList<ParentDetails?>([]);
  var gender = false.obs;
  var resp = Rx<ResponseDataObject<Child>?>(null);
  final reloading = false.obs;
  var child = Rx<ChildrenData?>(null);

  @override
  void onInit() async {
    search = TextEditingController(text: "");
    code = TextEditingController(text: "");
    lastname = TextEditingController(text: "");
    firstname = TextEditingController(text: "");
    nickname = TextEditingController(text: "");
    birthday = TextEditingController(text: "");
    description = TextEditingController(text: "");
    parent_phone = TextEditingController(text: "");
    parent_name = TextEditingController(text: "");
    parent_email = TextEditingController(text: "");
    password = TextEditingController(text: "");
    blood_type = TextEditingController(text: "");
    hobby = TextEditingController(text: "");
    allergy = TextEditingController(text: "");
    address = TextEditingController(text: "");
    begin_at = TextEditingController(text: "");
    textSMS = TextEditingController(text: "");
    await fetch(store.getGroupname);
    super.onInit();
  }

  fetch(String groupname) async {
    isLoading(true);
    // try {
    final res = await getChildUseCase.execute(groupname);
    if (res.code == 200) {
      listStudent.assignAll(res.data?.child_list ?? []);
      // } catch (e) {
      //   Get.to(() => LoginPage());
      // }
    }
    isLoading(false);
  }

  detail(String groupname, String child_id) async {
    isdetailLoading(true);
    // try {
    final res = await detailChildUseCase.execute(Tuple2(groupname, child_id));
    if (res.code == 200) {
      child_info.value = res.data?.child;
      parents.assignAll(res.data?.child?.parent ?? []);
      // } catch (e) {
      //   Get.to(() => LoginPage());
      // }
    }
    isdetailLoading(false);
  }

  detail_parent(String child_id) async {
    isdetailLoading(true);
    final res = await detailChildParentUseCase.execute(child_id);
    if (res.code == 200) {
      child_info_parent.value = res.data?.child_info?.child;
      parents_parent.assignAll(res.data?.child_info?.parent ?? []);
      firstname.text = child_info_parent.value?.first_name ?? "";
      lastname.text = child_info_parent.value?.last_name ?? "";
      birthday.text = child_info_parent.value?.birthday ?? "";
      description.text = child_info_parent.value?.description ?? "";
      parent_email.text = child_info_parent.value?.parent_email ?? "";
      parent_phone.text = child_info_parent.value?.parent_phone ?? "";
      parent_name.text = child_info_parent.value?.parent_name ?? "";
      address.text = child_info_parent.value?.address ?? "";
      blood_type.text = child_info_parent.value?.blood_type ?? "";
      hobby.text = child_info_parent.value?.hobby ?? "";
      allergy.text = child_info_parent.value?.allergy ?? "";
      nickname.text = child_info_parent.value?.child_nickname ?? "";
      gender.value = child_info_parent.value?.gender == "male" ? true : false;
    }
    isdetailLoading(false);
  }

  add(
      String group_name,
      String code_auto,
      String first_name,
      String last_name,
      String description,
      String gender,
      String parent_phone,
      String parent_name,
      String parent_email,
      String create_parent_account,
      String address,
      String birthday,
      String begin_at,
      String pre_tuition_receive,
      String password,
      List<String> parent,
      int parentNum) async {
    final res = await addChildUseCase.execute(Tuple17(
        group_name,
        code_auto,
        first_name,
        last_name,
        description,
        gender,
        parent_phone,
        parent_name,
        parent_email,
        create_parent_account,
        address,
        birthday,
        begin_at,
        pre_tuition_receive,
        password,
        parent,
        parentNum));
    if (res.code == 200) {
      await fetch(store.getGroupname);
      Get.back();
      showSnackbar(
          SnackbarType.success, "Thêm thành công", "Thêm trẻ thành công");
    } else {
      showSnackbar(SnackbarType.error, "Không thành công", res.message ?? "");
    }
  }

  edit(
      String group_name,
      String child_id,
      String child_code,
      String first_name,
      String last_name,
      String description,
      String gender,
      String parent_phone,
      String parent_name,
      String parent_email,
      String create_parent_account,
      String address,
      String birthday,
      String begin_at,
      String pre_tuition_receive,
      String password,
      List<String> parent,
      int parentNum) async {
    final res = await editChildUseCase.execute(Tuple18(
        group_name,
        child_id,
        child_code,
        first_name,
        last_name,
        description,
        gender,
        parent_phone,
        parent_name,
        parent_email,
        create_parent_account,
        address,
        birthday,
        begin_at,
        pre_tuition_receive,
        password,
        parent,
        parentNum));
    if (res.code == 200) {
      showSnackbar(SnackbarType.success, "Sửa thành công", "Cập nhật thành công");
    } else {
      showSnackbar(SnackbarType.error, "Không thành công", res.message ?? "");
    }
  }

  edit_parent(
      String child_id,
      String first_name,
      String last_name,
      String nickname,
      String description,
      String gender,
      String parent_phone,
      String parent_name,
      String parent_email,
      String address,
      String birthday,
      String blood_type,
      String hobby,
      String allergy,
      List<String> parent,
      int parentNum) async {
    final res = await editChildParentUseCase.execute(Tuple16(
        child_id,
        first_name,
        last_name,
        nickname,
        description,
        gender,
        parent_phone,
        parent_name,
        parent_email,
        address,
        birthday,
        blood_type,
        hobby,
        allergy,
        parent,
        parentNum));
    if (res.code == 200) {
      showSnackbar(SnackbarType.success, "Sửa thành công", "Cập nhật thành công");
    } else {
      showSnackbar(SnackbarType.error, "Không thành công", res.message ?? "");
    }
  }

  upload(String child_parent_id, Uint8List file) async{
    final res = await uploadAvatarUseCase.execute(Tuple2(child_parent_id, file));
    if(res.code == 200){
      showSnackbar(SnackbarType.success, "Sửa thành công", "Cập nhật thành công"); 
      await overView(child_parent_id);
    }
    else {
      showSnackbar(SnackbarType.error, "Không thành công", res.message ?? "");
    }
  }

  info(String groupname, String child_id) async {
    ispickerLoading(true);
    // try {
    final res = await infoChildUseCase.execute(Tuple2(groupname, child_id));
    picker_info.assignAll(res.data ?? []);
    // } catch (e) {
    //   Get.to(() => LoginPage());
    // }
    ispickerLoading(false);
  }

  searchUser(String q, String page) async {
    isSearching(true);
    final par = <String>[];
    par.addAll(parents.map((e) => e!.user_id!));
    final res =
        await searchUserUseCase.execute(Tuple4(q, page, par, par.length));
    searchParents.assignAll(res.data ?? []);
    isSearching(false);
  }

  searchUserAlt(String q, String page) async {
    isSearching(true);
    final par = <String>[];
    par.addAll(parents_parent.map((e) => e!.user_id!));
    final res =
        await searchUserUseCase.execute(Tuple4(q, page, par, par.length));
    searchParents.assignAll(res.data ?? []);
    isSearching(false);
  }

  searchCode(String groupname, String child_code) async {
    final res = await searchCodeUseCase.execute(Tuple2(groupname, child_code));
    if (res.code == 200) {
      resp.value = res;
      showSnackbar(SnackbarType.success, "Đã xong", "Thêm học sinh thành công");
    } else {
      showSnackbar(SnackbarType.error, "Không thành công", res.message ?? "");
    }
  }

  overView(String child_id) async{
    reloading(true);
    try{
    final res = await overViewUseCase.execute(child_id);
    if (res.code == 200) {
      child.value = store.getChild;
      child.value?.child_picture = res.data?.childPicture;
      store.setChild = child.value;
    }
    reloading(false);
    }
    catch(e) {
      reloading(false);
    }
  }
}
