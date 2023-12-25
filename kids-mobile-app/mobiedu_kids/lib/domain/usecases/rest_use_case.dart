import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/no_param_usecase.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/entities/rest/rest_data.dart';
import 'package:mobiedu_kids/domain/repositories/rest_repository.dart';

class RestUseCase extends ParamUseCase<ResponseDataObject<RestData>, Tuple2<String, String>> {
  RestUseCase(this.restRepository);

  final RestRepository restRepository;

  @override
  Future<ResponseDataObject<RestData>> execute(Tuple2 params) {
    return restRepository.fetchData(params.value1, params.value2);
  }
}

class RestRegisterUseCase extends NoParamUseCase<ResponseNoData> {
  RestRegisterUseCase(this.restRegisterRepository);

  final RestRepository restRegisterRepository;

  @override
  Future<ResponseNoData> execute() {
    return restRegisterRepository.register();
  }
}
