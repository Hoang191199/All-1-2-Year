import 'package:qltv/app/core/usecases/pram_usecase.dart';
import 'package:qltv/domain/entities/bookmark.dart';
import 'package:qltv/domain/entities/response_data_array_object.dart';
import 'package:qltv/domain/repositories/bookcase_repository.dart';

class BookmarkListUseCase extends ParamUseCase<ResponseDataArrayObject<Bookmark>, int> {
  BookmarkListUseCase(this.bookcaseRepository);

  final BookcaseRepository bookcaseRepository;

  @override
  Future<ResponseDataArrayObject<Bookmark>> execute(int params) {
    return bookcaseRepository.getListBookmarks(params);
  }
}