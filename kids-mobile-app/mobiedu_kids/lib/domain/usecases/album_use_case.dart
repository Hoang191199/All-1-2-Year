import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/journal.dart';
import 'package:mobiedu_kids/domain/entities/journals.dart';
import 'package:mobiedu_kids/domain/entities/response_data_array_object.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/album_repository.dart';

class GetAlbumUseCase extends ParamUseCase<ResponseDataObject<Journals>,
    Tuple3<String, String, int>> {
  GetAlbumUseCase(this.albumRepository);

  final AlbumRepository albumRepository;

  @override
  Future<ResponseDataObject<Journals>> execute(Tuple3 params) {
    return albumRepository.get(params.value1, params.value2, params.value3);
  }
}

class DetailAlbumUseCase
    extends ParamUseCase<ResponseDataObject<Journal>, Tuple2<String, String>> {
  DetailAlbumUseCase(this.albumRepository);

  final AlbumRepository albumRepository;

  @override
  Future<ResponseDataObject<Journal>> execute(Tuple2 params) {
    return albumRepository.detail(params.value1, params.value2);
  }
}

class AddAlbumUseCase extends ParamUseCase<ResponseDataArrayObject<Object>,
    Tuple5<String, String, String, List<Uint8List?>, int>> {
  AddAlbumUseCase(this.albumRepository);

  final AlbumRepository albumRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple5 params) {
    return albumRepository.add(params.value1, params.value2, params.value3,
        params.value4, params.value5);
  }
}

class AddPhotoUseCase extends ParamUseCase<ResponseDataArrayObject<Object>,
    Tuple5<String, String, String, List<Uint8List?>, int>> {
  AddPhotoUseCase(this.albumRepository);

  final AlbumRepository albumRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple5 params) {
    return albumRepository.addPhoto(params.value1, params.value2, params.value3,
        params.value4, params.value5);
  }
}

class EditCaptionUseCase extends ParamUseCase<ResponseDataArrayObject<Object>,
    Tuple4<String, String, String, int>> {
  EditCaptionUseCase(this.albumRepository);

  final AlbumRepository albumRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple4 params) {
    return albumRepository.editCaption(
        params.value1, params.value2, params.value3, params.value4);
  }
}

class DeletePhotoUseCase extends ParamUseCase<ResponseDataArrayObject<Object>,
    Tuple3<String, String, String>> {
  DeletePhotoUseCase(this.albumRepository);

  final AlbumRepository albumRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple3 params) {
    return albumRepository.deletePhoto(
        params.value1, params.value2, params.value3);
  }
}

class DeleteAlbumUseCase extends ParamUseCase<ResponseDataArrayObject<Object>,
    Tuple3<String, String, String>> {
  DeleteAlbumUseCase(this.albumRepository);

  final AlbumRepository albumRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple3 params) {
    return albumRepository.deleteAlbum(
        params.value1, params.value2, params.value3);
  }
}

class GetAlbumChildUseCase
    extends ParamUseCase<ResponseDataObject<Journals>, Tuple2<String, int>> {
  GetAlbumChildUseCase(this.albumRepository);

  final AlbumRepository albumRepository;

  @override
  Future<ResponseDataObject<Journals>> execute(Tuple2 params) {
    return albumRepository.getChild(params.value1, params.value2);
  }
}

class DetailAlbumChildUseCase
    extends ParamUseCase<ResponseDataObject<Journal>, Tuple2<String, String>> {
  DetailAlbumChildUseCase(this.albumRepository);

  final AlbumRepository albumRepository;

  @override
  Future<ResponseDataObject<Journal>> execute(Tuple2 params) {
    return albumRepository.detailChild(params.value1, params.value2);
  }
}

class AddAlbumChildUseCase extends ParamUseCase<ResponseDataArrayObject<Object>,
    Tuple4<String, String, List<Uint8List?>, int>> {
  AddAlbumChildUseCase(this.albumRepository);

  final AlbumRepository albumRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple4 params) {
    return albumRepository.addChild(
        params.value1, params.value2, params.value3, params.value4);
  }
}

class AddPhotoChildUseCase extends ParamUseCase<ResponseDataArrayObject<Object>,
    Tuple4<String, String, List<Uint8List?>, int>> {
  AddPhotoChildUseCase(this.albumRepository);

  final AlbumRepository albumRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple4 params) {
    return albumRepository.addPhotoChild(
        params.value1, params.value2, params.value3, params.value4);
  }
}

class EditCaptionChildUseCase extends ParamUseCase<
    ResponseDataArrayObject<Object>, Tuple3<String, String, int>> {
  EditCaptionChildUseCase(this.albumRepository);

  final AlbumRepository albumRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple3 params) {
    return albumRepository.editCaptionChild(
        params.value1, params.value2, params.value3);
  }
}

class DeletePhotoChildUseCase extends ParamUseCase<
    ResponseDataArrayObject<Object>, Tuple2<String, String>> {
  DeletePhotoChildUseCase(this.albumRepository);

  final AlbumRepository albumRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple2 params) {
    return albumRepository.deletePhotoChild(params.value1, params.value2);
  }
}

class DeleteAlbumChildUseCase extends ParamUseCase<
    ResponseDataArrayObject<Object>, Tuple2<String, String>> {
  DeleteAlbumChildUseCase(this.albumRepository);

  final AlbumRepository albumRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple2 params) {
    return albumRepository.deleteAlbumChild(params.value1, params.value2);
  }
}
