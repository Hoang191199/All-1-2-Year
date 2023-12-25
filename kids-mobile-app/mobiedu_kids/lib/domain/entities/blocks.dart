import 'package:mobiedu_kids/domain/entities/members_info.dart';

class Blocks {
  Blocks({
    this.blocks,
  });

  List<MembersInfo>? blocks;

  factory Blocks.fromJson(Map<String, dynamic>? json) {
    return Blocks(
      blocks: json?["blocks"] == null
          ? null
          : List<MembersInfo>.from(
              json?["blocks"].map((x) => MembersInfo.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'blocks': blocks,
      };
}
