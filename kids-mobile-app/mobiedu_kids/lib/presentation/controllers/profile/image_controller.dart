import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static ImageController get to => Get.find<ImageController>();
  // final profile = Get.find<ProfileController>();
  late XFile? imageFile;
  final ImagePicker picker = ImagePicker();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    imageFile = XFile("");
  }

  changecameraAvatar(BuildContext context) async {
    isLoading(true);
    update();
    final pickFile = await picker.pickImage(source: ImageSource.camera);
    final File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(
        path: pickFile?.path ?? "");
    imageFile = XFile(rotatedImage.path);
    update();
    isLoading(false);
    update();
  }

  changegalleryAvatar(BuildContext context) async {
    isLoading(true);
    update();
    final pickFile = await picker.pickImage(source: ImageSource.gallery);
    final File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(
        path: pickFile?.path ?? "");
    imageFile = XFile(rotatedImage.path);
    update();
    isLoading(false);
    update();
  }
}
