import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/data/providers/network/apis/event_api.dart';
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

class EventRepositoryImpl extends EventRepository {
  @override
  Future<ResponseDataObject<Events<EventsDetails>>> get(
      int page, String group_name) async {
    final response = await EventAPI.get(page, group_name).request();
    return ResponseDataObject<Events<EventsDetails>>.fromJson(
        response,
        (data) => Events<EventsDetails>.fromJson(
            data, (d) => EventsDetails.fromJson(d)));
  }

  @override
  Future<ResponseDataObject<Events<EventsChildDetails>>> getChild(
      int page, String child_id) async {
    final response = await EventAPI.getChild(page, child_id).request();
    return ResponseDataObject<Events<EventsChildDetails>>.fromJson(
        response,
        (data) => Events<EventsChildDetails>.fromJson(
            data, (d) => EventsChildDetails.fromJson(d)));
  }

  @override
  Future<ResponseDataObject<Event<EventDetails>>> detail(
      String group_name, String event_id) async {
    final response = await EventAPI.detail(group_name, event_id).request();
    return ResponseDataObject<Event<EventDetails>>.fromJson(
        response,
        (data) => Event<EventDetails>.fromJson(
            data, (d) => EventDetails.fromJson(d)));
  }

  @override
  Future<ResponseDataObject<EventsSchool>> getSchool(
      int page, String group_name) async {
    final response = await EventAPI.getSchool(page, group_name).request();
    return ResponseDataObject<EventsSchool>.fromJson(
        response, (data) => EventsSchool.fromJson(data));
  }

  @override
  Future<ResponseDataObject<Event<EventDetails>>> detailSchool(
      String group_name, String event_id) async {
    final response =
        await EventAPI.detailSchool(group_name, event_id).request();
    return ResponseDataObject<Event<EventDetails>>.fromJson(
        response,
        (data) => Event<EventDetails>.fromJson(
            data, (d) => EventDetails.fromJson(d)));
  }

  @override
  Future<ResponseData> createSchool(
      String group_name,
      String event_id,
      String event_level,
      String event_name,
      String post_on_wall,
      String notify_immediately,
      String description,
      String must_register,
      String for_parent,
      String for_child,
      String for_teacher) async {
    final response = await EventAPI.createSchool(
            group_name,
            event_id,
            event_level,
            event_name,
            post_on_wall,
            notify_immediately,
            description,
            must_register,
            for_parent,
            for_child,
            for_teacher)
        .request();
    return ResponseData.fromJson(response, DataType.typeObject);
  }

  @override
  Future<ResponseData> editSchool(
      String group_name,
      String event_id,
      String event_level,
      String event_name,
      String post_on_wall,
      String notify_immediately,
      String description,
      String must_register,
      String for_parent,
      String for_child,
      String for_teacher) async {
    final response = await EventAPI.editSchool(
            group_name,
            event_id,
            event_level,
            event_name,
            post_on_wall,
            notify_immediately,
            description,
            must_register,
            for_parent,
            for_child,
            for_teacher)
        .request();
    return ResponseData.fromJson(response, DataType.typeObject);
  }

  @override
  Future<ResponseData> deleteSchool(String group_name, String event_id) async {
    final response =
        await EventAPI.deleteSchool(group_name, event_id).request();
    return ResponseData.fromJson(response, DataType.typeObject);
  }

  @override
  Future<ResponseDataObject<Participants>> fetchRegister(
      String group_name, String event_id) async {
    final response =
        await EventAPI.fetchRegister(group_name, event_id).request();
    return ResponseDataObject.fromJson(
        response, (data) => Participants.fromJson(data));
  }

  @override
  Future<ResponseDataObject<ParticipantOld>> saveRegister(
      String group_name,
      String event_id,
      List<String> childId,
      int childNum,
      List<String> parentId,
      int parentNum) async {
    final response = await EventAPI.saveRegister(
            group_name, event_id, childId, childNum, parentId, parentNum)
        .request();
    return ResponseDataObject<ParticipantOld>.fromJson(
        response, (data) => ParticipantOld.fromJson(data));
  }

  @override
  Future<ResponseDataArrayObject<Object>> saveChildRegister(
    String child_id,
    String event_id,
    String participant_child,
    String participant_parent,
  ) async {
    final response = await EventAPI.saveChildRegister(
            child_id, event_id, participant_child, participant_parent)
        .request();
    return ResponseDataArrayObject<Object>.fromJson(response, (data) => Object);
  }
}
