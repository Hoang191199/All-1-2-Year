import 'package:dartz/dartz.dart';
import 'package:mooc_app/domain/entities/order.dart';
import 'package:mooc_app/domain/entities/response_data_object.dart';
import 'package:mooc_app/domain/entities/s3_info.dart';
import 'package:mooc_app/domain/repositories/s3_repository.dart';

import '../../app/core/usecases/pram_usecase.dart';
import '../entities/course_list.dart';
import '../repositories/order_history_repository.dart';

class S3UrlUseCase extends ParamUseCase<ResponseDataObject<S3Info>,
    Tuple3<String, String, int>> {
  S3UrlUseCase(this.s3Repository);

  final S3Repository s3Repository;

  @override
  Future<ResponseDataObject<S3Info>> execute(Tuple3 params) {
    return s3Repository.fetchUrl(params.value1, params.value2, params.value3);
  }
}
