import 'package:dartz/dartz.dart';
import 'package:qltv/app/core/usecases/pram_usecase.dart';
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/entities/search.dart';
import 'package:qltv/domain/entities/search_paging.dart';
import 'package:qltv/domain/repositories/search_repository.dart';

class SearchUseCase extends ParamUseCase<ResponseDataObject<SearchPaging<Search>>, Tuple5< String?, String?, String?, int?, int?>> {
  SearchUseCase(this.searchRepository);

  final SearchRepository searchRepository;

  @override
  Future<ResponseDataObject<SearchPaging<Search>>> execute(Tuple5 params) {
    return searchRepository.fetch(params.value1, params.value2, params.value3, params.value4, params.value5);
  }
}
