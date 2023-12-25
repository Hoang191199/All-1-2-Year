import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/entities/schedule.dart';
import 'package:mobiedu_kids/domain/entities/schedule_child.dart';
import 'package:mobiedu_kids/domain/entities/schedule_class.dart';
import 'package:mobiedu_kids/domain/entities/schedule_details.dart';
import 'package:mobiedu_kids/domain/entities/schedule_history.dart';
import 'package:mobiedu_kids/domain/entities/schedule_more_details.dart';
import 'package:mobiedu_kids/domain/entities/schedule_school_details.dart';
import 'package:mobiedu_kids/domain/repositories/schedule_repository.dart';

class GetScheduleUseCase
    extends ParamUseCase<ResponseDataObject<ScheduleClass>, String> {
  GetScheduleUseCase(this.scheduleRepository);

  final ScheduleRepository scheduleRepository;

  @override
  Future<ResponseDataObject<ScheduleClass>> execute(params) {
    return scheduleRepository.get(params);
  }
}

class GetScheduleChildUseCase
    extends ParamUseCase<ResponseDataObject<ScheduleChild>, String> {
  GetScheduleChildUseCase(this.scheduleRepository);

  final ScheduleRepository scheduleRepository;

  @override
  Future<ResponseDataObject<ScheduleChild>> execute(params) {
    return scheduleRepository.getChild(params);
  }
}

class ViewScheduleUseCase extends ParamUseCase<
    ResponseDataObject<ScheduleHistory>, Tuple2<int, String>> {
  ViewScheduleUseCase(this.scheduleRepository);

  final ScheduleRepository scheduleRepository;

  @override
  Future<ResponseDataObject<ScheduleHistory>> execute(Tuple2 params) {
    return scheduleRepository.view(params.value1, params.value2);
  }
}

class DetailScheduleUseCase extends ParamUseCase<
    ResponseDataObject<ScheduleDetails<ScheduleMoreDetails>>,
    Tuple2<String, String>> {
  DetailScheduleUseCase(this.scheduleRepository);

  final ScheduleRepository scheduleRepository;

  @override
  Future<ResponseDataObject<ScheduleDetails<ScheduleMoreDetails>>> execute(
      Tuple2 params) {
    return scheduleRepository.detail(params.value1, params.value2);
  }
}

class ViewScheduleChildUseCase extends ParamUseCase<
    ResponseDataObject<ScheduleHistory>, Tuple2<int, String>> {
  ViewScheduleChildUseCase(this.scheduleRepository);

  final ScheduleRepository scheduleRepository;

  @override
  Future<ResponseDataObject<ScheduleHistory>> execute(Tuple2 params) {
    return scheduleRepository.viewChild(params.value1, params.value2);
  }
}

class DetailScheduleChildUseCase extends ParamUseCase<
    ResponseDataObject<ScheduleDetails<ScheduleMoreDetails>>,
    Tuple2<String, String>> {
  DetailScheduleChildUseCase(this.scheduleRepository);

  final ScheduleRepository scheduleRepository;

  @override
  Future<ResponseDataObject<ScheduleDetails<ScheduleMoreDetails>>> execute(
      Tuple2 params) {
    return scheduleRepository.detailChild(params.value1, params.value2);
  }
}

class SchoolListScheduleUseCase
    extends ParamUseCase<ResponseDataObject<Schedule>, String> {
  SchoolListScheduleUseCase(this.scheduleRepository);

  final ScheduleRepository scheduleRepository;

  @override
  Future<ResponseDataObject<Schedule>> execute(params) {
    return scheduleRepository.schoolList(params);
  }
}

class SchoolDetailScheduleUseCase extends ParamUseCase<
    ResponseDataObject<ScheduleDetails<ScheduleSchoolDetails>>,
    Tuple2<String, String>> {
  SchoolDetailScheduleUseCase(this.scheduleRepository);

  final ScheduleRepository scheduleRepository;

  @override
  Future<ResponseDataObject<ScheduleDetails<ScheduleSchoolDetails>>> execute(
      params) {
    return scheduleRepository.schoolDetail(params.value1, params.value2);
  }
}
