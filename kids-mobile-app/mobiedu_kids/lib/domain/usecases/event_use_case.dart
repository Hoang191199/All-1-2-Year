import 'package:dartz/dartz.dart';
import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/event.dart';
import 'package:mobiedu_kids/domain/entities/event_details.dart';
import 'package:mobiedu_kids/domain/entities/events.dart';
import 'package:mobiedu_kids/domain/entities/events_child_details.dart';
import 'package:mobiedu_kids/domain/entities/events_details.dart';
import 'package:mobiedu_kids/domain/entities/events_school.dart';
import 'package:mobiedu_kids/domain/entities/participant_old.dart';
import 'package:mobiedu_kids/domain/entities/participants.dart';
import 'package:mobiedu_kids/domain/entities/response_data.dart';
import 'package:mobiedu_kids/domain/entities/response_data_array_object.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/event_repository.dart';

class GetEventUseCase extends ParamUseCase<
    ResponseDataObject<Events<EventsDetails>>, Tuple2<int, String>> {
  GetEventUseCase(this.eventRepository);

  final EventRepository eventRepository;

  @override
  Future<ResponseDataObject<Events<EventsDetails>>> execute(Tuple2 params) {
    return eventRepository.get(params.value1, params.value2);
  }
}

class GetChildEventUseCase extends ParamUseCase<
    ResponseDataObject<Events<EventsChildDetails>>, Tuple2<int, String>> {
  GetChildEventUseCase(this.eventRepository);

  final EventRepository eventRepository;

  @override
  Future<ResponseDataObject<Events<EventsChildDetails>>> execute(
      Tuple2 params) {
    return eventRepository.getChild(params.value1, params.value2);
  }
}

class DetailEventUseCase extends ParamUseCase<
    ResponseDataObject<Event<EventDetails>>, Tuple2<String, String>> {
  DetailEventUseCase(this.eventRepository);

  final EventRepository eventRepository;

  @override
  Future<ResponseDataObject<Event<EventDetails>>> execute(Tuple2 params) {
    return eventRepository.detail(params.value1, params.value2);
  }
}

class GetSchoolEventUseCase extends ParamUseCase<
    ResponseDataObject<EventsSchool>, Tuple2<int, String>> {
  GetSchoolEventUseCase(this.eventRepository);

  final EventRepository eventRepository;

  @override
  Future<ResponseDataObject<EventsSchool>> execute(Tuple2 params) {
    return eventRepository.getSchool(params.value1, params.value2);
  }
}

class DetailSchoolEventUseCase extends ParamUseCase<
    ResponseDataObject<Event<EventDetails>>, Tuple2<String, String>> {
  DetailSchoolEventUseCase(this.eventRepository);

  final EventRepository eventRepository;

  @override
  Future<ResponseDataObject<Event<EventDetails>>> execute(params) {
    return eventRepository.detailSchool(params.value1, params.value2);
  }
}

class CreateSchoolEventUseCase extends ParamUseCase<
    ResponseData,
    Tuple11<String, String, String, String, String, String, String, String,
        String, String, String>> {
  CreateSchoolEventUseCase(this.eventRepository);

  final EventRepository eventRepository;

  @override
  Future<ResponseData> execute(Tuple11 params) {
    return eventRepository.createSchool(
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
        params.value11);
  }
}

class EditSchoolEventUseCase extends ParamUseCase<
    ResponseData,
    Tuple11<String, String, String, String, String, String, String, String,
        String, String, String>> {
  EditSchoolEventUseCase(this.eventRepository);

  final EventRepository eventRepository;

  @override
  Future<ResponseData> execute(Tuple11 params) {
    return eventRepository.editSchool(
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
        params.value11);
  }
}

class DeleteSchoolEventUseCase
    extends ParamUseCase<ResponseData, Tuple2<String, String>> {
  DeleteSchoolEventUseCase(this.eventRepository);

  final EventRepository eventRepository;

  @override
  Future<ResponseData> execute(Tuple2 params) {
    return eventRepository.deleteSchool(params.value1, params.value2);
  }
}

class FetchRegisterUseCase extends ParamUseCase<
    ResponseDataObject<Participants>, Tuple2<String, String>> {
  FetchRegisterUseCase(this.eventRepository);

  final EventRepository eventRepository;

  @override
  Future<ResponseDataObject<Participants>> execute(Tuple2 params) {
    return eventRepository.fetchRegister(params.value1, params.value2);
  }
}

class SaveRegisterUseCase extends ParamUseCase<
    ResponseDataObject<ParticipantOld>,
    Tuple6<String, String, List<String>, int, List<String>, int>> {
  SaveRegisterUseCase(this.eventRepository);

  final EventRepository eventRepository;

  @override
  Future<ResponseDataObject<ParticipantOld>> execute(Tuple6 params) {
    return eventRepository.saveRegister(params.value1, params.value2,
        params.value3, params.value4, params.value5, params.value6);
  }
}

class SaveChildRegisterUseCase extends ParamUseCase<
    ResponseDataArrayObject<Object>, Tuple4<String, String, String, String>> {
  SaveChildRegisterUseCase(this.eventRepository);

  final EventRepository eventRepository;

  @override
  Future<ResponseDataArrayObject<Object>> execute(Tuple4 params) {
    return eventRepository.saveChildRegister(
        params.value1, params.value2, params.value3, params.value4);
  }
}
