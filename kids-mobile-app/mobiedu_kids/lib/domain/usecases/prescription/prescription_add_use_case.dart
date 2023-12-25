import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/repositories/prescription_repository.dart';

class PrescriptionAddUserCase extends ParamUseCase<ResponseNoData, Tuple6<String?, String? , String? , String? , String? , int? >> {
  PrescriptionAddUserCase(this.prescripAddRepository);

  final PrescriptionRepository prescripAddRepository;

  @override
  Future<ResponseNoData> execute(Tuple6 params) {
    return prescripAddRepository.add(params.value1, params.value2, params.value3, params.value4, params.value5, params.value6);
  }
}
