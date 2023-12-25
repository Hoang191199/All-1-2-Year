import 'package:dartz/dartz.dart';
import 'package:qltv/app/core/usecases/pram_usecase.dart';
import 'package:qltv/domain/entities/response_no_date.dart';
import 'package:qltv/domain/repositories/search_repository.dart';

class RegisterPublicationUseCase extends ParamUseCase<ResponseNoData, Tuple4<int?, int?, String?, String?>> {
  RegisterPublicationUseCase(this.registerPublication);

  final SearchRepository registerPublication;

  @override
  Future<ResponseNoData> execute(Tuple4 params) {
    return registerPublication.register(params.value1, params.value2, params.value3, params.value4);
  }
}
