import 'package:qltv/data/providers/network/apis/s3_api.dart';
import 'package:qltv/domain/entities/object_key_url.dart';
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/entities/signed_url.dart';
import 'package:qltv/domain/repositories/s3_repository.dart';

class S3RepositoryImpl extends S3Repository {
  @override
  Future<ResponseDataObject<SignedUrl>> preSignedUrl(
      String mime, String name, int size) async {
    final response = await S3API.preSignedUrl(mime, name, size).request();
    return ResponseDataObject<SignedUrl>.fromJson(
        response, (data) => SignedUrl.fromJson(data));
  }

  @override
  Future<ResponseDataObject<ObjectKeyUrl>> preSignedGetUrl(
      String object_key) async {
    final response = await S3API.preSignedGetUrl(object_key).request();
    return ResponseDataObject<ObjectKeyUrl>.fromJson(
        response, (data) => ObjectKeyUrl.fromJson(data));
  }
}
