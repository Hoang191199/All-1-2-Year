import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:mooc_app/domain/entities/order.dart';
import 'package:mooc_app/domain/entities/response_data_object.dart';
import 'package:mooc_app/domain/entities/s3_final_info.dart';
import 'package:mooc_app/domain/repositories/s3_repository.dart';

import '../../app/core/usecases/pram_usecase.dart';

class S3PutUseCase extends ParamUseCase<ResponseDataObject,
    Tuple3<Uint8List, String, String>> {
  S3PutUseCase(this.s3Repository);

  final S3Repository s3Repository;

  @override
  Future<ResponseDataObject> execute(Tuple3 params) {
    return s3Repository.upload(params.value1, params.value2, params.value3);
  }
}
