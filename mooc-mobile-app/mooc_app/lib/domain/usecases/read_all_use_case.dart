import '../../app/core/usecases/no_param_usecase.dart';
import '../entities/read_all_response.dart';
import '../repositories/read_repository.dart';

class ReadAllUseCase extends NoParamUseCase<ReadAll> {
  ReadAllUseCase(this.readAllRepository);

  final ReadRepository  readAllRepository;

  @override
  Future<ReadAll> execute() {
    return readAllRepository.fetchReadAll();
  }
}
