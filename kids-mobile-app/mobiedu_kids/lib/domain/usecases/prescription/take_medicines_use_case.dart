import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/repositories/prescription_repository.dart';

class TakeMedicinesUserCase
    extends ParamUseCase<ResponseNoData, Tuple4<int?, String?, int, int>> {
  TakeMedicinesUserCase(this.medicinesRepository);

  final PrescriptionRepository medicinesRepository;

  @override
  Future<ResponseNoData> execute(Tuple4 params) {
    return medicinesRepository.takeMedicines(
        params.value1, params.value2, params.value3, params.value4);
  }
}
