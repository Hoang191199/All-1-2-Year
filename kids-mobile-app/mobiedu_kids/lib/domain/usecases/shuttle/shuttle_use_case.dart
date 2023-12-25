import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/no_param_usecase.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/assign_in_shuttle.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/classes_in_shuttle.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/history.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/list_child.dart';
import 'package:mobiedu_kids/domain/entities/shuttle/shuttle.dart';
import 'package:mobiedu_kids/domain/repositories/shuttle_repositiory.dart';

class ShuttleUserCase extends NoParamUseCase<ResponseDataObject<Shuttle>> {
  ShuttleUserCase(this.shuttleRepository);

  final ShuttleRepository shuttleRepository;

  @override
  Future<ResponseDataObject<Shuttle>> execute() {
    return shuttleRepository.fetchData();
  }
}

class PickUpUserCase extends ParamUseCase<ResponseNoData, Tuple2<int, int>> {
  PickUpUserCase(this.pickUpRepository);

  final ShuttleRepository pickUpRepository;

  @override
  Future<ResponseNoData> execute(Tuple2 params) {
    return pickUpRepository.pickUp(params.value1, params.value2);
  }
}

class SavePickUpUserCase extends ParamUseCase<ResponseNoData, Tuple9<int, int, String? , int? , String? , String? , List<String>?, int?, String?>> {
  SavePickUpUserCase(this.savePickUpRepository);

  final ShuttleRepository savePickUpRepository;

  @override
  Future<ResponseNoData> execute(Tuple9 params) {
    return savePickUpRepository.savePickup(params.value1, params.value2,
      params.value3,params.value4,params.value5,params.value6,params.value7, params.value8, params.value9);
  }
}


class CancelPickUpUserCase extends ParamUseCase<ResponseNoData, Tuple2<int, int>> {
  CancelPickUpUserCase(this.cancelPickUpRepository);

  final ShuttleRepository cancelPickUpRepository;

  @override
  Future<ResponseNoData> execute(Tuple2 params) {
    return cancelPickUpRepository.cancel(params.value1, params.value2);
  }
}

class ListClassUserCase extends NoParamUseCase<ResponseDataObject<ClassesInShuttle>> {
  ListClassUserCase(this.listClassRepository);

  final ShuttleRepository listClassRepository;

  @override
  Future<ResponseDataObject<ClassesInShuttle>> execute() {
    return listClassRepository.listClass();
  }
}

class ListChildUserCase extends NoParamUseCase<ResponseDataObject<ListChild>> {
  ListChildUserCase(this.listChildRepository);

  final ShuttleRepository listChildRepository;

  @override
  Future<ResponseDataObject<ListChild>> execute() {
    return listChildRepository.listChild();
  }
}

class AddChildUserCase extends NoParamUseCase<ResponseNoData> {
  AddChildUserCase(this.addChildRepository);

  final ShuttleRepository addChildRepository;

  @override
  Future<ResponseNoData> execute() {
    return addChildRepository.addChild();
  }
}

class AssignUserCase extends NoParamUseCase<ResponseDataObject<AssignInShuttle>> {
  AssignUserCase(this.listChildRepository);

  final ShuttleRepository listChildRepository;

  @override
  Future<ResponseDataObject<AssignInShuttle>> execute() {
    return listChildRepository.assign();
  }
}

class HistoryUserCase extends NoParamUseCase<ResponseDataObject<History>> {
  HistoryUserCase(this.historyRepository);

  final ShuttleRepository historyRepository;

  @override
  Future<ResponseDataObject<History>> execute() {
    return historyRepository.history();
  }
}