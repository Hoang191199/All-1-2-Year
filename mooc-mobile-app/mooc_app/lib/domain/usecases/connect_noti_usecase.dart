import 'package:mooc_app/app/core/usecases/pram_usecase.dart';
import 'package:mooc_app/domain/entities/response_data.dart';

import '../repositories/connect_noti_repository.dart';

class ConnectNotiUseCase extends ParamUseCase<ResponseData, String> {
  ConnectNotiUseCase(this.connectNotiRepository);

  final  ConnectNotiRepository connectNotiRepository;

  @override
  Future<ResponseData> execute(params) {
    return connectNotiRepository.fetchConnectNoti(params);
  }
}
