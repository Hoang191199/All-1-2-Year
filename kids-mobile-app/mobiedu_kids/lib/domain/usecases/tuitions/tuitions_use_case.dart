// import 'package:mobiedu_kids/app/usecases/no_param_usecase.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/tuitions/tuitions.dart';
import 'package:mobiedu_kids/domain/entities/tuitions/tuitions_item.dart';
import 'package:mobiedu_kids/domain/repositories/tuitions_repository.dart';

class TuitionsUserCase extends ParamUseCase<ResponseDataObject<Tuitions>, int> {
  TuitionsUserCase(this.tuitionsRepository);

  final TuitionsRepository tuitionsRepository;

  @override
  Future<ResponseDataObject<Tuitions>> execute(int params) {
    return tuitionsRepository.fetchData(params);
  }
}

class TuitionsParentUseCase extends ParamUseCase<ResponseDataObject<Tuitions>, int> {
  TuitionsParentUseCase(this.tuitionsParentRepository);

  final TuitionsRepository tuitionsParentRepository;

  @override
  Future<ResponseDataObject<Tuitions>> execute(int params) {
    return tuitionsParentRepository.tuitionParent(params);
  }
}

class TuitionsParentDetailUseCase extends ParamUseCase<ResponseDataObject<TuitionItems>, int> {
  TuitionsParentDetailUseCase(this.tuitionsParentDetailRepository);

  final TuitionsRepository tuitionsParentDetailRepository;

  @override
  Future<ResponseDataObject<TuitionItems>> execute(int params) {
    return tuitionsParentDetailRepository.detailTuitionParent(params);
  }
}