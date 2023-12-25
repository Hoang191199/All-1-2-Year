import 'package:qltv/app/core/usecases/pram_usecase.dart';
import 'package:qltv/domain/entities/highlight.dart';
import 'package:qltv/domain/entities/response_data_array_object.dart';
import 'package:qltv/domain/repositories/bookcase_repository.dart';

class HighlightListUseCase extends ParamUseCase<ResponseDataArrayObject<Highlight>, int> {
  HighlightListUseCase(this.bookcaseRepository);

  final BookcaseRepository bookcaseRepository;

  @override
  Future<ResponseDataArrayObject<Highlight>> execute(int params) {
    return bookcaseRepository.getListHighlights(params);
  }
}