import 'package:qltv/app/core/usecases/pram_usecase.dart';
import 'package:qltv/domain/entities/publication.dart';
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/repositories/home_repository.dart';


class BookDetailUseCase extends ParamUseCase<ResponseDataObject<Publication>, int> {
  BookDetailUseCase(this.homeRepository);

  final HomeRepository homeRepository;

  @override
  Future<ResponseDataObject<Publication>> execute(params) {
    return homeRepository.getbookDetail(params);
  }
  
}
