import 'dart:typed_data';

import 'package:mooc_app/data/providers/network/apis/put_file_s3_api.dart';
import 'package:mooc_app/data/providers/network/apis/s3_get_url_api.dart';
import 'package:mooc_app/data/providers/network/apis/s3_insert_api.dart';
import 'package:mooc_app/domain/entities/response_data_object.dart';
import 'package:mooc_app/domain/entities/s3_final_info.dart';
import 'package:mooc_app/domain/entities/s3_info.dart';
import 'package:mooc_app/domain/repositories/s3_repository.dart';

class S3RepositoryImpl extends S3Repository {
  @override
  Future<ResponseDataObject<S3Info>> fetchUrl(
      String name, String type, int size) async {
    final response = await S3GetUrlAPI.fetchUrl(name, type, size).request();
    print(response);
    return ResponseDataObject<S3Info>.fromJson(
        response, (data) => S3Info.fromJson(data));
  }

  @override
  Future<ResponseDataObject<S3FinalInfo>> insert(String file) async {
    final response = await InsertInfoAPI.insert(file).request();
    print(response);
    return ResponseDataObject<S3FinalInfo>.fromJson(
        response, (data) => S3FinalInfo.fromJson(data));
  }

  @override
  Future<ResponseDataObject> upload(
      Uint8List bytes, String urlFile, String type) async {
    final response = await S3PutAPI.upload(bytes, urlFile, type).request();
    print(response);
    return ResponseDataObject<S3FinalInfo>.fromJson(
        response, (data) => S3FinalInfo.fromJson(data));
  }
}
