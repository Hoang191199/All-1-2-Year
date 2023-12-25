import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/growths_details.dart';
import 'package:mobiedu_kids/domain/entities/image_data.dart';
import 'package:mobiedu_kids/domain/usecases/growth_use_case.dart';

class GrowthController extends GetxController {
  static GrowthController get to => Get.find<GrowthController>();
  GrowthController(
      this.getGrowthUseCase,
      this.addGrowthUseCase,
      this.editGrowthUseCase,
      // this.editGrowthAltUseCase,
      this.deleteGrowthUseCase,
      this.getGrowthChildUseCase,
      this.addGrowthChildUseCase,
      this.editGrowthChildUseCase,
      // this.editGrowthAltChildUseCase,
      this.deleteGrowthChildUseCase);

  final GetGrowthUseCase getGrowthUseCase;
  final AddGrowthUseCase addGrowthUseCase;
  final EditGrowthUseCase editGrowthUseCase;
  // final EditGrowthAltUseCase editGrowthAltUseCase;
  final DeleteGrowthUseCase deleteGrowthUseCase;
  final GetGrowthChildUseCase getGrowthChildUseCase;
  final AddGrowthChildUseCase addGrowthChildUseCase;
  final EditGrowthChildUseCase editGrowthChildUseCase;
  // final EditGrowthAltChildUseCase editGrowthAltChildUseCase;
  final DeleteGrowthChildUseCase deleteGrowthChildUseCase;

  var listGrowth = RxList<GrowthsDetails?>([]);
  final currentStudent = 0.obs;
  final store = Get.find<LocalStorageService>();
  final isLoading = false.obs;
  var dateNow = Rx<DateTime>(DateTime.now());
  final Image = Rx<ImageData?>(null);
  final choiceIndex = 0.obs;
  var startMonth = Rx<double>(0);
  var endMonth = Rx<double>(0);
  final action = false.obs;
  late TextEditingController height;
  late TextEditingController weight;
  late TextEditingController nutriture_status;
  late TextEditingController ear;
  late TextEditingController eye;
  late TextEditingController blood_pressure;
  late TextEditingController heart;
  late TextEditingController nose;
  late TextEditingController description;

  @override
  void onInit() async {
    height = TextEditingController(text: "");
    weight = TextEditingController(text: "");
    nutriture_status = TextEditingController(text: "");
    ear = TextEditingController(text: "");
    eye = TextEditingController(text: "");
    blood_pressure = TextEditingController(text: "");
    heart = TextEditingController(text: "");
    nose = TextEditingController(text: "");
    description = TextEditingController(text: "");
    super.onInit();
  }

  fetch(String group_name, String child_id) async {
    final res = await getGrowthUseCase.execute(Tuple2(group_name, child_id));
    listGrowth.assignAll(res.data?.growths ?? []);
  }

  fetchChild(String child_id, String startMonth, String endMonth) async {
    final res = await getGrowthChildUseCase
        .execute(Tuple3(child_id, startMonth, endMonth));
    listGrowth.assignAll(res.data?.growths ?? []);
  }

  add(
      String group_name,
      String child_id,
      String height,
      String weight,
      String nutriture_status,
      String ear,
      String eye,
      String blood_pressure,
      String heart,
      String nose,
      String description,
      String date,
      Uint8List? file) async {
    isLoading(true);
    final res = await addGrowthUseCase.execute(Tuple13(
        group_name,
        child_id,
        height,
        weight,
        nutriture_status,
        ear,
        eye,
        blood_pressure,
        heart,
        nose,
        description,
        date,
        file));
    if (res.code == 200) {
      showSnackbar(SnackbarType.success, "Thêm thành công",
          "Thêm chỉ số sức khỏe thành công");
    } else {
      showSnackbar(SnackbarType.success, "Thêm thất bại",
          "Thêm chỉ số sức khỏe thất bại");
    }
    isLoading(false);
  }

  addChild(
      String child_id,
      String height,
      String weight,
      String nutriture_status,
      String ear,
      String eye,
      String blood_pressure,
      String heart,
      String nose,
      String description,
      String date,
      Uint8List? file) async {
    isLoading(true);
    final res = await addGrowthChildUseCase.execute(Tuple12(
        child_id,
        height,
        weight,
        nutriture_status,
        ear,
        eye,
        blood_pressure,
        heart,
        nose,
        description,
        date,
        file));
    if (res.code == 200) {
      showSnackbar(SnackbarType.success, "Thêm thành công",
          "Thêm chỉ số sức khỏe thành công");
    } else {
      showSnackbar(SnackbarType.success, "Thêm thất bại",
          "Thêm chỉ số sức khỏe thất bại");
    }
    isLoading(false);
  }

  edit(
      String group_name,
      String child_id,
      String child_growth_id,
      String height,
      String weight,
      String nutriture_status,
      String ear,
      String eye,
      String blood_pressure,
      String heart,
      String nose,
      String description,
      String date,
      Uint8List? file) async {
    isLoading(true);
    final res = await editGrowthUseCase.execute(Tuple14(
        group_name,
        child_id,
        child_growth_id,
        height,
        weight,
        nutriture_status,
        ear,
        eye,
        blood_pressure,
        heart,
        nose,
        description,
        date,
        file));
    if (res.code == 200) {
      showSnackbar(SnackbarType.success, "Cập nhật thành công",
          "Cập nhật chỉ số sức khỏe thành công");
    } else {
      showSnackbar(SnackbarType.error, "Cập nhật thất bại",
          "Cập nhật chỉ số sức khỏe thất bại");
    }
    isLoading(false);
  }

  editChild(
      String child_id,
      String child_growth_id,
      String height,
      String weight,
      String nutriture_status,
      String ear,
      String eye,
      String blood_pressure,
      String heart,
      String nose,
      String description,
      String date,
      Uint8List? file) async {
    isLoading(true);
    final res = await editGrowthChildUseCase.execute(Tuple13(
        child_id,
        child_growth_id,
        height,
        weight,
        nutriture_status,
        ear,
        eye,
        blood_pressure,
        heart,
        nose,
        description,
        date,
        file));
    if (res.code == 200) {
      showSnackbar(SnackbarType.success, "Cập nhật thành công",
          "Cập nhật chỉ số sức khỏe thành công");
    } else {
      showSnackbar(SnackbarType.error, "Cập nhật thất bại",
          "Cập nhật chỉ số sức khỏe thất bại");
    }
    isLoading(false);
  }

  delete(String group_name, String child_id, String child_growth_id) async {
    final res = await deleteGrowthUseCase
        .execute(Tuple3(group_name, child_id, child_growth_id));
    if (res.code == 200) {
      showSnackbar(SnackbarType.success, "Xóa thành công", res.message ?? "");
    } else {
      showSnackbar(SnackbarType.error, "Xóa thất bại", res.message ?? "");
    }
  }

  deleteChild(String child_id, String child_growth_id) async {
    final res = await deleteGrowthChildUseCase
        .execute(Tuple2(child_id, child_growth_id));
    if (res.code == 200) {
      showSnackbar(SnackbarType.success, "Xóa thành công", res.message ?? "");
    } else {
      showSnackbar(SnackbarType.error, "Xóa thất bại", res.message ?? "");
    }
  }
}
