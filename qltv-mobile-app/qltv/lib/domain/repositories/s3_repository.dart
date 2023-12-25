import 'package:qltv/domain/entities/object_key_url.dart';
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/entities/signed_url.dart';

abstract class S3Repository {
  Future<ResponseDataObject<ObjectKeyUrl>> preSignedGetUrl(String object_key);
  Future<ResponseDataObject<SignedUrl>> preSignedUrl(
      String mime, String name, int size);
}
