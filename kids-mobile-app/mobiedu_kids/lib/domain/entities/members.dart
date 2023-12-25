import 'package:mobiedu_kids/domain/entities/members_info.dart';

class Members {
  Members({
    this.members,
  });

  List<MembersInfo>? members;

  factory Members.fromJson(Map<String, dynamic>? json) {
    return Members(
      members: json?['members'] == null
          ? null
          : List<MembersInfo>.from(
              json?["members"].map((x) => MembersInfo.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'members': members,
      };
}
