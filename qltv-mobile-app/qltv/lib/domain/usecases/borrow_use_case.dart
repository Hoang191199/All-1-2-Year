import 'package:dartz/dartz.dart';
import 'package:qltv/app/core/usecases/pram_usecase.dart';
import 'package:qltv/domain/entities/borrow.dart';
import 'package:qltv/domain/entities/borrow_paging.dart';
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/repositories/borrow_repository.dart';

class BorrowUseCase extends ParamUseCase<ResponseDataObject<BorrowPaging<Borrow>>, Tuple4<int, int, String?, int?>> {
  BorrowUseCase(this.borrowRepository);

  final BorrowRepository borrowRepository;

  @override
  Future<ResponseDataObject<BorrowPaging<Borrow>>> execute(Tuple4 params) {
    return borrowRepository.fetchBorrow(params.value1, params.value2, params.value3, params.value4);
  }
}
