import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/feedbacks.dart';
import 'package:mobiedu_kids/domain/entities/response_data_array_object.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/feedback_repository.dart';

class FbCreateUseCase extends ParamUseCase<ResponseDataArrayObject<Object>,
    Tuple3<String, String, String>> {
  FbCreateUseCase(this.fbRepository);

  final FbRepository fbRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple3 params) {
    return fbRepository.create(params.value1, params.value2, params.value3);
  }
}

class FbGetUseCase
    extends ParamUseCase<ResponseDataObject<FeedBacks>, Tuple2<int, String>> {
  FbGetUseCase(this.fbRepository);

  final FbRepository fbRepository;

  @override
  Future<ResponseDataObject<FeedBacks>> execute(Tuple2 params) {
    return fbRepository.get(params.value1, params.value2);
  }
}

class FbConfirmUseCase
    extends ParamUseCase<ResponseDataObject<Object>, Tuple2<String, String>> {
  FbConfirmUseCase(this.fbRepository);

  final FbRepository fbRepository;

  @override
  Future<ResponseDataObject<Object>> execute(Tuple2 params) {
    return fbRepository.confirm(params.value1, params.value2);
  }
}

class FbDeleteUseCase
    extends ParamUseCase<ResponseDataObject<Object>, Tuple2<String, String>> {
  FbDeleteUseCase(this.fbRepository);

  final FbRepository fbRepository;

  @override
  Future<ResponseDataObject<Object>> execute(Tuple2 params) {
    return fbRepository.delete(params.value1, params.value2);
  }
}

class FbDeleteAllUseCase
    extends ParamUseCase<ResponseDataObject<Object>, String> {
  FbDeleteAllUseCase(this.fbRepository);

  final FbRepository fbRepository;

  @override
  Future<ResponseDataObject<Object>> execute(params) {
    return fbRepository.deleteAll(params);
  }
}
