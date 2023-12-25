import 'package:mooc_app/domain/entities/order.dart';
import 'package:mooc_app/domain/entities/response_data_object.dart';
import 'package:mooc_app/domain/entities/s3_final_info.dart';
import 'package:mooc_app/domain/repositories/s3_repository.dart';

import '../../app/core/usecases/pram_usecase.dart';

class S3InsertUseCase
    extends ParamUseCase<ResponseDataObject<S3FinalInfo>, String> {
  S3InsertUseCase(this.s3Repository);

  final S3Repository s3Repository;

  @override
  Future<ResponseDataObject<S3FinalInfo>> execute(params) {
    return s3Repository.insert(params);
  }
}
