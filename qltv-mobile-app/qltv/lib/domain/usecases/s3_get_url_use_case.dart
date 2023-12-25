import 'package:qltv/app/core/usecases/pram_usecase.dart';
import 'package:qltv/domain/entities/object_key_url.dart';
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/repositories/s3_repository.dart';

class S3GetUrlUseCase
    extends ParamUseCase<ResponseDataObject<ObjectKeyUrl>, String> {
  S3GetUrlUseCase(this.s3Repository);

  final S3Repository s3Repository;

  @override
  Future<ResponseDataObject<ObjectKeyUrl>> execute(String params) {
    return s3Repository.preSignedGetUrl(params);
  }
}
