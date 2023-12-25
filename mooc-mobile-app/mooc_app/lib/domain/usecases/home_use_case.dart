import 'package:mooc_app/app/core/usecases/no_param_usecase.dart';
import 'package:mooc_app/domain/entities/home.dart';
import 'package:mooc_app/domain/repositories/home_repository.dart';

class HomeUseCase extends NoParamUseCase<Home> {
  HomeUseCase(this.homeRepository);

  final HomeRepository homeRepository;

  @override
  Future<Home> execute() {
    return homeRepository.fetchHome();
  }
}
