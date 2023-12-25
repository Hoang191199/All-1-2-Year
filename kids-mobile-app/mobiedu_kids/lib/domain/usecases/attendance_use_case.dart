import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/no_param_usecase.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/attendance/attendace.dart';
import 'package:mobiedu_kids/domain/entities/attendance/listChild.dart';
import 'package:mobiedu_kids/domain/entities/attendance/upload.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/response_no_data.dart';
import 'package:mobiedu_kids/domain/repositories/attendance_repository.dart';

class AttendanceUserCase extends ParamUseCase<ResponseDataObject<Attendance>, Tuple2<String, String>> {
  AttendanceUserCase(this.attendanceRepository);

  final AttendanceRepository attendanceRepository;

  @override
  Future<ResponseDataObject<Attendance>> execute(Tuple2 params) {
    return attendanceRepository.fetchData(params.value1, params.value2);
  }
}

class UploadImageUserCase extends ParamUseCase<ResponseDataObject<Upload>, int?> {
  UploadImageUserCase(this.uploadImageRepository);

  final AttendanceRepository uploadImageRepository;

  @override
  Future<ResponseDataObject<Upload>> execute(params) {
    return uploadImageRepository.uploadImage(params);
  }
}

class UpdateUserCase extends NoParamUseCase<ResponseNoData> {
  UpdateUserCase(this.updateRepository);

  final AttendanceRepository updateRepository;

  @override
  Future<ResponseNoData> execute() {
    return updateRepository.update();
  }
}

class UpdateCheckOutUserCase extends NoParamUseCase<ResponseNoData> {
  UpdateCheckOutUserCase(this.updateCheckOutRepository);

  final AttendanceRepository updateCheckOutRepository;

  @override
  Future<ResponseNoData> execute() {
    return updateCheckOutRepository.updateCheckOut();
  }
}

class HygieneUserCase extends NoParamUseCase<ResponseDataObject<ListChild>> {
  HygieneUserCase(this.hygieneRepository);

  final AttendanceRepository hygieneRepository;

  @override
  Future<ResponseDataObject<ListChild>> execute() {
    return hygieneRepository.getHygiene();
  }
}

class UpdateHygieneUserCase extends NoParamUseCase<ResponseNoData> {
  UpdateHygieneUserCase(this.updateHygieneRepository);

  final AttendanceRepository updateHygieneRepository;

  @override
  Future<ResponseNoData> execute() {
    return updateHygieneRepository.updateHygiene();
  }
}

class SleepUserCase extends NoParamUseCase<ResponseDataObject<ListChild>> {
  SleepUserCase(this.sleepRepository);

  final AttendanceRepository sleepRepository;

  @override
  Future<ResponseDataObject<ListChild>> execute() {
    return sleepRepository.getSleep();
  }
}

class UpdateSleepUserCase extends NoParamUseCase<ResponseNoData> {
  UpdateSleepUserCase(this.updateSleepRepository);

  final AttendanceRepository updateSleepRepository;

  @override
  Future<ResponseNoData> execute() {
    return updateSleepRepository.updateSleep();
  }
}

class ConFirmUserCase extends ParamUseCase<ResponseNoData, Tuple3<String, String, String>> {
  ConFirmUserCase(this.conFirmRepository);

  final AttendanceRepository conFirmRepository;

  @override
  Future<ResponseNoData> execute(Tuple3 params) {
    return conFirmRepository.confirm(params.value1, params.value2, params.value3);
  }
}
