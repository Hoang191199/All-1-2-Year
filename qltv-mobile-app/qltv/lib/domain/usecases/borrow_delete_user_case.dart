import 'package:qltv/app/core/usecases/pram_usecase.dart';
import 'package:qltv/domain/entities/response_no_date.dart';
import 'package:qltv/domain/repositories/borrow_repository.dart';

class BorrowDeleteUseCase extends ParamUseCase<ResponseNoData, int> {
  BorrowDeleteUseCase(this.deleteBorrow);

  final BorrowRepository deleteBorrow;

  @override
  Future<ResponseNoData> execute(params) {
    return deleteBorrow.deleteBorrow(params);
  }
}
