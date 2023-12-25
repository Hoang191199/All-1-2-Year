import 'dart:io';

import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageChildController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static ImageChildController get to => Get.find<ImageChildController>();
  // final childController = Get.find<ChildController>();
  late XFile? imageFile;
  final ImagePicker picker = ImagePicker();
  final loading = false.obs;
  final reloading = false.obs;
  @override
  void onInit() {
    super.onInit();
    imageFile = XFile("");
  }

  capturecamera(String groupname) async {
    loading.value = true;
    // update();
    // try{
    final pickercp = await picker.pickImage(source: ImageSource.camera);
    final File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(
        path: pickercp?.path ?? "");
    imageFile = XFile(rotatedImage.path);
    loading.value = false;
    update();
    // }
    // catch(e){
    //   loading.value = false;
    // update();
    // }
  }

  capturegallery(String groupname) async {
    loading.value = true;
    // update();
    // try{
    final pickercp = await picker.pickImage(source: ImageSource.gallery);
    final File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(
        path: pickercp?.path ?? "");
    imageFile = XFile(rotatedImage.path);
    loading.value = false;
    update();
    // }
    // catch(e){
    //   loading.value = false;
    // update();
    // }
  }

  resetImageFile() {
    imageFile = null;
    update();
  }
}
