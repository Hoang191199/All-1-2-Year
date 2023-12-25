import 'package:dartz/dartz.dart';
import 'package:qltv/app/core/usecases/pram_usecase.dart';
import 'package:qltv/domain/entities/bookcase.dart';
import 'package:qltv/domain/entities/response_data_array_object.dart';
import 'package:qltv/domain/repositories/bookcase_repository.dart';

class BookcaseUseCase extends ParamUseCase<ResponseDataArrayObject<Bookcase>, Tuple6<int, int, String, String, String, List<int>>> {
  BookcaseUseCase(this.bookcaseRepository);

  final BookcaseRepository bookcaseRepository;

  @override
  Future<ResponseDataArrayObject<Bookcase>> execute(Tuple6 params) {
    return bookcaseRepository.getListBookcases(params.value1, params.value2, params.value3, params.value4, params.value5, params.value6);
  }
}