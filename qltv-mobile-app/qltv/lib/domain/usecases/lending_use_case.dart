import 'package:qltv/domain/entities/lend_mid_data.dart';
import '../../app/core/usecases/no_param_usecase.dart';
import '../entities/mid_array_data.dart';
import '../entities/response_data_object.dart';
import '../repositories/lending_repository.dart';

class LendingUseCase extends NoParamUseCase<ResponseDataObject<MidArrayData<LendingMidData>>> {
  LendingUseCase(this.lendingRepository);

  final LendingRepository lendingRepository;

  @override
  Future<ResponseDataObject<MidArrayData<LendingMidData>>> execute() {
    return lendingRepository.fetchLending();
  }
}
