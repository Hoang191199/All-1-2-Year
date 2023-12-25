import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static ImageController get to => Get.find<ImageController>();
  late XFile? imageFile;
  final ImagePicker picker = ImagePicker();
  @override
  void onInit() {
    super.onInit();
    imageFile = XFile("");
  }

  changecameraAvatar() async {
    final pickFile = await picker.pickImage(source: ImageSource.camera);
    imageFile = pickFile;
    update();
  }

  changegalleryAvatar() async {
    final pickFile = await picker.pickImage(source: ImageSource.gallery);
    imageFile = pickFile;
    update();
  }
}
