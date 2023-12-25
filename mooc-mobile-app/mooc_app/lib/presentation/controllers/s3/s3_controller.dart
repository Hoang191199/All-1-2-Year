import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:mooc_app/domain/usecases/put_file_s3_use_case.dart';
import 'package:mooc_app/domain/usecases/s3_insert_use_case.dart';
import 'package:mooc_app/domain/usecases/s3_url_use_case.dart';
import 'package:mooc_app/presentation/controllers/text_update_controller.dart';

class S3Controller extends GetxController {
  // S3Controller(this.s3urlUseCase, this.s3insertUseCase);
  S3Controller(this.s3urlUseCase, this.s3putUseCase, this.s3insertUseCase);
  final tex = Get.put(TextUpdateProfileController());
  final S3UrlUseCase s3urlUseCase;
  final S3PutUseCase s3putUseCase;
  final S3InsertUseCase s3insertUseCase;

  final isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  uploadS3(String name, Uint8List? bytes, String? mimeType) async {
    var mime = lookupMimeType('', headerBytes: bytes);
    var extension = extensionFromMime(mime ?? ".jpng");
    final res1 = await s3urlUseCase
        .execute(Tuple3(name, mimeType ?? extension, bytes?.lengthInBytes));
    Map<String, String> headers = {
      'Content-type': mimeType ?? extension,
      'x-amz-acl': 'public-read',
    };
    await http.put(Uri.parse(res1.data?.url ?? ""),
        body: bytes, headers: headers);
    // dio request
    // dio.options.headers['Content-Type'] = mimeType ?? extension;
    // dio.options.headers['x-amz-acl'] = 'public-read';
    // await dio.put(res1.data?.url ?? "", data: bytes);
    // flutter request
    // final res2 = await s3putUseCase
    //     .execute(Tuple3(bytes, res1.data?.url, mimeType ?? extension));
    final res3 = await s3insertUseCase.execute(res1.data?.id ?? "");
    tex.avatarText.text = res3.data?.url ?? "";
    update();
  }
}
