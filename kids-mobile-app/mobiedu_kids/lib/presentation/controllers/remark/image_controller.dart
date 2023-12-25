import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobiedu_kids/domain/entities/image_data.dart';
import 'package:mobiedu_kids/presentation/controllers/remark/remark_controller.dart';

class ImageRemarkController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static ImageRemarkController get to => Get.find<ImageRemarkController>();
  final remarkController = Get.find<RemarkController>();
  late XFile? imageFile;
  final ImagePicker picker = ImagePicker();
  late List<XFile>? imageFilecapture;
  final ImagePicker pickercapture = ImagePicker();
  final imageInfo = Rx<ImageData?>(null);
  final loading = false.obs;
  @override
  void onInit() {
    super.onInit();
    imageFile = XFile("");
    imageFilecapture = [];
  }

  changegalleryCert(String groupname, String child) async {
    loading.value = true;
    try{
    final pickFile = await picker.pickImage(source: ImageSource.gallery);
    update();
    final File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(
        path: pickFile?.path ?? "");
    imageFile = XFile(rotatedImage.path);
    var file = await imageFile?.readAsBytes();
    final res = await remarkController.uploadUseCase
        .execute(Tuple3(groupname, file, imageFile?.name));
    if (res.code == 200) {
      imageInfo.value = res.data;
      remarkController.imageInfoDaily.value[child] =
          imageInfo.value ?? ImageData(source_file: "", file_name: "");
    }
    update();
    loading.value = false;
    update();
    }
    catch (e) {
       update();
    loading.value = false;
    update();
    }
  }

  changecameraCert(String groupname, String child) async {
    loading.value = true;
    try{
    final pickFile = await picker.pickImage(source: ImageSource.camera);
    update();
    final File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(
        path: pickFile?.path ?? "");
    imageFile = XFile(rotatedImage.path);
    var file = await imageFile?.readAsBytes();
    final res = await remarkController.uploadUseCase
        .execute(Tuple3(groupname, file, imageFile?.name));
    if (res.code == 200) {
      imageInfo.value = res.data;
      remarkController.imageInfoDaily.value[child] =
          imageInfo.value ?? ImageData(source_file: "", file_name: "");
    }
    update();
    loading.value = false;
    update();
    }
    catch (e) {
       update();
    loading.value = false;
    update();
    }
  }

  quickchangegalleryDailyCert(String groupname) async {
    loading.value = true;
    try{
    final pickFile = await picker.pickImage(source: ImageSource.gallery);
    update();
    final File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(
        path: pickFile?.path ?? "");
    imageFile = XFile(rotatedImage.path);
    var file = await imageFile?.readAsBytes();
    final res = await remarkController.uploadUseCase
        .execute(Tuple3(groupname, file, imageFile?.name));
    if (res.code == 200) {
      imageInfo.value = res.data;
      remarkController.quickImageInfoDaily.value =
          imageInfo.value ?? ImageData(source_file: "", file_name: "");
    }
    update();
    loading.value = false;
    update();
    }
    catch (e) {
       update();
    loading.value = false;
    update();
    }
  }

  quickchangecameraDailyCert(String groupname) async {
    loading.value = true;
    try{
    final pickFile = await picker.pickImage(source: ImageSource.camera);
    update();
    final File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(
        path: pickFile?.path ?? "");
    imageFile = XFile(rotatedImage.path);
    var file = await imageFile?.readAsBytes();
    final res = await remarkController.uploadUseCase
        .execute(Tuple3(groupname, file, imageFile?.name));
    if (res.code == 200) {
      imageInfo.value = res.data;
      remarkController.quickImageInfoDaily.value =
          imageInfo.value ?? ImageData(source_file: "", file_name: "");
    }
    update();
    loading.value = false;
    update();
    }
    catch (e) {
       update();
    loading.value = false;
    update();
    }
  }

  quickchangegalleryMonthlyCert(String groupname) async {
    loading.value = true;
    try{
    final pickFile = await picker.pickImage(source: ImageSource.gallery);
    update();
    final File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(
        path: pickFile?.path ?? "");
    imageFile = XFile(rotatedImage.path);
    var file = await imageFile?.readAsBytes();
    final res = await remarkController.uploadUseCase
        .execute(Tuple3(groupname, file, imageFile?.name));
    if (res.code == 200) {
      imageInfo.value = res.data;
      remarkController.quickImageInfoMonthly.value =
          imageInfo.value ?? ImageData(source_file: "", file_name: "");
    }
    update();
    loading.value = false;
    update();
    }
    catch (e) {
       update();
    loading.value = false;
    update();
    }
  }

  quickchangecameraMonthlyCert(String groupname) async {
    loading.value = true;
    try{
    final pickFile = await picker.pickImage(source: ImageSource.camera);
    update();
    final File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(
        path: pickFile?.path ?? "");
    imageFile = XFile(rotatedImage.path);
    var file = await imageFile?.readAsBytes();
    final res = await remarkController.uploadUseCase
        .execute(Tuple3(groupname, file, imageFile?.name));
    if (res.code == 200) {
      imageInfo.value = res.data;
      remarkController.quickImageInfoMonthly.value =
          imageInfo.value ?? ImageData(source_file: "", file_name: "");
    }
    update();
    loading.value = false;
    update();
    }
    catch (e) {
       update();
    loading.value = false;
    update();
    }
  }

  captureMultigallery(String groupname) async {
    loading.value = true;
    try{
    final pickercp = await pickercapture.pickMultiImage();
    update();
    final List<File> rotatedImage = [];
    for(var i = 0; i < pickercp.length; i++){
      rotatedImage.add(await FlutterExifRotation.rotateAndSaveImage(
        path: pickercp[i].path));
    }
    imageFilecapture = [];
    for(var j = 0; j < pickercp.length; j++){
      imageFilecapture?.add(XFile(rotatedImage[j].path));  
    }
    for(var k = 0; k < pickercp.length; k++){
      var file = await imageFilecapture?[k].readAsBytes();
      final res = await remarkController.uploadUseCase
        .execute(Tuple3(groupname, file, imageFilecapture?[k].name));
      if (res.code == 200) {
      imageInfo.value = res.data;
      remarkController.listMonthlyImage
          .add(imageInfo.value ?? ImageData(source_file: "", file_name: ""));
      }
    }
    update();
    loading.value = false;
    update();
    }
    catch (e) {
       update();
    loading.value = false;
    update();
    }
  }
}
