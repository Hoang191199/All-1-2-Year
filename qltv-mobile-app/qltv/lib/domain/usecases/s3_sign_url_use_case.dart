import 'package:dartz/dartz.dart';
import 'package:qltv/app/core/usecases/pram_usecase.dart';
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/entities/signed_url.dart';
import 'package:qltv/domain/repositories/s3_repository.dart';

class S3SignUrlUseCase extends ParamUseCase<ResponseDataObject<SignedUrl>,
    Tuple3<String, String, int>> {
  S3SignUrlUseCase(this.s3Repository);

  final S3Repository s3Repository;

  @override
  Future<ResponseDataObject<SignedUrl>> execute(Tuple3 params) {
    return s3Repository.preSignedUrl(
        params.value1, params.value2, params.value3);
  }
}
