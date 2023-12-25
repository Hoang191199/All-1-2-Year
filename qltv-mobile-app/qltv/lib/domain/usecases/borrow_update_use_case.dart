import 'package:dartz/dartz.dart';
import 'package:qltv/app/core/usecases/pram_usecase.dart';
import 'package:qltv/domain/entities/response_no_date.dart';
import 'package:qltv/domain/repositories/borrow_repository.dart';

class BorrowUpdateUseCase extends ParamUseCase<ResponseNoData, Tuple6<int, String?, String, String, String, String?>> {
  BorrowUpdateUseCase(this.updateBorrow);

  final BorrowRepository updateBorrow;

  @override
  Future<ResponseNoData> execute(Tuple6 params) {
    return updateBorrow.updateBorrow(params.value1, params.value2, params.value3, params.value4, params.value5, params.value6);
  }
}
