import 'package:qltv/app/core/usecases/pram_usecase.dart';
import 'package:qltv/domain/entities/response_no_date.dart';
import 'package:qltv/domain/repositories/bookcase_repository.dart';

class BookmarkDeleteUseCase extends ParamUseCase<ResponseNoData, int> {
  BookmarkDeleteUseCase(this.bookcaseRepository);

  final BookcaseRepository bookcaseRepository;

  @override
  Future<ResponseNoData> execute(int params) {
    return bookcaseRepository.deleteBookmark(params);
  }
}