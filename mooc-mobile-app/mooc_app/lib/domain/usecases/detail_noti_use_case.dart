import 'package:mooc_app/app/core/usecases/pram_usecase.dart';
import 'package:mooc_app/domain/entities/detail_noti.dart';

import '../repositories/detail_noti_repository.dart';

class DetailNotiUseCase extends ParamUseCase<DetailNoti, String> {
  DetailNotiUseCase(this.detailNotiRepository);

  final DetailNotiRepository detailNotiRepository;

  @override
  Future<DetailNoti> execute(params) {
    return detailNotiRepository.fetchNoti(params);
  }
}
