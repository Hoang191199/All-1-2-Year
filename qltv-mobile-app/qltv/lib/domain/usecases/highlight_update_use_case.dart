import 'package:dartz/dartz.dart';
import 'package:qltv/app/core/usecases/pram_usecase.dart';
import 'package:qltv/domain/entities/response_no_date.dart';
import 'package:qltv/domain/repositories/bookcase_repository.dart';

class HighlightUpdateUseCase extends ParamUseCase<ResponseNoData, Tuple10<int, String, String, String, String, int, int, int, int, int>> {
  HighlightUpdateUseCase(this.bookcaseRepository);

  final BookcaseRepository bookcaseRepository;

  @override
  Future<ResponseNoData> execute(Tuple10 params) {
    return bookcaseRepository.updateHighlight(params.value1, params.value2, params.value3, params.value4, params.value5, params.value6, params.value7, params.value8, params.value9, params.value10);
  }
}