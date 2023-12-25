import 'package:dartz/dartz.dart';
import 'package:mooc_app/app/core/usecases/no_param_usecase.dart';
import 'package:mooc_app/domain/entities/search.dart';
import 'package:mooc_app/domain/repositories/search_repository.dart';

import '../../app/core/usecases/pram_usecase.dart';

class SearchUseCase extends ParamUseCase<Search, String?> {
  SearchUseCase(this.searchRepository);

  final SearchRepository searchRepository;

  @override
  Future<Search> execute(params) {
    return searchRepository.fetchSearch(params);
  }
}
