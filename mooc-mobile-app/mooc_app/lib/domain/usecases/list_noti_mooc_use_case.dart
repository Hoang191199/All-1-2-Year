import 'package:dartz/dartz.dart';
import 'package:mooc_app/app/core/usecases/pram_usecase.dart';
import 'package:mooc_app/domain/entities/list_noti_mooc.dart';
import 'package:mooc_app/domain/repositories/list_noti_mooc_repository.dart';

class ListNotiMoocUseCase extends ParamUseCase<ListNotiMooc, Tuple2<int, int>> {
  ListNotiMoocUseCase(this.listNotiMoocRepository);

  final ListNotiMoocRepository listNotiMoocRepository;

  @override
  Future<ListNotiMooc> execute(Tuple2 params) {
    return listNotiMoocRepository.fetchNoti(params.value1, params.value2);
  }
}
