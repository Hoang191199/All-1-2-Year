import 'package:dartz/dartz.dart';
import 'package:qltv/app/core/usecases/pram_usecase.dart';
import '../entities/mid_array_data.dart';
import '../entities/noti_data.dart';
import '../entities/response_data_object.dart';
import '../repositories/noti_repository.dart';

class NotiUseCase extends ParamUseCase<ResponseDataObject<MidArrayData<NotiData>>, Tuple2<int , int>> {
  NotiUseCase(this.notiRepository);

  final NotiRepository notiRepository;

  @override
  Future<ResponseDataObject<MidArrayData<NotiData>>> execute(params) {
    return notiRepository.fetchNoti(params.value1,params.value2);
  }
}
