import 'package:mobiedu_kids/domain/entities/participant_pc.dart';

class ParticipantCP {
  ParticipantCP({this.child, this.parent});

  ParticipantPC? child;
  ParticipantPC? parent;

  factory ParticipantCP.fromJson(Map<String, dynamic>? json) {
    return ParticipantCP(
      child: json?["child"] == null
          ? null
          : ParticipantPC.fromJson(json?["child"]),
      parent: json?["parent"] == null
          ? null
          : ParticipantPC.fromJson(json?["parent"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "child": child,
        "parent": parent,
      };
}
