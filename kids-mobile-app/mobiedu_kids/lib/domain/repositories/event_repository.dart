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

abstract class EventRepository {
  Future<ResponseDataObject<Events<EventsDetails>>> get(
      int page, String group_name);
  Future<ResponseDataObject<Events<EventsChildDetails>>> getChild(
      int page, String child_id);
  Future<ResponseDataObject<Event<EventDetails>>> detail(
      String group_name, String event_id);
  Future<ResponseDataObject<EventsSchool>> getSchool(
      int page, String group_name);
  Future<ResponseDataObject<Event<EventDetails>>> detailSchool(
      String group_name, String event_id);
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
      String for_teacher);
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
      String for_teacher);
  Future<ResponseData> deleteSchool(String group_name, String event_id);
  Future<ResponseDataObject<Participants>> fetchRegister(
    String group_name,
    String event_id,
  );
  Future<ResponseDataObject<ParticipantOld>> saveRegister(
      String group_name,
      String event_id,
      List<String> childId,
      int childNum,
      List<String> parentId,
      int parentNum);
  Future<ResponseDataArrayObject<Object>> saveChildRegister(
    String child_id,
    String event_id,
    String participant_child,
    String participant_parent,
  );
}
