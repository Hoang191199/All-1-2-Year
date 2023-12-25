import 'dart:typed_data';

import 'package:mooc_app/domain/entities/response_data_object.dart';
import 'package:mooc_app/domain/entities/s3_final_info.dart';
import 'package:mooc_app/domain/entities/s3_info.dart';

abstract class S3Repository {
  Future<ResponseDataObject<S3Info>> fetchUrl(
      String name, String type, int size);
  Future<ResponseDataObject<S3FinalInfo>> insert(String file);
  Future<ResponseDataObject> upload(
      Uint8List bytes, String urlFile, String type);
}
