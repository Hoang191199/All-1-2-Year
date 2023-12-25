import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/tuitions/tuition_childs.dart';
import 'package:mobiedu_kids/domain/repositories/tuitions_repository.dart';

class TuitionsDetailUserCase extends ParamUseCase<ResponseDataObject<TuitionChilds>, int> {
  TuitionsDetailUserCase(this.tuitionsDetailRepository);

  final TuitionsRepository tuitionsDetailRepository;

  @override
  Future<ResponseDataObject<TuitionChilds>> execute(int params) {
    return tuitionsDetailRepository.detail(params);
  }
}
