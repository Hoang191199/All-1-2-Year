import 'package:mobiedu_kids/domain/entities/journals_info.dart';

class Journals {
  Journals({
    this.journals,
  });

  List<JournalsInfo>? journals;

  factory Journals.fromJson(Map<String, dynamic>? json) {
    return Journals(
      journals: json?['journals'] == null
          ? null
          : List<JournalsInfo>.from(
              json?["journals"].map((x) => JournalsInfo.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'journals': journals,
      };
}
