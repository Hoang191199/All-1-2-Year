import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qltv/presentation/controllers/login/login_controller.dart';
import 'package:qltv/presentation/controllers/profile/profile_controller.dart';
import 'package:qltv/presentation/controllers/s3/s3_controller.dart';
import 'package:qltv/presentation/controllers/text_profile_controller.dart';

class ImageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static ImageController get to => Get.find<ImageController>();
  final login = Get.find<LoginController>();
  final s3 = Get.find<S3Controller>();
  final tex = Get.put(TextUpdateProfileController());
  final profile = Get.find<ProfileController>();
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
    Navigator.of(context).pop();
    final siteId = login.userLogin?.default_site_id;
    final pickFile = await picker.pickImage(source: ImageSource.camera);
    imageFile = pickFile;
    if (imageFile?.path != "" && imageFile != null) {
      Uint8List? bytes = await imageFile?.readAsBytes();
      await s3.preSignedUrl(imageFile?.mimeType ?? "image/jpeg", "avatar.jpg",
          bytes?.lengthInBytes ?? 10000);
      Map<String, String> headers = {
        'x-site-id': '$siteId',
        'Content-Type': imageFile?.mimeType ?? "image/jpeg"
      };
      final res = await http.put(
          Uri.parse(s3.responseSignData.value?.data?.url ?? ""),
          body: bytes,
          headers: headers);
      if (res.statusCode == 200 && s3.responseSignData.value?.error == false) {
        List<String> avatar =
            s3.responseSignData.value?.data?.url?.split('?') ?? [""];
        await profile.updateProfile(
            tex.nameText.text,
            tex.emailText.text,
            tex.phoneText.text,
            tex.dobText.text,
            int.parse(tex.genderText.text).toInt(),
            "",
            avatar[0]);
      } else {}
    }
    update();
    isLoading(false);
  }

  changegalleryAvatar(BuildContext context) async {
    isLoading(true);
    Navigator.of(context).pop();
    final siteId = login.userLogin?.default_site_id;
    final pickFile = await picker.pickImage(source: ImageSource.gallery);
    imageFile = pickFile;
    if (imageFile?.path != "" && imageFile != null) {
      Uint8List? bytes = await imageFile?.readAsBytes();
      await s3.preSignedUrl(imageFile?.mimeType ?? "image/jpeg", "avatar.jpg",
          bytes?.lengthInBytes ?? 10000);
      Map<String, String> headers = {
        'x-site-id': '$siteId',
        'Content-Type': imageFile?.mimeType ?? "image/jpeg"
      };
      final res = await http.put(
          Uri.parse(s3.responseSignData.value?.data?.url ?? ""),
          body: bytes,
          headers: headers);
      if (res.statusCode == 200 && s3.responseSignData.value?.error == false) {
        List<String> avatar =
            s3.responseSignData.value?.data?.url?.split('?') ?? [""];
        await profile.updateProfile(
            tex.nameText.text,
            tex.emailText.text,
            tex.phoneText.text,
            tex.dobText.text,
            int.parse(tex.genderText.text).toInt(),
            "",
            avatar[0]);
      } else {}
    }
    update();
    isLoading(false);
  }
}
