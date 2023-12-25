

import 'package:mobiedu_kids/domain/entities/event_school_details.dart';

class EventsSchool {
  EventsSchool({
    this.can_edit,
    this.events,
  });
  
  bool? can_edit;
  List<EventsSchoolDetails>? events;
  factory EventsSchool.fromJson(Map<String, dynamic>? json) {
    return EventsSchool(
      can_edit: json?["can_edit"] == null ? null : json?["can_edit"] as bool,
      events: json?["events"] == null
          ? null
          : List<EventsSchoolDetails>.from(json?["events"].map((x) => EventsSchoolDetails.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'can_edit': can_edit,
        'events': events,
      };
}
