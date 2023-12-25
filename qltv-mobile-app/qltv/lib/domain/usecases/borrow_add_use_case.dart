import 'package:dartz/dartz.dart';
import 'package:qltv/app/core/usecases/pram_usecase.dart';
import 'package:qltv/domain/entities/response_no_date.dart';
import 'package:qltv/domain/repositories/borrow_repository.dart';

class BorrowAddUseCase extends ParamUseCase<ResponseNoData, Tuple5<String?, String, String, String, String?>> {
  BorrowAddUseCase(this.addBorrow);

  final BorrowRepository addBorrow;

  @override
  Future<ResponseNoData> execute(Tuple5 params) {
    return addBorrow.add(params.value1, params.value2, params.value3, params.value4, params.value5);
  }
}
