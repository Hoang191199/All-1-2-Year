import 'package:dartz/dartz.dart';
import 'package:qltv/app/core/usecases/pram_usecase.dart';
import 'package:qltv/domain/entities/response_no_date.dart';
import 'package:qltv/domain/repositories/bookcase_repository.dart';

class BookcaseProgressUseCase extends ParamUseCase<ResponseNoData, Tuple8<int, int, String, int, String, int, int, int>> {
  BookcaseProgressUseCase(this.bookcaseRepository);

  final BookcaseRepository bookcaseRepository;

  @override
  Future<ResponseNoData> execute(Tuple8 params) {
    return bookcaseRepository.sentProgressRead(params.value1, params.value2, params.value3, params.value4, params.value5, params.value6, params.value7, params.value8);
  }
}