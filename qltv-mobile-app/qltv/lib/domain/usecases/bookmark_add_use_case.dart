import 'package:dartz/dartz.dart';
import 'package:qltv/app/core/usecases/pram_usecase.dart';
import 'package:qltv/domain/entities/response_no_date.dart';
import 'package:qltv/domain/repositories/bookcase_repository.dart';

class BookmarkAddUseCase extends ParamUseCase<ResponseNoData, Tuple4<int, int, int, String>> {
  BookmarkAddUseCase(this.bookcaseRepository);

  final BookcaseRepository bookcaseRepository;

  @override
  Future<ResponseNoData> execute(Tuple4 params) {
    return bookcaseRepository.addBookmark(params.value1, params.value2, params.value3, params.value4);
  }
}