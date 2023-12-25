import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/domain/entities/prescription/medicines.dart';
import 'package:mobiedu_kids/domain/entities/prescription/prescription_data.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/usecases/prescription/prescription_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_controller.dart';

class PrescriptionChildController extends GetxController {
  PrescriptionChildController(this.prescription, this.prescriptionRegister);
  var responsePrescription = Rx<ResponseDataObject<Prescriptions>?>(null);
  final isLoading = false.obs;
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


  final PrescriptionChildUserCase prescription;
  final PrescriptionRegisterUserCase prescriptionRegister;


  late TextEditingController listMenicines;
  late TextEditingController guide;
  late TextEditingController numberOfUses;

  final spashControlller = Get.find<SplashScreenController>();

  @override
  void onInit() {
    listMenicines = TextEditingController();
    guide = TextEditingController();
    numberOfUses = TextEditingController(text:'2');

    super.onInit();
  }


  fetchData() async {
    isLoading(true);
      try{
        final response = await prescription.execute();
        responsePrescription.value = response;
        prescriptionData.assignAll(response.data?.medicines ?? []);
      }catch(error) {
        showSnackbar(SnackbarType.notice, "Thất bại", "Bạn không có quyền truy cập. Vui lòng thử lại!");
      }
    isLoading(false);
  }

  register(
    BuildContext context,
  ) async {
    if(listMenicines.text == '' || listMenicines.text.length < 10 || guide.text.length < 10 || guide.text == '' || numberOfUses.text == ''){
      if (listMenicines.text != '' && listMenicines.text.length < 10) {
        validateListMedicines.value = 'Danh sách thuốc phải lớn hơn 10 ký tự';
      } else if (listMenicines.text == '') {
        validateListMedicines.value = 'Vui lòng nhập danh sách thuốc';
      } else {
        validateListMedicines.value = '';
      }
      if (guide.text != '' && guide.text.length < 10) {
        validateGuide.value = 'Hướng dẫn sử dụng phải lớn hơn 10 ký tự';
      } else if (guide.text == '') {
        validateGuide.value = 'Vui lòng nhập hướng dẫn sử dụng';
      } else {
        validateGuide.value = '';
      }
      if (numberOfUses.text == '') {
        validateNumberOfUses.value = 'Vui lòng nhập số lần sử dụng';
      } else {
        validateNumberOfUses.value = '';
      }
    }else{
      isCreatePrescription(true);
      String staterDateFormat = convertDateTimeToString(startDate);
      String endDateFormat = convertDateTimeToString(endDate);
      try {
        final responseAdd = await prescriptionRegister.execute(Tuple6(listMenicines.text, guide.text, numberOfUses.text, staterDateFormat, endDateFormat, int.parse(spashControlller.childId.value)));
        if (responseAdd.code == 200) {
          isCreatePrescription(false);
          Get.back();
          listMenicines = TextEditingController();
          guide = TextEditingController();
          startDate = DateTime.now();
          endDate = DateTime.now();
          selectedImagePath.value = '';
          selectedImageSize.value = '';
          selectedImageName.value = '';
          validateGuide.value = '';
          validateListMedicines.value = '';
          validateName.value = '';
          validateNumberOfUses.value = '';
          showSnackbar(SnackbarType.success, "Thành công","Tạo đơn thuốc thành công!");
          await fetchData();
        } else {
          showSnackbar(SnackbarType.error, "Thất bại", "Tạo đơn thuốc thất bại!");
          isCreatePrescription(false);
        }
      } catch (error) {
        showSnackbar(SnackbarType.error, "Thất bại", "Tạo đơn thuốc thất bại!");
        isCreatePrescription(false);
      }
    }
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
