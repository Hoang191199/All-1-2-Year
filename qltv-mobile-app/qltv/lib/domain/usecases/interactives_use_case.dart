import 'package:qltv/app/core/usecases/pram_usecase.dart';
import 'package:qltv/domain/entities/response_no_date.dart';
import 'package:qltv/domain/repositories/search_repository.dart';


class InteractivesUseCase extends ParamUseCase<ResponseNoData,int> {
  InteractivesUseCase(this.searchRepository);

  final SearchRepository searchRepository;

  @override
  Future<ResponseNoData> execute(params) {
    return searchRepository.seen(params);
  }
}
