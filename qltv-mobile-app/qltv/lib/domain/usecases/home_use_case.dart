import 'package:qltv/app/core/usecases/no_param_usecase.dart';
import 'package:qltv/domain/entities/page.dart';
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/repositories/home_repository.dart';

class HomeUseCase extends NoParamUseCase<ResponseDataObject<Page>> {
  HomeUseCase(this.homeRepository);

  final HomeRepository homeRepository;

  @override
  Future<ResponseDataObject<Page>> execute() {
    return homeRepository.fetchHome();
  }
}
