import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/tuitions/tuitions_item.dart';
import 'package:mobiedu_kids/domain/repositories/tuitions_repository.dart';

class TuitionsItemUserCase extends ParamUseCase<ResponseDataObject<TuitionItems>, int> {
  TuitionsItemUserCase(this.tuitionsItemRepository);

  final TuitionsRepository tuitionsItemRepository;

  @override
  Future<ResponseDataObject<TuitionItems>> execute(int params) {
    return tuitionsItemRepository.itemTuitions(params);
  }
}
