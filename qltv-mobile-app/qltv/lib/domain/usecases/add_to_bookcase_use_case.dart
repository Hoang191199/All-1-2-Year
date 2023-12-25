import 'package:qltv/app/core/usecases/pram_usecase.dart';
import 'package:qltv/domain/entities/response_no_date.dart';
import 'package:qltv/domain/repositories/search_repository.dart';

class AddToBookCaseUseCase extends ParamUseCase<ResponseNoData, int> {
  AddToBookCaseUseCase(this.addToBookCase);

  final SearchRepository addToBookCase;

  @override
  Future<ResponseNoData> execute(params) {
    return addToBookCase.add(params);
  }
}
