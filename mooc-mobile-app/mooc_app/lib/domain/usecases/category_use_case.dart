import 'package:dartz/dartz.dart';
import 'package:mooc_app/app/core/usecases/pram_usecase.dart';
import 'package:mooc_app/domain/entities/category_response.dart';
import 'package:mooc_app/domain/repositories/category_repository.dart';

class CategoryUseCase extends ParamUseCase<CategoryResponse, Tuple2<int, int>> {
  CategoryUseCase(this.categoryRepository);

  final CategoryRepository categoryRepository;

  @override
  Future<CategoryResponse> execute(Tuple2 params) {
    return categoryRepository.fetchCategory(params.value1, params.value2);
  }
}
