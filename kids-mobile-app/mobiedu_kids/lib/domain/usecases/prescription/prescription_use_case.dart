import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/no_param_usecase.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/prescription/prescription_data.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/repositories/prescription_repository.dart';

class PrescriptionUserCase extends NoParamUseCase<ResponseDataObject<Prescriptions>> {
  PrescriptionUserCase(this.prescriptionRepository);

  final PrescriptionRepository prescriptionRepository;

  @override
  Future<ResponseDataObject<Prescriptions>> execute() {
    return prescriptionRepository.fetchData();
  }
}

class PrescriptionChildUserCase extends NoParamUseCase<ResponseDataObject<Prescriptions>> {
  PrescriptionChildUserCase(this.prescriptionRepository);

  final PrescriptionRepository prescriptionRepository;

  @override
  Future<ResponseDataObject<Prescriptions>> execute() {
    return prescriptionRepository.getPrescriptionChild();
  }
}

class PrescriptionRegisterUserCase extends ParamUseCase<ResponseNoData, Tuple6<String?, String? , String? , String? , String? , int? >> {
  PrescriptionRegisterUserCase(this.prescripRegisterRepository);

  final PrescriptionRepository prescripRegisterRepository;

  @override
  Future<ResponseNoData> execute(Tuple6 params) {
    return prescripRegisterRepository.register(params.value1, params.value2, params.value3, params.value4, params.value5, params.value6);
  }
}