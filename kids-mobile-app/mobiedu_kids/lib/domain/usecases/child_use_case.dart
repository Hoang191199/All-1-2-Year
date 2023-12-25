import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/child.dart';
import 'package:mobiedu_kids/domain/entities/child_basic_info.dart';
import 'package:mobiedu_kids/domain/entities/child_list.dart';
import 'package:mobiedu_kids/domain/entities/overview.dart';
import 'package:mobiedu_kids/domain/entities/parent_details.dart';
import 'package:mobiedu_kids/domain/entities/picker_info.dart';
import 'package:mobiedu_kids/domain/entities/response_data_array_object.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/child_repository.dart';

class GetChildUseCase
    extends ParamUseCase<ResponseDataObject<ChildList>, String> {
  GetChildUseCase(this.childRepository);

  final ChildRepository childRepository;

  @override
  Future<ResponseDataObject<ChildList>> execute(params) {
    return childRepository.get(params);
  }
}

class DetailChildUseCase
    extends ParamUseCase<ResponseDataObject<Child>, Tuple2<String, String>> {
  DetailChildUseCase(this.childRepository);

  final ChildRepository childRepository;

  @override
  Future<ResponseDataObject<Child>> execute(Tuple2 params) {
    return childRepository.detail(params.value1, params.value2);
  }
}

class DetailChildParentUseCase
    extends ParamUseCase<ResponseDataObject<ChildBasicInfo>, String> {
  DetailChildParentUseCase(this.childRepository);

  final ChildRepository childRepository;

  @override
  Future<ResponseDataObject<ChildBasicInfo>> execute(params) {
    return childRepository.detail_parent(params);
  }
}

class AddChildUseCase extends ParamUseCase<
    ResponseDataArrayObject<Object>,
    Tuple17<
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        List<String>,
        int>> {
  AddChildUseCase(this.childRepository);

  final ChildRepository childRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple17 params) {
    return childRepository.add(
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
        params.value14,
        params.value15,
        params.value16,
        params.value17);
  }
}

class EditChildUseCase extends ParamUseCase<
    ResponseDataArrayObject<Object>,
    Tuple18<
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        String,
        List<String>,
        int>> {
  EditChildUseCase(this.childRepository);

  final ChildRepository childRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple18 params) {
    return childRepository.edit(
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
        params.value14,
        params.value15,
        params.value16,
        params.value17,
        params.value18);
  }
}

class EditChildParentUseCase extends ParamUseCase<
    ResponseDataArrayObject<Object>,
    Tuple16<String, String, String, String, String, String, String, String,
        String, String, String, String, String, String, List<String>, int>> {
  EditChildParentUseCase(this.childRepository);

  final ChildRepository childRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple16 params) {
    return childRepository.edit_parent(
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
        params.value14,
        params.value15,
        params.value16);
  }
}

class UploadAvatarUseCase extends ParamUseCase<ResponseDataArrayObject<Object>,
    Tuple2<String, Uint8List>> {
  UploadAvatarUseCase(this.childRepository);

  final ChildRepository childRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple2 params) {
    return childRepository.upload(params.value1, params.value2);
  }
}

class OverViewUseCase extends ParamUseCase<ResponseDataObject<OverView>,
    String> {
  OverViewUseCase(this.childRepository);

  final ChildRepository childRepository;

  @override
  Future<ResponseDataObject<OverView>> execute(params) {
    return childRepository.overview(params);
  }
}

// class SearchChildUseCase
//     extends ParamUseCase<ResponseDataObject<Growths>, Tuple2<String, String>> {
//   SearchChildUseCase(this.childRepository);

//   final ChildRepository childRepository;

//   @override
//   Future<ResponseDataObject<Growths>> execute(Tuple2 params) {
//     return childRepository.search(params.value1, params.value2);
//   }
// }

// class SearchDiaryUseCase extends ParamUseCase<ResponseDataObject<Journals>,
//     Tuple3<String, String, int>> {
//   SearchDiaryUseCase(this.childRepository);

//   final ChildRepository childRepository;

//   @override
//   Future<ResponseDataObject<Journals>> execute(Tuple3 params) {
//     return childRepository.searchDiary(
//         params.value1, params.value2, params.value3);
//   }
// }

// class AddGrowthUseCase extends ParamUseCase<ResponseDataArrayObject<Object>,
//     Tuple4<String, String, String, Uint8List>> {
//   AddGrowthUseCase(this.childRepository);

//   final ChildRepository childRepository;

//   @override
//   Future<ResponseDataArrayObject<Object>> execute(Tuple4 params) {
//     return childRepository.addGrowth(
//         params.value1, params.value2, params.value3, params.value4);
//   }
// }

// class AddPhotoUseCase extends ParamUseCase<ResponseDataArrayObject<Object>,
//     Tuple4<String, String, String, Uint8List>> {
//   AddPhotoUseCase(this.childRepository);

//   final ChildRepository childRepository;

//   @override
//   Future<ResponseDataArrayObject<Object>> execute(Tuple4 params) {
//     return childRepository.addPhoto(
//         params.value1, params.value2, params.value3, params.value4);
//   }
// }

class InfoChildUseCase extends ParamUseCase<ResponseDataArrayObject<PickerInfo>,
    Tuple2<String, String>> {
  InfoChildUseCase(this.childRepository);

  final ChildRepository childRepository;

  @override
  Future<ResponseDataArrayObject<PickerInfo>> execute(Tuple2 params) {
    return childRepository.infomation(params.value1, params.value2);
  }
}

class SearchUserUseCase extends ParamUseCase<
    ResponseDataArrayObject<ParentDetails>,
    Tuple4<String, String, List<String>, int>> {
  SearchUserUseCase(this.childRepository);

  final ChildRepository childRepository;

  @override
  Future<ResponseDataArrayObject<ParentDetails>> execute(Tuple4 params) {
    return childRepository.searchUser(
        params.value1, params.value2, params.value3, params.value4);
  }
}

class SearchCodeUseCase
    extends ParamUseCase<ResponseDataObject<Child>, Tuple2<String, String>> {
  SearchCodeUseCase(this.childRepository);

  final ChildRepository childRepository;

  @override
  Future<ResponseDataObject<Child>> execute(Tuple2 params) {
    return childRepository.searchCode(params.value1, params.value2);
  }
}
