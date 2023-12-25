import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/domain/entities/list_children.dart';
import 'package:mobiedu_kids/domain/entities/prescription/medicines.dart';
import 'package:mobiedu_kids/domain/entities/prescription/prescription_data.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/usecases/prescription/prescription_add_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/prescription/prescription_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/prescription/show_child_active_use_case.dart';
import 'package:mobiedu_kids/domain/usecases/prescription/take_medicines_use_case.dart';
import 'package:image_picker/image_picker.dart';

class PrescriptionController extends GetxController {
  PrescriptionController(this.prescription, this.showChildActive, this.takeMedicines, this.prescriptionAdd);
  var responsePrescription = Rx<ResponseDataObject<Prescriptions>?>(null);
  var responseListChild = Rx<ResponseDataObject<ListChildren>?>(null);
  final stt = 0.obs;
  final isLoading = false.obs;
  final isLoading_2 = false.obs;
  final childrenID = 0.obs;
  final childrenIndex = 0.obs;
  final childrenName = "".obs;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  final selectedImagePath = ''.obs;
  final selectedImageSize = ''.obs;
  final selectedImageName = ''.obs;
  final validateName = ''.obs;
  final validateListMedicines = ''.obs;
  final validateGuide = ''.obs;
  final validateNumberOfUses = ''.obs;
  var prescriptionData = RxList<Medicines?>([]);
  final isCreatePrescription = false.obs;

  final PrescriptionUserCase prescription;
  final TakeMedicinesUserCase takeMedicines;
  final ShowChildActiveUserCase showChildActive;
  final PrescriptionAddUserCase prescriptionAdd;

  late TextEditingController listMenicines;
  late TextEditingController guide;
  late TextEditingController numberOfUses;

  @override
  void onInit() {
    listMenicines = TextEditingController(text: '');
    guide = TextEditingController(text: '');
    numberOfUses = TextEditingController(text:'2');

    super.onInit();
  }

  fetchData() async {
    isLoading(true);
    try {
      final response = await prescription.execute();
      responsePrescription.value = response;
      prescriptionData.assignAll(response.data?.medicines ?? []);
    } catch (error) {
      responsePrescription.value?.data?.medicines = [];
    }

    isLoading(false);
  }

  Medicines? get currentData {
    final medicines = responsePrescription.value?.data?.medicines;

    if (medicines != null && medicines.isNotEmpty) {
      if (stt.value >= 0 && stt.value < medicines.length) {
        return medicines[stt.value];
      } else {
        if (stt.value >= medicines.length) {
          stt.value = medicines.length - 1;
        }
      }
    }

    return null;
  }

  listChild() async {
    isLoading_2(true);
    final response = await showChildActive.execute();
    responseListChild.value = response;
    isLoading_2(false);
  }

  takemedicines(
    int? medicine_id,
    String? doing,
    int? child_id,
    int? max,
    BuildContext context,
  ) async {
    try {
      final responseTakeMedicines = await takeMedicines.execute(Tuple4(medicine_id, doing, child_id, max));
      if (responseTakeMedicines.code == 200) {
        if (doing == "medicate") {
          await fetchData();
          showSnackbar(SnackbarType.success, "Thành công", "Cho trẻ uống thuốc thành công!");
        } else {
          await fetchData();
          showSnackbar(SnackbarType.success, "Thành công",  "Hủy đơn thuốc của trẻ thành công!");
        }
      } else {
        showSnackbar(SnackbarType.error, "Thất bại", "Trẻ đã được uống đủ số lần thuốc trong ngày!");
      }
    } catch (error) {
      showSnackbar(SnackbarType.error, "Thất bại", "Cho trẻ uống thuốc thất bại!");
    }
  }

  add(
    BuildContext context,
  ) async {
    if(listMenicines.text == '' || listMenicines.text.length < 10 || guide.text.length < 10 || guide.text == '' || numberOfUses.text == '' || childrenID.value == 0){
      if (listMenicines.text != '' && listMenicines.text.length < 10) {
        validateListMedicines.value = 'Danh sách thuốc phải lớn hơn 10 ký tự';
      } else if(listMenicines.text == '') {
        validateListMedicines.value = 'Vui lòng nhập danh sách thuốc';
      }else{
        validateListMedicines.value = '';
      }
      if (guide.text != '' && guide.text.length < 10) {
        validateGuide.value = 'Hướng dẫn sử dụng phải lớn hơn 10 ký tự';
      } else if(guide.text == '') {
        validateGuide.value = 'Vui lòng nhập hướng dẫn sử dụng';
      }else{
        validateGuide.value = '';
      }
      if (numberOfUses.text == '') {
        validateNumberOfUses.value =  'Vui lòng nhập số lần sử dụng';
      }else{
        validateNumberOfUses.value = '';
      }
      if (childrenID.value == 0) {
        validateName.value = 'Vui lòng chọn học sinh';
      }else{
        validateName.value = '';
      }
    }else{
      isCreatePrescription(true);
      String staterDateFormat = convertDateTimeToString(startDate);
      String endDateFormat = convertDateTimeToString(endDate);
      try {
        final responseAdd = await prescriptionAdd.execute(Tuple6(listMenicines.text, guide.text, numberOfUses.text, staterDateFormat, endDateFormat, childrenID.value));
        if (responseAdd.code == 200) {
          isCreatePrescription(false);
          Get.back();
          listMenicines = TextEditingController();
          guide = TextEditingController();
          numberOfUses = TextEditingController(text: '2');
          startDate = DateTime.now();
          endDate = DateTime.now();
          selectedImagePath.value = '';
          selectedImageSize.value = '';
          selectedImageName.value = '';
          validateGuide.value = '';
          validateListMedicines.value = '';
          validateName.value = '';
          validateNumberOfUses.value = '';
          childrenName.value = '';
          showSnackbar(SnackbarType.success, "Thành công","Tạo đơn thuốc cho học sinh thành công!");
          await fetchData();
        } else {
          showSnackbar(SnackbarType.error, "Thất bại", "Tạo đơn thuốc cho học sinh thất bại!");
          isCreatePrescription(false);
        }
      } catch (error) {
        showSnackbar(SnackbarType.error, "Thất bại", "Tạo đơn thuốc cho học sinh thất bại!");
        isCreatePrescription(false);
      }
    }
  }

  void incrementStt() {
    stt.value++;
  }

  void decreaseStt() {
    stt.value--;
  }

  void getImage(ImageSource imageSource, BuildContext context) async {
    Navigator.pop(context);
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(path: pickedFile.path);
      selectedImagePath.value = rotatedImage.path;
      selectedImageName.value = pickedFile.name;
      selectedImageSize.value = "${(File(selectedImagePath.value).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";
    } else {
      showSnackbar(SnackbarType.notice, "Thất bại", "Ảnh chưa được chọn!");
    }
  }

  void pickImageFromGallery(BuildContext context) async {
    Navigator.pop(context);
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(path: pickedFile.path);
      selectedImagePath.value = rotatedImage.path;
      selectedImageName.value = pickedFile.name;
      selectedImageSize.value = "${(File(selectedImagePath.value).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";
    } else {
      showSnackbar(SnackbarType.notice, "Thất bại", "Ảnh chưa được chọn !");
    }
  }

  void clearImage() {
    selectedImagePath.value = '';
    selectedImageSize.value = '';
  }
}
