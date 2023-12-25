import 'package:mooc_app/app/core/usecases/no_param_usecase.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/domain/repositories/search_recommend_repository.dart';

class SearchRCMUseCase extends NoParamUseCase<Course> {
  SearchRCMUseCase(this.searchRCMRepository);

  final SearchRCMRepository searchRCMRepository;

  @override
  Future<Course> execute() {
    return searchRCMRepository.fetchRCMSearch();
  }
}
