import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:qltv/domain/entities/object_key_url.dart';
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/entities/signed_url.dart';
import 'package:qltv/domain/usecases/s3_get_url_use_case.dart';
import 'package:qltv/domain/usecases/s3_sign_url_use_case.dart';

class S3Controller extends GetxController {
  S3Controller(this.s3GetUrlUseCase, this.s3signUrlUseCase);

  final S3GetUrlUseCase s3GetUrlUseCase;
  final S3SignUrlUseCase s3signUrlUseCase;

  var responseData = Rx<ResponseDataObject<ObjectKeyUrl>?>(null);
  var responseSignData = Rx<ResponseDataObject<SignedUrl>?>(null);
  var s3Data = Rx<ObjectKeyUrl?>(null);
  var signData = Rx<SignedUrl?>(null);

  preSignedUrl(String mime, String name, int size) async {
    final response = await s3signUrlUseCase.execute(Tuple3(mime, name, size));
    responseSignData.value = response;
    signData.value = response.data;
  }

  preSignedGetUrl(String objectKey) async {
    final response = await s3GetUrlUseCase.execute(objectKey);
    responseData.value = response;
    s3Data.value = response.data;
  }
}
