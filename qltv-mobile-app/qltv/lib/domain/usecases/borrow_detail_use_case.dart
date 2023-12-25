import 'package:qltv/app/core/usecases/pram_usecase.dart';
import 'package:qltv/domain/entities/borrow.dart';
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/repositories/borrow_repository.dart';


class BorrowDetailUseCase extends ParamUseCase<ResponseDataObject<Borrow>, int> {
  BorrowDetailUseCase(this.borrowRepository);

  final BorrowRepository borrowRepository;

  @override
  Future<ResponseDataObject<Borrow>> execute(params) {
    return borrowRepository.getBorrowDetail(params);
  }
}
