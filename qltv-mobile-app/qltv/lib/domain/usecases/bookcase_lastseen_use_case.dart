import 'package:qltv/app/core/usecases/no_param_usecase.dart';
import 'package:qltv/domain/entities/bookcase.dart';
import 'package:qltv/domain/entities/response_data_array_object.dart';
import 'package:qltv/domain/repositories/bookcase_repository.dart';

class BookcaseLastseenUseCase extends NoParamUseCase<ResponseDataArrayObject<Bookcase>> {
  BookcaseLastseenUseCase(this.bookcaseRepository);

  final BookcaseRepository bookcaseRepository;

  @override
  Future<ResponseDataArrayObject<Bookcase>> execute() {
    return bookcaseRepository.getBookcasesLastseen();
  }
}
