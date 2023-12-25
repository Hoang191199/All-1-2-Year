import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/growths.dart';
import 'package:mobiedu_kids/domain/entities/response_data_array_object.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/growth_repository.dart';

class GetGrowthUseCase
    extends ParamUseCase<ResponseDataObject<Growths>, Tuple2<String, String>> {
  GetGrowthUseCase(this.growthRepository);

  final GrowthRepository growthRepository;

  @override
  Future<ResponseDataObject<Growths>> execute(Tuple2 params) {
    return growthRepository.get(params.value1, params.value2);
  }
}

class GetGrowthChildUseCase extends ParamUseCase<ResponseDataObject<Growths>,
    Tuple3<String, String, String>> {
  GetGrowthChildUseCase(this.growthRepository);

  final GrowthRepository growthRepository;

  @override
  Future<ResponseDataObject<Growths>> execute(Tuple3 params) {
    return growthRepository.getChild(
        params.value1, params.value2, params.value3);
  }
}

class AddGrowthUseCase extends ParamUseCase<
    ResponseDataArrayObject<Object>,
    Tuple13<String, String, String, String, String, String, String, String,
        String, String, String, String, Uint8List?>> {
  AddGrowthUseCase(this.growthRepository);

  final GrowthRepository growthRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple13 params) {
    return growthRepository.add(
        params.value1,
        params.value2,
        params.value3,
        params.value4,
        params.value5,
        params.value6,
        params.value7,
        params.value8,
        params.value9,
        params.value10,
        params.value11,
        params.value12,
        params.value13);
  }
}

class EditGrowthUseCase extends ParamUseCase<
    ResponseDataArrayObject<Object>,
    Tuple14<String, String, String, String, String, String, String, String,
        String, String, String, String, String, Uint8List?>> {
  EditGrowthUseCase(this.growthRepository);

  final GrowthRepository growthRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple14 params) {
    return growthRepository.edit(
        params.value1,
        params.value2,
        params.value3,
        params.value4,
        params.value5,
        params.value6,
        params.value7,
        params.value8,
        params.value9,
        params.value10,
        params.value11,
        params.value12,
        params.value13,
        params.value14);
  }
}

// class EditGrowthAltUseCase extends ParamUseCase<
//     ResponseDataArrayObject<Object>,
//     Tuple13<String, String, String, String, String, String, String, String,
//         String, String, String, String, String>> {
//   EditGrowthAltUseCase(this.growthRepository);

//   final GrowthRepository growthRepository;

//   @override
//   Future<ResponseDataArrayObject<Object>> execute(Tuple13 params) {
//     return growthRepository.editalt(
//         params.value1,
//         params.value2,
//         params.value3,
//         params.value4,
//         params.value5,
//         params.value6,
//         params.value7,
//         params.value8,
//         params.value9,
//         params.value10,
//         params.value11,
//         params.value12,
//         params.value13);
//   }
// }

class AddGrowthChildUseCase extends ParamUseCase<
    ResponseDataArrayObject<Object>,
    Tuple12<String, String, String, String, String, String, String, String,
        String, String, String, Uint8List?>> {
  AddGrowthChildUseCase(this.growthRepository);

  final GrowthRepository growthRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple12 params) {
    return growthRepository.addChild(
        params.value1,
        params.value2,
        params.value3,
        params.value4,
        params.value5,
        params.value6,
        params.value7,
        params.value8,
        params.value9,
        params.value10,
        params.value11,
        params.value12);
  }
}

class EditGrowthChildUseCase extends ParamUseCase<
    ResponseDataArrayObject<Object>,
    Tuple13<String, String, String, String, String, String, String, String,
        String, String, String, String, Uint8List?>> {
  EditGrowthChildUseCase(this.growthRepository);

  final GrowthRepository growthRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple13 params) {
    return growthRepository.editChild(
        params.value1,
        params.value2,
        params.value3,
        params.value4,
        params.value5,
        params.value6,
        params.value7,
        params.value8,
        params.value9,
        params.value10,
        params.value11,
        params.value12,
        params.value13);
  }
}

// class EditGrowthAltChildUseCase extends ParamUseCase<
//     ResponseDataArrayObject<Object>,
//     Tuple12<String, String, String, String, String, String, String, String,
//         String, String, String, String>> {
//   EditGrowthAltChildUseCase(this.growthRepository);

//   final GrowthRepository growthRepository;

//   @override
//   Future<ResponseDataArrayObject<Object>> execute(Tuple12 params) {
//     return growthRepository.editaltChild(
//         params.value1,
//         params.value2,
//         params.value3,
//         params.value4,
//         params.value5,
//         params.value6,
//         params.value7,
//         params.value8,
//         params.value9,
//         params.value10,
//         params.value11,
//         params.value12);
//   }
// }

class DeleteGrowthUseCase extends ParamUseCase<ResponseDataObject<Object>,
    Tuple3<String, String, String>> {
  DeleteGrowthUseCase(this.growthRepository);

  final GrowthRepository growthRepository;

  @override
  Future<ResponseDataObject<Object>> execute(Tuple3 params) {
    return growthRepository.delete(params.value1, params.value2, params.value3);
  }
}

class DeleteGrowthChildUseCase
    extends ParamUseCase<ResponseDataObject<Object>, Tuple2<String, String>> {
  DeleteGrowthChildUseCase(this.growthRepository);

  final GrowthRepository growthRepository;

  @override
  Future<ResponseDataObject<Object>> execute(Tuple2 params) {
    return growthRepository.deleteChild(params.value1, params.value2);
  }
}
