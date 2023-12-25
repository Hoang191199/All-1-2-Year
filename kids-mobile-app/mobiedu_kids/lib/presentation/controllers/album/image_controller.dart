import 'dart:io';

import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';

class ImageAlbumController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static ImageAlbumController get to => Get.find<ImageAlbumController>();
  // final childController = Get.find<ChildController>();
  // late XFile? imageFile;
  final listfile = RxList<XFile>([]);
  final ImagePicker picker = ImagePicker();
  final loading = false.obs;
  final reloading = false.obs;
  @override
  void onInit() {
    super.onInit();
    // imageFile = XFile("");
  }

  // capturecamera() async {
  //   final pickercp = await picker.pickImage(source: ImageSource.camera);
  //   imageFile = pickercp;
  //   update();
  // }

  capturegallery() async {
    loading.value = true;
    listfile.value = [];
    final pickercp = await picker.pickMultiImage();
    if (pickercp.length < 9) {
      for (var i = 0; i < pickercp.length; i++) {
        final File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(
            path: pickercp[i].path);
        listfile.add(XFile(rotatedImage.path));
      }
    } else {
      showSnackbar(SnackbarType.notice, "Không cho phép",
          "Tối đa chỉ cho phép tải lên 8 ảnh mỗi lần");
    }
    update();
    loading.value = false;
  }
}
