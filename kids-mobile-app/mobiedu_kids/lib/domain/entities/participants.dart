import 'package:mobiedu_kids/domain/entities/participant_child_details.dart';

class Participants {
  Participants({
    this.participant,
  });

  List<ParticipantChild>? participant;

  factory Participants.fromJson(Map<String, dynamic>? json) {
    return Participants(
      participant: json?["participant"] == null
          ? null
          : List<ParticipantChild>.from(
              json?["participant"].map((x) => ParticipantChild.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "participant": participant,
      };
}
